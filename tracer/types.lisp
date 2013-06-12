(defstruct (point (:conc-name nil))
  (x)
  (y))

(defun point (x y)
  (make-point
   :x x
   :y y))

(defun sphere (x y z r material)
  (make-sphere 
   :center (sb-cga:vec x y z)
   :radius r
   :mat material))

(defun square (x)
  (* x x))

(defmacro add-objects (&body body)
  `(progn 
     ,@(loop
	  for obj in body collect `(push ,obj *world*))))
