(defsystem cl-prolog2.yap
  :version "0.1"
  :author "Masataro Asai"
  :mailto "guicho2.71828@gmail.com"
  :license "MIT"
  :depends-on (:cl-prolog2)
  :components ((:file "package"))
  :description "CL-PROLOG2 extension for Yap"
  :in-order-to ((test-op (test-op :cl-prolog2.yap.test)))
  :defsystem-depends-on (:trivial-package-manager)
  :perform
  (load-op :before (op c)
            (uiop:symbol-call :trivial-package-manager
                                      :ensure-program
                                      "yap"
                                      :apt "yap"
                                      :yum "pl-compat-yap-devel"
                                      :dnf "pl-compat-yap-devel"
                                      :brew "yap")))
