(in-package :asdf)

(defsystem :tracer
  :description "A basic ray tracer."
  :author "Scott Chatham <snamich@gmail.com>"
  :components ((:file "shader")
	       (:file "ray")
	       (:file "specials")
	       (:file "samplers")
	       (:file "samplers/jittered")
	       (:file "samplers/multi-jittered")
	       (:file "samplers/nrooks")
	       (:file "samplers/regular")
	       (:file "view-plane")
	       (:file "geometric-objects")
	       (:file "tracer")
	       (:file "render"))
  :depends-on (:zpng :sb-cga :rgb)
  :serial t)