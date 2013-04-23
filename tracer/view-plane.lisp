;;__________________________________________________
;;;; View Plane

(defstruct (view-plane (:conc-name nil) (:constructor make-view-pln))
  (horizontal-resolution 400 :type fixnum)
  (vertical-resolution 400 :type fixnum)
  (pixel-size 1.0 :type single-float)
  (gamma 1.0 :type single-float)
  (inverse-gamma 1.0 :type single-float)
  (sampler))