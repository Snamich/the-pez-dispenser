;;__________________________________________________
;;;; RGB Definition

(deftype rgb () 'sb-cga:vec)

(defun alloc-rgb () (sb-cga:alloc-vec))

(defun rgb (r g b) (sb-cga:vec r g b))

;;__________________________________________________
;;;; RGB Operations

(defun rgb+ (a b)
  (sb-cga:vec+ a b))

(defun rgb/ (a f)
  (sb-cga:vec/ a f))

(defun rgb* (a b)
  (sb-cga:hadamard-product a b))

(defun rgb-scale (a f)
  (sb-cga:vec* a f))

(declaim (ftype (function (rgb) single-float) avg-rgb))
(defun avg-rgb (rgb)
  "Average value of RGB components."
  (declare (optimize (speed 3) (safety 1) (debug 1)))
  (macrolet ((dim (n)
	       `(aref rgb ,n)))
    (/ (+ (dim 0) (dim 1) (dim 2)) 3.0)))

(declaim (ftype (function (rgb) rgb) clamp))
(defun clamp (rgb)
  "Ensure the component values of RGB are within the range [0,1.0]."
  (declare (optimize (speed 3) (safety 1)))
  (macrolet ((dim (n)
	       `(aref rgb ,n)))
    (let ((max (max (dim 0) (dim 1) (dim 2))))
      (if (> max 1.0)
	  (rgb/ rgb max)
	  rgb))))

(declaim (ftype (function (rgb) list) map-color))
(defun map-color (rgb)
  "Maps the float components of RGB to integer based values, returns a list (for zpng)."
  (declare (optimize (speed 3) (safety 0)))
  (let ((clamped (clamp rgb)))
    (declare (type rgb clamped))
    (macrolet ((dim (n)
		 `(aref clamped ,n)))
      (list (the (unsigned-byte 18) (round (* (dim 0) 255.0)))
	    (the (unsigned-byte 18) (round (* (dim 1) 255.0)))
	    (the (unsigned-byte 18) (round (* (dim 2) 255.0)))))))
