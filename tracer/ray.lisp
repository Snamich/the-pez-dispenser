(declaim (inline make-ray))
(defstruct (ray (:conc-name nil))
  (origin nil :type sb-cga:vec)
  (direction nil :type sb-cga:vec))
