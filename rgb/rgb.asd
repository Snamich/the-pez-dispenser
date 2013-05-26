(in-package :asdf)

(defsystem :rgb
  :description "Basic color support."
  :author "Scott Chatham <snamich@gmail.com>"
  :components ((:file "utilities")
	       (:file "vm")
	       (:file "rgb"))
  :serial t)
