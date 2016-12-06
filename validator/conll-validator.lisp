;;;; conll-validator.lisp

(in-package #:conll-validator)

;; update with the absolute path to validate.py
(defparameter *ud-tools* nil)

(hunchentoot:define-easy-handler (validate-ud-handler :uri "/validate-ud") (file)
  (setf (hunchentoot:content-type*) "text/plain")
  (with-output-to-string (s)
   (inferior-shell:run (format nil "~a --lang=pt_bosque ~a" *ud-tools* (first file)) :on-error nil :error-output s)))

(hunchentoot:define-easy-handler (validate-handler :uri "/validate") (file)
  (flet ((validate-sentence (s)
           (let ((h (make-hash-table :test #'equal)))
             (setf (gethash "id" h) (cl-conllu:sentence-meta-value s "sent_id"))
             (setf (gethash "valid" h)  (cl-conllu:sentence-valid? s))
             h)))
    (setf (hunchentoot:content-type*) "application/json")
    (let ((sentences (cl-conllu:read-conllu (first file))))
      (if sentences
          (yason:with-output-to-string* ()
            (yason:with-array ()
              (dolist (s sentences)
                (yason:encode-array-element (validate-sentence s)))))
          (yason:encode-plist '(:error "invalid file"))))))

(defun start-server (&optional (port 5000))
  (hunchentoot:start
   (make-instance 'hunchentoot:easy-acceptor
		  :port port)))
