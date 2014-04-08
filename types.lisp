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

(defun matte (ka kd cd)
  (make-instance 'matte
                 :ambient-brdf (make-instance 'lambertian
                                              :kd ka
                                              :cd cd)
                 :diffuse-brdf (make-instance 'lambertian
                                              :kd kd
                                              :cd cd)))

(defun phong (ka kd ks expo cd)
  (make-instance 'phong
                 :ambient-brdf (make-instance 'lambertian
                                              :kd ka
                                              :cd cd)
                 :diffuse-brdf (make-instance 'lambertian
                                              :kd kd
                                              :cd cd)
                 :specular-brdf (make-instance 'glossy-specular
                                               :expo expo
                                               :ks ks
                                               :cd cd)))

(defun reflective (ka kd ks expo cd kr cr)
  (make-instance 'reflective
                 :ambient-brdf (make-instance 'lambertian
                                              :kd ka
                                              :cd cd)
                 :diffuse-brdf (make-instance 'lambertian
                                              :kd kd
                                              :cd cd)
                 :specular-brdf (make-instance 'glossy-specular
                                               :expo expo
                                               :ks ks
                                               :cd cd)
                 :pspecular-brdf (make-instance 'perfect-specular
                                                :kr kr
                                                :cr cr)))

(defun point-light (loc color ls)
  (make-instance 'point-light
                 :loc loc
                 :colr color
                 :ls ls))

(defun reset-world ()
  (setf *world* nil)
  (setf *lights* nil)
  (setf *ambient-light* nil)
  (setf *camera* nil)
  (setf *vp* nil))

;; colors
(defparameter yellow (rgb 1.0 1.0 0.0))
(defparameter brown (rgb 0.71 0.40 0.16))
(defparameter dark-green (rgb 0.0 0.41 0.41))
(defparameter orange (rgb 1.0 0.75 0.0))
(defparameter green (rgb 0.0 0.6 0.3))
(defparameter light-green (rgb 0.65 1.0 0.30))
(defparameter dark-yellow (rgb 0.61 0.61 0.0))
(defparameter light-purple (rgb 0.65 0.3 1.0))
(defparameter dark-purple (rgb 0.5 0.0 1.0))
(defparameter white (rgb 1.0 1.0 1.0))
(defparameter black (rgb 0.0 0.0 0.0))
