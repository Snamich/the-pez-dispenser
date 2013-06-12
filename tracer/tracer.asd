(in-package :asdf)

(defsystem :tracer
  :description "A basic ray tracer."
  :author "Scott Chatham <snamich@gmail.com>"
  :components ((:file "shader")
	       (:file "ray")
	       (:file "specials")
               (:file "lights")
               (:file "brdf")
               (:file "materials")
	       (:file "samplers")
               (:file "samplers/jittered")
	       (:file "samplers/multi-jittered")
	       (:file "samplers/nrooks")
	       (:file "samplers/regular")
               (:file "samplers/hammersley")
	       (:file "view-plane")
               (:file "cameras")
               (:file "cameras/pinhole")
	       (:file "geometric-objects")
	       (:file "types")
	       (:file "tracer"))
  :depends-on (:zpng :sb-cga :rgb)
  :serial t)
