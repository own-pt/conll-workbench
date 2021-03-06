;; Copyright 2016 IBM

;; Licensed under the Apache License, Version 2.0 (the "License");
;; you may not use this file except in compliance with the License.
;; You may obtain a copy of the License at

;;     http://www.apache.org/licenses/LICENSE-2.0

;; Unless required by applicable law or agreed to in writing, software
;; distributed under the License is distributed on an "AS IS" BASIS,
;; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
;; See the License for the specific language governing permissions and
;; limitations under the License.

(in-package #:conll-validator)

;; update with the absolute path to validate.py
(defparameter *ud-tools* nil)

(defun validate-ud (file lang)
  (with-output-to-string (s)
    (inferior-shell:run (format nil "~a --lang=~a ~a" *ud-tools* lang file) :on-error nil :error-output s)
    s))

(defun validate-conll (file)
  (flet ((validate-sentence (s)
           (let ((h (make-hash-table :test #'equal)))
             (setf (gethash "id" h) (cl-conllu:sentence-meta-value s "sent_id"))
             (setf (gethash "valid" h)  (cl-conllu:sentence-valid? s))
             h)))))

;; sample invokation curl -F "file=@CP9.conllu" -F "lang=pt_bosque" http://localhost:5000/validate-ud
(hunchentoot:define-easy-handler (validate-ud-handler :uri "/validate-ud") (file lang)
  (setf (hunchentoot:content-type*) "text/plain")
  (validate-ud (first file) lang))

(defun read-file-to-string (f)
  (with-output-to-string (s)
    (let ((c 0))
     (with-open-file (stream f)
       (do ((line (read-line stream nil)
                  (read-line stream nil)))
           ((null line))
         (format s "{~4d} ~a~%" (incf c) line))))
    s))

(hunchentoot:define-easy-handler (form-handler :uri "/form") (file lang)
  (setf (hunchentoot:content-type*) "text/html")
  (with-html-output-to-string (*standard-output* nil :prologue t)
    (:html
     (:head (:title "CoNLL-U validator"))
     (:body (:h1 "CoNLL-U validator")
            (:p "Please select a file to submit for validation.")
            (:form :action "/form" :method "POST" :enctype "multipart/form-data" 
                   (:input :type "hidden" :name "lang" :value "pt_bosque")
                   (:input :type "file" :name "file")
                   (:input :type "submit"))
            (when file
              (htm
               (:p (str (format nil "Validation results [~a]:" (second file))))
               (:pre (str (validate-ud (first file) lang)))
               (:p "CoNLL contents:")
               (:pre (str (read-file-to-string (first file))))))))))
                 
(hunchentoot:define-easy-handler (validate-handler :uri "/validate") (file)
  (setf (hunchentoot:content-type*) "application/json")
  (let ((sentences (cl-conllu:read-conllu (first file))))
    (if sentences
        (yason:with-output-to-string* ()
          (yason:with-array ()
            (dolist (s sentences)
              (yason:encode-array-element (validate-sentence s)))))
        (yason:encode-plist '(:error "invalid file")))))

(defun start-server (&optional (port 5000))
  (hunchentoot:start
   (make-instance 'hunchentoot:easy-acceptor
		  :port port)))

