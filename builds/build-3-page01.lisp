(setf *vp* (make-view-pln :horizontal-resolution 800
			  :vertical-resolution 800
			  :pixel-size 1.0
			  :sampler (make-instance 'jittered
						  :num-samples 32
						  :num-sets 83)))

(generate-samples (sampler *vp*))

(setf *camera* (make-instance 'pinhole
                              :eye (sb-cga:vec 0.0 10000.0 9000.0)
                              :lookat (sb-cga:vec 0.0 0.0 0.0)
                              :d 15000.0))

(setf *ambient-light* (make-instance 'ambient-light))

(compute-uvw *camera*)

(push (point-light (sb-cga:vec 5.0 25.0 50.0) (rgb 1.0 1.0 1.0) 1.5) *lights*)
(push (point-light (sb-cga:vec 5.0 -25.0 50.0) (rgb 1.0 1.0 1.0) 1.5) *lights*)

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
  (sphere 5.0 3.0 0.0 30.0 (phong 0.25 0.65 1.0 50 yellow))
  (sphere 45.0 -7.0 -6.0 20.0 (matte 0.25 0.65 brown))
;;  (sphere 40.0 43.0 -100.0 17.0 (matte 0.25 0.65 dark-green))
  (sphere -20.0 28.0 -15.0 20.0 (matte 0.25 0.65 orange))
  (sphere -25.0 -7.0 -35.0 27.0 (matte 0.25 0.65 green))
  (sphere 20.0 -27.0 -35.0 25.0 (matte 0.25 0.65 light-green))
  (sphere 35.0 18.0 -35.0 22.0 (matte 0.25 0.65 green))
  (sphere -57.0 -17.0 -50.0 15.0 (matte 0.25 0.65 brown))
  (sphere -47.0 16.0 -80.0 23.0 (matte 0.25 0.65 light-green))
  (sphere -15.0 -32.0 -60.0 22.0 (matte 0.25 0.65 dark-green))
  (sphere -35.0 -37.0 -80.0 22.0 (matte 0.25 0.65 dark-yellow))
  (sphere 10.0 43.0 -80.0 22.0 (matte 0.25 0.65 dark-yellow))
  (sphere 30.0 -7.0 -80.0 10.0 (matte 0.25 0.65 dark-yellow))
  (sphere -40.0 48.0 -110.0 18.0 (matte 0.25 0.65 dark-green))
  (sphere -10.0 53.0 -120.0 18.0 (matte 0.25 0.65 brown))
  (sphere -55.0 -52.0 -100.0 10.0 (matte 0.25 0.65 light-purple))
  (sphere 5.0 -52.0 -100.0 15.0 (matte 0.25 0.65 brown))
  (sphere -20.0 -57.0 -120.0 15.0 (matte 0.25 0.65 dark-purple))
  (sphere 55.0 -27.0 -100.0 17.0 (matte 0.25 0.65 dark-green))
  (sphere 50.0 -47.0 -120.0 15.0 (matte 0.25 0.65 brown))
  (sphere 70.0 -42.0 -150.0 10.0 (matte 0.25 0.65 light-purple))
  (sphere 5.0 73.0 -130.0 12.0 (matte 0.25 0.65 light-purple))
  (sphere 66.0 21.0 -130.0 13.0 (matte 0.25 0.65 dark-purple))
  (sphere 72.0 -12.0 -140.0 12.0 (matte 0.25 0.65 light-purple))
  (sphere 64.0 5.0 -160.0 11.0 (matte 0.25 0.65 green))
  (sphere 55.0 38.0 -160.0 12.0 (matte 0.25 0.65 light-purple))
  (sphere -73.0 -2.0 -160.0 12.0 (matte 0.25 0.65 light-purple))
  (sphere 30.0 -62.0 -140.0 15.0 (matte 0.25 0.65 dark-purple))
  (sphere 25.0 63.0 -140.0 15.0 (matte 0.25 0.65 dark-purple))
  (sphere -60.0 46.0 -140.0 15.0 (matte 0.25 0.65 dark-purple))
  (sphere -30.0 68.0 -130.0 12.0 (matte 0.25 0.65 light-purple))
  (sphere 58.0 56.0 -180.0 11.0 (matte 0.25 0.65 green))
  (sphere -63.0 -39.0 -180.0 11.0 (matte 0.25 0.65 green))
  (sphere 46.0 68.0 -200.0 10.0 (matte 0.25 0.65 light-purple))
  (sphere -3.0 -72.0 -130.0 12.0 (matte 0.25 0.65 light-purple)))
