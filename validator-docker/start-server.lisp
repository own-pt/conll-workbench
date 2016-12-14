(ql:quickload :conll-validator :verbose nil :silent t)
(in-package :conll-validator)
(setf *ud-tools* "/root/tools/validate.py")
(start-server)
