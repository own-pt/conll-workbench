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

(asdf:defsystem #:conll-validator
  :description "web service to validate CONLL-U files."
  :author "Fabricio Chalub <fchalub@br.ibm.com> and Alexandre Rademaker <alexrad@br.ibm.com>"
  :version "0.1"
  :license "see LICENSE"
  :serial t
  :depends-on (#:cl-conllu #:hunchentoot #:inferior-shell #:yason #:alexandria)
  :components ((:file "package")
               (:file "conll-validator")))

