(defun trace-ray (ray)
  (let ((result (first-hit ray)))
    (if (hit? result)
	(shade (material result) result)
	*background-color*)))

(defun first-hit (ray)
  (let ((shader (make-shdr))
	(tmin +k-huge-value+))
    (dolist (obj *world*)
      (when (and (hit obj ray shader) (< (dist-from-hit shader) tmin))
	(setf (hit? shader) t
	      tmin (dist-from-hit shader)
              (ray shader) ray
              (material shader) (mat obj))))
    shader))
