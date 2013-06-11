(setf *vp* (make-view-pln :horizontal-resolution 300
			  :vertical-resolution 300
			  :pixel-size 1.0
			  :sampler (make-instance 'jittered
						  :num-samples 16
						  :num-sets 83)))

(setf *camera* (make-instance 'pinhole
                              :eye (sb-cga:vec 300.0 400.0 500.0)
                              :lookat (sb-cga:vec 0.0 0.0 -50.0)
                              :d 400.0))

(compute-uvw *camera*)

(generate-samples (sampler *vp*))

(defparameter yellow (rgb 1.0 1.0 0.0))
(defparameter brown (rgb 0.71 0.40 0.16))
(defparameter dark-green (rgb 0.0 0.41 0.41))
(defparameter orange (rgb 1.0 0.75 0.0))
(defparameter green (rgb 0.0 0.6 0.3))
(defparameter light-green (rgb 0.65 1.0 0.30))
(defparameter dark-yellow (rgb 0.61 0.61 0.0))
(defparameter light-purple (rgb 0.65 0.3 1.0))
(defparameter dark-purple (rgb 0.5 0.0 1.0))

(add-objects
  (sphere -45.0 45.0 40.0 50.0 yellow))
