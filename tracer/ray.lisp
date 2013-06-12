(declaim (inline make-ray))
(defstruct (ray (:conc-name nil))
  (origin (sb-cga:alloc-vec) :type sb-cga:vec)
  (direction (sb-cga:alloc-vec) :type sb-cga:vec))
