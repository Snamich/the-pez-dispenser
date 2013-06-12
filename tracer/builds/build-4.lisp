(setf *vp* (make-view-pln :horizontal-resolution 800
			  :vertical-resolution 800
			  :pixel-size 1.0
			  :sampler (make-instance 'jittered
						  :num-samples 32
						  :num-sets 83)))

(generate-samples (sampler *vp*))

(setf *camera* (make-instance 'pinhole
                              :eye (sb-cga:vec 0.0 0.0 3000.0)
                              :lookat (sb-cga:vec 0.0 0.0 0.0)
                              :d 15000.0))

(setf *ambient-light* (make-instance 'ambient-light))

(compute-uvw *camera*)

(push (point-light (sb-cga:vec 40.0 0.0 40.0) (rgb 1.0 1.0 1.0) 1.5) *lights*)
(push (point-light (sb-cga:vec -40.0 0.0 40.0) (rgb 1.0 1.0 1.0) 1.5) *lights*)
(push (point-light (sb-cga:vec 0.0 0.0 40.0) (rgb 1.0 1.0 1.0) 1.5) *lights*)

(defparameter yellow (rgb 1.0 1.0 0.0))
(defparameter brown (rgb 0.71 0.40 0.16))
(defparameter dark-green (rgb 0.0 0.41 0.41))
(defparameter orange (rgb 1.0 0.75 0.0))
(defparameter green (rgb 0.0 0.6 0.3))
(defparameter light-green (rgb 0.65 1.0 0.30))
(defparameter dark-yellow (rgb 0.61 0.61 0.0))
(defparameter light-purple (rgb 0.65 0.3 1.0))
(defparameter dark-purple (rgb 0.5 0.0 1.0))
(defparameter white (rgb 1.0 1.0 1.0))

(add-objects
  (sphere 0.0 0.0 0.0 20.0 (reflective 0.25 0.5 0.15 20 (rgb 1.0 1.0 1.0) 0.75 white))
  (sphere 50.0 0.0 0.0 20.0 (reflective 0.25 0.5 0.15 20 (rgb 1.0 1.0 1.0) 0.75 white))
  (sphere -50.0 0.0 0.0 20.0 (reflective 0.25 0.5 0.15 20 (rgb 1.0 1.0 1.0) 0.75 white))
  (sphere 25.0 40.0 0.0 20.0 (matte 0.25 0.65 brown))
  (sphere -25.0 40.0 0.0 20.0 (matte 0.25 0.65 orange))
  (sphere 25.0 -40.0 0.0 20.0 (matte 0.25 0.65 dark-purple))
  (sphere -25.0 -40.0 0.0 20.0 (matte 0.25 0.65 dark-green)))
