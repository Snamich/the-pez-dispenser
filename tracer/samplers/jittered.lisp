;;______________________________________________________________________
;;;; Jittered Sampler

(defclass jittered (sampler) ())

(defmethod generate-samples ((s jittered))
  (let ((n (truncate (sqrt (number-of-samples s)))))
    (dotimes (p (number-of-sample-sets s))
      (dotimes (j n)
	(dotimes (k n)
	  (let ((x (/ (+ (random 1.0) k) n))
		(y (/ (+ (random 1.0) j) n)))
	    (push (point x y) (samples-of s))))))))