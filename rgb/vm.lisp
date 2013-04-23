;;__________________________________________________
;;;; RGB VM Functions

(declaim (ftype (function (rgb rgb rgb) rgb) %rgb+)
	 (inline %rgb+))
;(defknown %rgb+ (rgb rgb rgb) rgb (any) :result-arg 0)
(defun %rgb+ (result a b)
  (declare (optimize (speed 3) (safety 1) (debug 1)))
  (macrolet ((dim (n)
	       `(setf (aref result ,n) (+ (aref a ,n) (aref b ,n)))))
    (dim 0)
    (dim 1)
    (dim 2)
    result))

(declaim (ftype (function (rgb rgb single-float) rgb) %rgb/)
	 (inline %rgb/))
;(defknown %rgb/ (rgb rgb single-float) rgb (any) :result-arg 0)
(defun %rgb/ (result rgb s)
  (declare (optimize (speed 3) (safety 1) (debug 1)))
  (macrolet ((dim (n)
	       `(setf (aref result ,n) (/ (aref rgb ,n) s))))
    (dim 0)
    (dim 1)
    (dim 2)
    result))

(declaim (ftype (function (rgb rgb rgb) rgb) %rgb*)
	 (inline %rgb*))
;(defknown %rgb* (rgb rgb rgb) rgb (any) :result-arg 0)
(defun %rgb* (result a b)
  (declare (optimize (speed 3) (safety 1) (debug 1)))
  (macrolet ((dim (n)
	       `(setf (aref result ,n) (* (aref a ,n) (aref b ,n)))))
    (dim 0)
    (dim 1)
    (dim 2)
    result))