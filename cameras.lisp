(defclass camera ()
  ((eye :initarg :eye :accessor eye :type sb-cga:vec)
   (lookat :initarg :lookat :accessor lookat :type sb-cga:vec)
   (up :initform (sb-cga:vec 0.0 1.0 0.0) :accessor up :type sb-cga:vec)
   (u :accessor u :type sb-cga:vec)
   (v :accessor v :type sb-cga:vec)
   (w :accessor w :type sb-cga:vec)
   (exposure-time :initform 1.0 :accessor exposure-time :type single-float)))

(defgeneric render-scene (camera file)
  (:documentation "Renders the scene using the given camera and view plane."))

(defgeneric ray-direction (camera x y))

(defmethod compute-uvw ((c camera))
  (let* ((w (sb-cga:normalize (sb-cga:vec- (eye c) (lookat c))))
         (u (sb-cga:normalize (sb-cga:cross-product (up c) w)))
         (v (sb-cga:cross-product w u)))
    (setf (u c) u
          (v c) v
          (w c) w)))
         
