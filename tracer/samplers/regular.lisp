(defclass regular (sampler) ())

(defmethod generate-samples ((s regular))
  (let ((n (floor (sqrt (number-of-samples s)))))
    (dotimes (j (number-of-sample-sets s))
      (dotimes (p n)
	(dotimes (q n)
	  (push (point (/ (+ q 0.5) n) (/ (+ p 0.5) n)) (samples-of s)))))))