(defconstant +2PI+ (the single-float 6.2831853071795864769))
(defconstant +PI/180+ (the single-float 0.0174532925199432957))
(defconstant +inverse-PI+ (the single-float 0.3183098861837906715))
(defconstant +inverse-2PI+ (the single-float 0.1591549430918953358))

(defconstant +k-epsilon+ 0.0001)
(defconstant +k-huge-value+ 1.0E10)

(defparameter *world* nil)
(defparameter *camera* nil)
(defparameter *vp* nil)
(defparameter *lights* nil)
(defparameter *ambient-light* nil)
(defparameter *background-color* (alloc-rgb))
(defparameter *max-depth* 3)
