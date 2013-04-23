;;__________________________________________________
;;;; Shaders

(defstruct (shader (:conc-name nil) (:constructor make-shdr))
  (hit? nil :type symbol) ; t or nil, did the ray hit an object
  (hit-point (alloc-vec) :type vec)
  (normal (alloc-vec) :type vec)
  (color (alloc-rgb) :type rgb)
  (dist-from-hit 0.0 :type single-float))