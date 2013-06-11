;;__________________________________________________
;;;; RGB Definition

(declaim (ftype (function () rgb) alloc-rgb)
	 (inline alloc-rgb))
(defun alloc-rgb ()
  (declare (optimize (speed 3) (safety 1)))
  (make-array 3 :element-type 'single-float))

(declaim (ftype (function (single-float single-float single-float) rgb) rgb)
	 (inline rgb))
(defun rgb (r g b)
  (declare (optimize (speed 3) (safety 1)))
  (make-array 3 :element-type 'single-float :initial-contents (list r g b)))

;;__________________________________________________
;;;; RGB Operations

(declaim (ftype (function (rgb rgb) rgb) rgb+))
(define-opt-fun rgb+ (a b)
  "Add RGB B to RGB A, result is freshly allocated RGB.")

(declaim (ftype (function (rgb single-float) rgb) rgb/))
(define-opt-fun rgb/ (rgb s)
  "Divide RGB by the SINGLE-FLOAT S, result is freshly allocated RGB.")

(declaim (ftype (function (rgb rgb) rgb) rgb*))
(define-opt-fun rgb* (a b)
  "Componentwise multiplication of RGB A and RGB B, result is freshly allocated RGB.")

(defun rgb-scale (r s)
  (rgb* r (rgb s s s)))

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
