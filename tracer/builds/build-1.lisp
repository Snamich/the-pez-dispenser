(setf *background-color* (make-rgb 0.0 0.0 0.0))

(setf *vp* (make-view-pln :horizontal-resolution 400
			  :vertical-resolution 400
			  :pixel-size 0.5
			  :sample-# 16))

(push (make-instance 'sphere
		     :center (make-3d-vec 0.0 0.0 0.0)
		     :radius 80d0
		     :obj-color (make-rgb 1.0 0.0 0.0)) ; red
      *world*)

(push (make-instance 'sphere
		     :center (make-3d-vec 0.0 30.0 0.0)
		     :radius 60d0
		     :obj-color (make-rgb 1.0 1.0 0.0)) ; yellow
      *world*)

(push (make-instance 'plane
		     :point (make-3d-vec 0.0 0.0 0.0)
		     :obj-normal (make-3d-vec 0.0 1.0 1.0)
		     :obj-color (make-rgb 0.0 0.25 0.0)) ; dark green
      *world*)

