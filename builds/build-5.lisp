(setf *vp* (make-view-pln :horizontal-resolution 800
			  :vertical-resolution 800
			  :pixel-size 1.0
			  :sampler (make-instance 'jittered
						  :num-samples 32
						  :num-sets 83)))

(generate-samples (sampler *vp*))

(setf *camera* (make-instance 'pinhole
                              :eye (sb-cga:vec 0.0 0.05 0.0)
                              :lookat (sb-cga:vec 0.0 1.0 0.0)
                              :d 1000.0))

(compute-uvw *camera*)

(setf *ambient-light* (make-instance 'ambient-light))
(setf (ls *ambient-light*) 0.5)

(add-objects
  (sphere 0.0 0.0 0.0 50.0 (reflective 0.75 0.75 0.1 20 (rgb 0.168 0.171 0.009) 1.0 white))
  (sphere 0.0 1.414 0.0 0.866 (reflective 0.75 0.75 0.1 20 (rgb 0.168 0.171 0.009) 1.0 white))
  (sphere 0.0 0.0 1.0 0.866 (reflective 0.75 0.75 0.1 20 (rgb 0.094 0.243 0.029) 1.0 white))
  (sphere 0.866 0.0 -0.5 0.866 (reflective 0.75 0.75 0.1 20 (rgb 0.243 0.018 0.164) 1.0 white))
  (sphere -0.866 0.0 -0.5 0.866 (reflective 0.75 0.75 0.1 20 (rgb 0.094 0.1 0.243) 1.0 white)))

