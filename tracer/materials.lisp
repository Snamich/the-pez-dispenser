(defclass material ()
  ((ambient-brdf :initarg :ambient-brdf :accessor ambient-brdf)
   (diffuse-brdf :initarg :diffuse-brdf :accessor diffuse-brdf)))

(defgeneric shade (material shdr))

(defclass matte (material) ())

(defmethod shade ((m matte) shdr)
  (let* ((wo (sb-cga:vec* (direction (ray shdr)) -1.0))
         (l (rgb* (rho (ambient-brdf m) shdr wo) (L *ambient-light* shdr))))
    (dolist (light *lights*)
      (let* ((wi (get-direction light shdr))
             (ndotwi (sb-cga:dot-product (normal shdr) wi)))
        (if (> ndotwi 0.0)
            (setf l (rgb+ (rgb-scale (rgb* (L light shdr)
                                           (f (diffuse-brdf m) shdr wo wi))
                                     ndotwi)
                          l)))))
    l))

(defclass phong (material)
  ((specular-brdf :initarg :specular-brdf :accessor specular-brdf)))

(defmethod shade ((p phong) shdr)
  (let* ((wo (sb-cga:vec* (direction (ray shdr)) -1.0))
         (l (rgb* (rho (ambient-brdf p) shdr wo) (L *ambient-light* shdr))))
    (dolist (light *lights*)
      (let* ((wi (get-direction light shdr))
             (ndotwi (sb-cga:dot-product (normal shdr) wi)))
        (if (> ndotwi 0.0)
            (setf l (rgb+ (rgb-scale (rgb* (L light shdr)
                                           (rgb+ (f (diffuse-brdf p) shdr wo wi)
                                                 (f (specular-brdf p) shdr wo wi)))
                                     ndotwi)
                          l)))))
    l))


