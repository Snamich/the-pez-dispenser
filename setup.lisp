;; add project files to asdf so we can load with quicklisp
(push #p"~/Projects/the-pez-dispenser/rgb/" asdf:*central-registry*)
(push #p"~/Projects/the-pez-dispenser/tracer/" asdf:*central-registry*)

;; can now (ql:quickload "tracer") to load the project
