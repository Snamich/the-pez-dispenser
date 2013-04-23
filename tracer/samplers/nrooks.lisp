;;______________________________________________________________________
;;;; NRooks Sampler

(defclass nrooks (sampler) ())

(defmethod generate-samples ((s nrooks))
  (with-accessors ((num-samples number-of-samples)) s
    (dotimes (p (number-of-sample-sets s))
      (dotimes (j num-samples)
	(let ((x (/ (+ (random 1.0) j) num-samples))
	      (y (/ (+ (random 1.0) j) num-samples)))
	  (push (point x y) (samples-of s))))))
  (shuffle-x-coordinates s)
  (shuffle-y-coordinates s))

(defmethod shuffle-x-coordinates ((s nrooks))
  (with-accessors ((num-samples number-of-samples) (samples samples-of)) s
    (dotimes (p (number-of-sample-sets s))
      (dotimes (i num-samples)
	(let ((target (mod (random (number-of-sample-sets s))
			   (+ num-samples (* p num-samples))))
	      (temp (x (elt samples (+ (* num-samples p) i 1)))))
	  (setf (x (elt samples (+ (* num-samples p) i 1))) (x (elt samples target))
		(x (elt samples target)) temp))))))

(defmethod shuffle-y-coordinates ((s nrooks))
  (with-accessors ((num-samples number-of-samples) (samples samples-of)) s
    (dotimes (p (number-of-sample-sets s))
      (dotimes (i num-samples)
       (let ((target (mod (random (number-of-sample-sets s))
			  (+ num-samples (* p num-samples))))
	     (temp (x (elt samples (+ (* num-samples p) i 1)))))
	 (setf (y (elt samples (+ (* num-samples p) i 1))) (y (elt samples target))
	       (y (elt samples target)) temp))))))