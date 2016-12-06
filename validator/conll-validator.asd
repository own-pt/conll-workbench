;;;; conll-validator.asd

(asdf:defsystem #:conll-validator
  :description "web service to validate CONLL-U files."
  :author "Fabricio Chalub <fcbrbr@gmail.com>"
  :license "see LICENSE"
  :serial t
  :depends-on (#:cl-conllu #:hunchentoot #:inferior-shell #:yason #:alexandria)
  :components ((:file "package")
               (:file "conll-validator")))

