(defclass brdf ()
  ((sampler :accessor sampler :type sampler)))

(defgeneric f (brdf shdr wi wo))

(defgeneric rho (brdf shdr wo))

(defclass lambertian (brdf)
  ((kd :initarg :kd :accessor kd :type single-float)
   (cd :initarg :cd :accessor cd :type rgb)))

(defmethod f ((l lambertian) shdr wi wo)
  (rgb-scale (cd l)
             (* (kd l) +inverse-PI+)))

(defmethod rho ((l lambertian) shdr wo)
  (rgb-scale (cd l)
             (kd l)))

(defclass glossy-specular (brdf)
  ((ks :initarg :ks :accessor ks :type single-float)
   (expo :initarg :expo :accessor expo :type single-float)
   (cd :initarg :cd :accessor cd :type rgb)))

(defmethod f ((gs glossy-specular) shdr wi wo)
  (let* ((ndotwi (sb-cga:dot-product (normal shdr) wi))
         (r (sb-cga:vec+ (sb-cga:vec* (normal shdr) (* ndotwi 2.0))
                              (sb-cga:vec* wi -1.0)))
         (rdotwo (sb-cga:dot-product r wo)))
    (if (> rdotwo 0.0)
        (rgb-scale (cd gs) (* (ks gs) (expt rdotwo (expo gs))))
        (rgb 0.0 0.0 0.0))))

(defmethod rho ((gs glossy-specular) shdr wo)
  (rgb 0.0 0.0 0.0))
