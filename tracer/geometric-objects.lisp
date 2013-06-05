;;__________________________________________________
;;;; Generic Geometric Object Functions

(defgeneric hit (geo-object ray shader)
  (:documentation "Tests whether or not a ray intersected an object."))

;;__________________________________________________
;;;; Geometric Objects

(defclass geometric-object ()
  ((obj-color :accessor kobj-color :type rgb :initarg :obj-color :initform (alloc-rgb))))

;;__________________________________________________
;;;; Plane Object

(defstruct (plane (:conc-name nil)) 
  (point-of)
  (normal-of))

(defmethod hit ((obj plane) ray shader)
  (let ((hit-dist (dot-product (sb-cga:vec- (point-of obj) (origin ray))
			       (sb-cga:vec/ (normal-of obj) 
					     (sb-cga:dot-product (direction ray) (normal-of obj))))))
    (when (> hit-dist +k-epsilon+)
      (setf (dist-from-hit shader) hit-dist)
      (setf (normal shader) (normal-of obj))
      (setf (hit-point shader) (sb-cga:vec+ (origin ray) (sb-cga:vec* (direction ray) hit-dist))))))

;;__________________________________________________
;;;; Sphere Object

(defstruct (sphere (:conc-name nil))
  (center (sb-cga:alloc-vec) :type sb-cga:vec)
  (radius 0.0 :type single-float)
  (obj-color))

(defmethod hit ((obj sphere) ray shader)
  (declare (optimize (speed 3)))
  (let* ((temp (sb-cga:vec- (origin ray) (center obj)))
         (a (sb-cga:dot-product (direction ray) (direction ray)))
         (b (* (sb-cga:dot-product temp (direction ray)) 2.0))
         (c (- (sb-cga:dot-product temp temp) (square (radius obj)))))
    (declare (dynamic-extent temp))
    (multiple-value-bind (min-root max-root)
	(sb-cga:quadratic-roots-above +k-epsilon+ a b c)
      (cond ((> min-root +k-epsilon+)
	     (setf (dist-from-hit shader) min-root
		   (normal shader) (sb-cga:vec/ (sb-cga:vec+ temp 
                                                             (sb-cga:vec* (direction ray) 
                                                                          min-root)) 
					 (radius obj))
		   (hit-point shader) (sb-cga:vec+ (origin ray) 
                                                   (sb-cga:vec* (direction ray) 
                                                                min-root))))
	    ((> max-root +k-epsilon+)
	     (setf (dist-from-hit shader) max-root
		   (normal shader) (sb-cga:vec/ (sb-cga:vec+ temp 
                                                             (sb-cga:vec* (direction ray) 
                                                                          max-root)) 
                                                (radius obj))
		   (hit-point shader) (sb-cga:vec+ (origin ray) 
                                                   (sb-cga:vec* (direction ray) 
                                                                max-root))))))))
