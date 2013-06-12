;; shadow light

(setf *vp* (make-view-pln :horizontal-resolution 800
			  :vertical-resolution 800
			  :pixel-size 1.0
			  :sampler (make-instance 'jittered
						  :num-samples 32
						  :num-sets 83)))

(generate-samples (sampler *vp*))

(setf *camera* (make-instance 'pinhole
                              :eye (sb-cga:vec 0.0 -4000.0 5000.0)
                              :lookat (sb-cga:vec 0.0 40.0 0.0)
                              :d 15000.0))

(compute-uvw *camera*)

(setf *ambient-light* (make-instance 'ambient-light))

(push (point-light (sb-cga:vec 0.0 -20.0 0.0) (rgb 1.0 1.0 1.0) 3.0) *lights*)

(add-objects
  (sphere 0.0 -40.0 0.0 5.0 (matte 0.25 0.65 brown))
  (sphere 0.0 40.0 0.0 50.0 (matte 0.25 0.65 orange)))
