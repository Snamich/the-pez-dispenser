(defclass multi-jittered (sampler) ())

(defmethod generate-samples ((s multi-jittered))
  (with-accessors ((samples samples-of) (num-samples number-of-samples)) s
    (let ((n (floor (sqrt num-samples)))
	  (subcell-width (/ 1.0 num-samples)))
     ;; fill samples wtih dummy points
      (dotimes (j (* (number-of-sample-sets s) num-samples))
	(push (point 0.0 0.0) samples))
      (dotimes (p (number-of-sample-sets s))
	(dotimes (i n)
	  (dotimes (j n)
	    (setf (x (elt samples (+ (* num-samples p) (* i n) j)))
		  (+ (* (+ (* i n) j) subcell-width) (random subcell-width))
		  (y (elt samples (+ (* num-samples p) (* i n) j)))
		  (+ (* (+ (* i n) j) subcell-width) (random subcell-width))))))
      (shuffle-x-coordinates s)
      (shuffle-y-coordinates s))))

(defmethod shuffle-x-coordinates ((s multi-jittered))
  (with-accessors ((samples samples-of) (num-samples number-of-samples)) s
    (let ((n (floor (sqrt num-samples))))
      (dotimes (p (number-of-sample-sets s))
	(dotimes (i n)
	  (dotimes (j n)
	    (let ((k (rand j (- n 1)))
		  (temp (x (elt samples (+ (* i n) (* num-samples p) j)))))
	     (setf (x (elt samples (+ (* i n) (* num-samples p) j)))
		   (x (elt samples (+ (* i n) (* num-samples p) k)))
		   (x (elt samples (+ (* i n) (* num-samples p) k)))
		   temp))))))))

(defmethod shuffle-y-coordinates ((s multi-jittered))
  (with-accessors ((samples samples-of) (num-samples number-of-samples)) s
    (let ((n (floor (sqrt num-samples))))
      (dotimes (p (number-of-sample-sets s))
	(dotimes (i n)
	  (dotimes (j n)
	    (let ((k (rand j (- n 1)))
		  (temp (y (elt samples (+ (* j n) (* num-samples p) i)))))
	     (setf (y (elt samples (+ (* j n) (* num-samples p) i)))
		   (y (elt samples (+ (* k n) (* num-samples p) i)))
		   (y (elt samples (+ (* k n) (* num-samples p) i)))
		   temp))))))))