
(cl:in-package :asdf)

(defsystem "readEMG-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "EMG" :depends-on ("_package_EMG"))
    (:file "_package_EMG" :depends-on ("_package"))
  ))