#!/bin/bash

#send ENTER to confirm add to init file
echo | sbcl --script setup-quicklisp.lisp
pushd /root/quicklisp/local-projects
git clone https://github.com/own-pt/cl-conllu
git clone https://github.com/own-pt/conll-workbench.git

# this takes care of all dependencies
sbcl --eval '(ql:quickload :conll-validator)' --quit
sbcl --eval '(ql:quickload :swank)' --quit

cd /root
git clone https://github.com/UniversalDependencies/tools.git
