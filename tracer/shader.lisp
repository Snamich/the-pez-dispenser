;;__________________________________________________
;;;; Shaders

(defstruct (shader (:conc-name nil) (:constructor make-shdr))
  (hit? nil :type symbol) ; t or nil, did the ray hit an object
  (hit-point (sb-cga:alloc-vec) :type sb-cga:vec)
  (material)
  (direction (sb-cga:alloc-vec) :type sb-cga:vec)
  (ray (make-ray) :type ray)
  (normal (sb-cga:alloc-vec) :type sb-cga:vec)
  (color (alloc-rgb) :type rgb)
  (dist-from-hit 0.0 :type single-float))
