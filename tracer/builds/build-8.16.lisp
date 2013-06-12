(setf *vp* (make-view-pln :horizontal-resolution 400
			  :vertical-resolution 400
			  :pixel-size 0.5
			  :sampler (make-instance 'jittered
						  :num-samples 16
						  :num-sets 83)))

(setf *camera* (make-instance 'pinhole
                              :eye (sb-cga:vec 0.0 0.0 500.0)
                              :lookat (sb-cga:vec -5.0 0.0 0.0)
                              :d 850.0))

(setf *ambient-light* (make-instance 'ambient-light))

(compute-uvw *camera*)

(defun matte (ka kd cd)
  (make-instance 'matte
                 :ambient-brdf (make-instance 'lambertian
                                              :kd ka
                                              :cd cd)
                 :diffuse-brdf (make-instance 'lambertian
                                              :kd kd
                                              :cd cd)))

(defun phong (ka kd ks expo cd)
  (make-instance 'phong
                 :ambient-brdf (make-instance 'lambertian
                                              :kd ka
                                              :cd cd)
                 :diffuse-brdf (make-instance 'lambertian
                                              :kd kd
                                              :cd cd)
                 :specular-brdf (make-instance 'specular-brdf
                                               :expo expo
                                               :ks ks
                                               :cs cd)))

(defun point-light (loc)
  (make-instance 'point-light
                 :loc loc
                 :colr (rgb 1.0 1.0 1.0)
                 :ls 1.0))

(push (point-light (sb-cga:vec 100.0 50.0 150.0)) *lights*)

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
  (sphere -45.0 45.0 40.0 50.0 (matte 0.25 0.65 (rgb 1.0 1.0 0.0))))
