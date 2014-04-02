(defclass hammersley (sampler) ())

(defmethod generate-samples ((s hammersley))
  (with-accessors ((num-samples number-of-samples)) s
    (dotimes (p (number-of-sample-sets s))
      (dotimes (j num-samples)
	(let ((x (float (/ j num-samples)))
	      (y (phi j)))
	  (push (point x y) (samples-of s)))))))

(defun phi (n)
  (labels ((rec (j x f)
	     (if (= j 0)
		 x
		 (rec (/ j 2) (+ x (* f (mod j 2))) (* f 0.5)))))
    (rec n 0.0 0.5)))