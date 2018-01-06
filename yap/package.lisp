#|
  This file is a part of cl-prolog2.yap project.
  Copyright (c) 2017 Masataro Asai (guicho2.71828@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-prolog2.yap
  (:use :cl :cl-prolog2)
  (:export
   #:yap))
(in-package :cl-prolog2.yap)

;; blah blah blah.

(defmethod run-prolog ((rules list) (prolog-designator (eql :yap)) &key debug args (input *standard-input*) (output :string) (error *error-output*) &allow-other-keys)
  (with-temp (d :directory t :debug debug)
    (with-temp (input-file :tmpdir d :template "XXXXXX.prolog" :debug debug)
      (with-open-file (s input-file :direction :output :if-does-not-exist :error)
        (let ((*debug-prolog* debug))
          (print-rule s '(:- (set_prolog_flag unknown error)))
          (dolist (r rules)
            (print-rule s r))))
      (when debug
        (format *error-output* "; ~{~a~^ ~}" `("yap" "-l" ,input-file ,@args)))
      (alexandria:unwind-protect-case ()
          (uiop:run-program `("yap" "-l" ,input-file ,@args) :input input :output output :error error)
        (:abort (setf debug t))))))

