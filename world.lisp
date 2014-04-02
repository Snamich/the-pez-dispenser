;;__________________________________________________
;;;; World

;;;; OBJECTIVE: the world contains all the objects (possibly lights?) that
;;;;            make up our scene 

(defparameter *world* nil)
(defparameter *world-size* 0)
(declaim (type (simple-array t (*)) *c-world*))
(defparameter *c-world* nil)

(defun compile-world (world)
  "Transforms the world from a list to a vector. This (should?)
improve our access time and memory usage."
  (let ((size (length world)))
    (setf *world-size* size
	  *c-world* (make-array size :element-type t :initial-contents *world*))))