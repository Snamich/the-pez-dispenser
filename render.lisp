(defun render-scene (file)
  (declare (optimize (speed 3) (safety 1)))
  (let ((png (make-instance 'zpng:pixel-streamed-png
			    :color-type :truecolor
			    :width (horizontal-resolution *vp*)
			    :height (vertical-resolution *vp*)))
	(zw 100.0)
	(ray (make-ray :origin (sb-cga:alloc-vec)
		       :direction (sb-cga:vec 0.0 0.0 -1.0)))
	(pixel-color nil))
    (with-open-file (stream file
			    :direction :output
			    :if-exists :supersede
			    :if-does-not-exist :create
			    :element-type '(unsigned-byte 8))
      (zpng:start-png png stream)
      (dotimes (r (vertical-resolution *vp*))
	(dotimes (c (horizontal-resolution *vp*))
	  (setf pixel-color (alloc-rgb))
	  (dotimes (j (number-of-samples (sampler *vp*)))
	    (let* ((sample-point (sample-unit-square (sampler *vp*)))
		  (x (* (pixel-size *vp*) 
			(+ (x sample-point) 
			   (- c (* (horizontal-resolution *vp*) 0.5)))))
		  (y (* (pixel-size *vp*) 
			(+ (y sample-point)
			   (- r (* (vertical-resolution *vp*) 0.5))))))
	      (setf (origin ray) (sb-cga:vec x y zw)
		    pixel-color (rgb+ pixel-color (trace-ray ray)))))
	  (zpng:write-pixel (map-color (rgb/ pixel-color 
					     (float (number-of-samples (sampler *vp*)))))
                            png)))
      (zpng:finish-png png))))

(defun perspective-render (file)
  (declare (optimize (speed 3) (safety 1)))
  (let ((png (make-instance 'zpng:pixel-streamed-png
			    :color-type :truecolor
			    :width (horizontal-resolution *vp*)
			    :height (vertical-resolution *vp*)))
	(zw 200.0)
	(ray (make-ray :origin (sb-cga:vec 0.0 0.0 *eye*)
		       :direction (sb-cga:alloc-vec)))
	(pixel-color nil))
    (with-open-file (stream file
			    :direction :output
			    :if-exists :supersede
			    :if-does-not-exist :create
			    :element-type '(unsigned-byte 8))
      (zpng:start-png png stream)
      (dotimes (r (vertical-resolution *vp*))
	(dotimes (c (horizontal-resolution *vp*))
	  (setf pixel-color (alloc-rgb))
          (let* ((sample-point (sample-unit-square (sampler *vp*)))
                 (x (* (pixel-size *vp*) 
                       (* (- c 0.5) 
                          (- (horizontal-resolution *vp*) 1.0))))
                   (y (* (pixel-size *vp*) 
                         (* (- r 0.5)
                            (- (vertical-resolution *vp*) 1.0)))))
            (setf (direction ray) (sb-cga:normalize (sb-cga:vec x y (- zw)))
                  pixel-color (rgb+ pixel-color (trace-ray ray))))
          (zpng:write-pixel (map-color (rgb/ pixel-color 
                                             (float (number-of-samples (sampler *vp*))))) png)))
      (zpng:finish-png png))))