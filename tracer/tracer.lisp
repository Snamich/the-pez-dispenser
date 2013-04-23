(defun first-hit (ray)
  (let ((shader (make-shdr))
	(tmin +k-huge-value+))
    (dolist (obj *world*)
      (when (and (hit obj ray shader) (< (dist-from-hit shader) tmin))
	(setf (hit? shader) t
	      tmin (dist-from-hit shader)
	      (color shader) (obj-color obj))))
    shader))

(defun trace-ray (ray)
  (let ((result (first-hit ray)))
    (if (hit? result)
	(color result)
	*background-color*)))