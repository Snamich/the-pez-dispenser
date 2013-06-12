(setf *vp* (make-view-pln :horizontal-resolution 400
			  :vertical-resolution 400
			  :pixel-size 0.5
			  :sampler (make-instance 'jittered
						  :num-samples 16
						  :num-sets 83)))

(generate-samples (sampler *vp*))

(setf *camera* (make-instance 'pinhole
                              :eye (sb-cga:vec 0.0 0.0 500.0)
                              :lookat (sb-cga:vec -5.0 0.0 0.0)
                              :d 850.0))

(setf *ambient-light* (make-instance 'ambient-light))

(compute-uvw *camera*)

(push (point-light (sb-cga:vec 100.0 50.0 150.0)) *lights*)

(add-objects
  (sphere -45.0 45.0 40.0 50.0 (matte 0.25 0.65 (rgb 1.0 1.0 0.0))))
