(defclass pinhole (camera)
  ((d :initarg :d :accessor d :type single-float)
  (zoom :initform 1.0 :accessor zoom :type single-float)))

(defmethod render-scene ((p pinhole))
  (declare (optimize (debug 3) (speed 0) (safety 1)))
  (let ((png (make-instance 'zpng:pixel-streamed-png
			    :color-type :truecolor
			    :width (horizontal-resolution *vp*)
			    :height (vertical-resolution *vp*)))
        (s (/ (pixel-size *vp*) (zoom p)))
        (ray (make-ray :origin (eye p)
		       :direction (sb-cga:alloc-vec)))
	(pixel-color nil))
    (with-open-file (stream *file*
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
                   (x (* s (+ (x sample-point)
                              (- c (* (horizontal-resolution *vp*) 0.5)))))
                   (y (* s (+ (y sample-point)
                              (- r (* (vertical-resolution *vp*) 0.5))))))
              (setf (direction ray) (ray-direction p x y )
                    pixel-color (rgb+ pixel-color (trace-ray ray)))))
          (zpng:write-pixel (map-color (rgb-scale (rgb/ pixel-color 
                                                        (float (number-of-samples (sampler *vp*))))
                                                  (exposure-time p)))
                            png)))
      (zpng:finish-png png))))

(defmethod ray-direction ((p pinhole) x y)
  (let ((direction (sb-cga:vec+ (sb-cga:vec* (u p) x)
                                (sb-cga:vec- (sb-cga:vec* (v p) y)
                                             (sb-cga:vec* (w p) (d p))))))
    (sb-cga:normalize direction)))
