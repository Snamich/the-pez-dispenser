(defclass pure-random (sampler) ())

(defmethod generate-samples ((s pure-random))
  (dotimes (p (number-of-sample-sets s))
    (dotimes (q (number-of-samples s))
      (let ((x (random 1.0))
	    (y (random 1.0)))
	(push (point x y) (samples-of s))))))