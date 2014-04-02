(setf *background-color* (rgb 0.0 0.0 0.0))

(setf *vp* (make-view-pln :horizontal-resolution 400
			  :vertical-resolution 400
			  :pixel-size 0.5
			  :sampler (make-instance 'jittered
                                                  :num-samples 16
                                                  :num-sets 83)))

(generate-samples (sampler *vp*))

(push (sphere 0.0 0.0 0.0 80.0 (rgb 1.0 0.0 0.0)) *world*)
(push (sphere 0.0 30.0 0.0 60.0 (rgb 1.0 1.0 0.0)) *world*)

;; (push (make-instance 'plane
;; 		     :point (sb-cga:vec 0.0 0.0 0.0)
;; 		     :obj-normal (sb-cga:vec 0.0 1.0 1.0)
;; 		     :obj-color (rgb 0.0 0.25 0.0)) ; dark green
;;       *world*)

