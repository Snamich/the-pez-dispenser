(setf *vp* (make-view-pln :horizontal-resolution 600
			  :vertical-resolution 600
			  :pixel-size 1.0
			  :sampler (make-instance 'jittered
						  :num-samples 32
						  :num-sets 83)))

(generate-samples (sampler *vp*))

(setf *camera* (make-instance 'pinhole
                              :eye (sb-cga:vec 0.0 7.0 1.0)
                              :lookat (sb-cga:vec 0.0 -1.5 0.0)
                              :d 12.0))

(compute-uvw *camera*)

(push (point-light (sb-cga:vec 3.0 10.0 2.0) (rgb 1.0 0.0 0.0) 12.0) *lights*)
(push (point-light (sb-cga:vec -3.0 10.0 2.0) (rgb 0.0 1.0 0.0) 12.0) *lights*)
(push (point-light (sb-cga:vec 0.0 10.0 -3.0) (rgb 0.0 0.0 1.0) 12.0) *lights*)

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
  (sphere 0.0 0.0 0.0 30.0 (matte 0.6 0.2 (rgb 0.5 0.5 0.5)))
