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

;(defclass plane (geometric-object)
;  ((point :type 3d-vec :accessor point :initarg :point :initform (make-3d-vec))
;   (obj-normal :type 3d-vec :accessor obj-normal :initarg :obj-normal :initform (make-3d-vec 0.0 1.0 0.0))))

(defstruct (plane (:conc-name nil)) 
  (point-of)
  (normal-of))

(defmethod hit ((obj plane) ray shader)
  (let ((hit-dist (dot-product (vec- (point-of obj) (origin ray))
			       (vec/ (normal-of obj) 
					     (dot-product (direction ray) (normal-of obj))))))
    (when (> hit-dist +k-epsilon+)
      (setf (dist-from-hit shader) hit-dist)
      (setf (normal shader) (normal-of obj))
      (setf (hit-point shader) (vec+ (origin ray) (vec* (direction ray) hit-dist))))))

;;__________________________________________________
;;;; Sphere Object

;(defclass sphere (geometric-object)
;  ((center :type 3d-vec :accessor center :initarg :center :initform (make-3d-vec))
;   (radius :type double-float :accessor radius :initarg :radius :initform 1d0)))

(defstruct (sphere (:conc-name nil))
  (center (alloc-vec) :type vec)
  (radius 0.0 :type single-float)
  (obj-color))

(defmethod hit ((obj sphere) ray shader)
  (declare (optimize (speed 3)))
  (let* ((temp (vec- (origin ray) (center obj)))
	(a (dot-product (direction ray) (direction ray)))
	(b (* (dot-product temp (direction ray)) 2.0))
	(c (- (dot-product temp temp) (square (radius obj)))))
    (declare (dynamic-extent temp))
    (multiple-value-bind (min-root max-root)
	(quadratic-roots-above +k-epsilon+ a b c)
      (cond ((> min-root +k-epsilon+)
	     (setf (dist-from-hit shader) min-root
		   (normal shader) (vec/ (vec+ temp 
					       (vec* (direction ray) 
						     min-root)) 
					 (radius obj))
		   (hit-point shader) (vec+ (origin ray) 
					    (vec* (direction ray) 
						  min-root))))
	    ((> max-root +k-epsilon+)
	     (setf (dist-from-hit shader) max-root
		   (normal shader) (vec/ (vec+ temp 
					       (vec* (direction ray) 
						     max-root)) 
					 (radius obj))
		   (hit-point shader) (vec+ (origin ray) 
					    (vec* (direction ray) 
						  max-root))))))))