(declaim (inline make-ray))
(defstruct (ray (:conc-name nil))
  (origin nil :type vec)
  (direction nil :type vec))