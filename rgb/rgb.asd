(in-package :asdf)

(defsystem :rgb
  :description "Basic color support."
  :author "Scott Chatham <snamich@gmail.com>"
  :components ((:file "utility")
	       (:file "vm")
	       (:file "rgb"))
  :serial t)