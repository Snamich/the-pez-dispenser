(defclass light ()
  ((shadows :initform t :accessor shadows :type symbol)))

(defgeneric L (light shdr))

(defgeneric get-direction (light shdr))

(defclass ambient-light (light)
  ((colr :initform (rgb 1.0 1.0 1.0) :accessor colr :type rgb)
   (ls :initform 1.0 :accessor ls :type single-float)))

(defmethod L ((a ambient-light) shdr)
  (rgb-scale (colr a) (ls a)))

(defmethod get-direction ((a ambient-light) shdr)
  (sb-cga:vec 0.0 0.0 0.0))

(defclass point-light (light)
  ((location :initarg :loc :accessor loc :type sb-cga:vec)
   (colr :initarg :colr :accessor colr :type rgb)
   (ls :initarg :ls :accessor ls :type single-float)))

(defmethod L ((p point-light) shdr)
  (rgb-scale (colr p) (ls p)))

(defmethod get-direction ((p point-light) shdr)
  (sb-cga:normalize (sb-cga:vec- (loc p) (hit-point shdr))))

(defclass direction-light (light)
  ((direction :initarg :dir :accessor dir :type sb-cga:vec)
   (colr :initarg :colr :accessor colr :type rgb)
   (ls :initarg :ls :accessor ls :type single-float)))

(defmethod get-direction ((dl direction-light) shdr)
  (dir dl))

(defmethod L ((dl direction-light) shdr)
  (rgb-scale (colr dl) (ls dl)))
