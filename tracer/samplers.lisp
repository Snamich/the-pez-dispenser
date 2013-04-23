;;______________________________________________________________________
;;;; Samplers

(defclass sampler ()
  ((number-of-samples :initarg :num-samples :accessor number-of-samples :type fixnum)
   (number-of-sample-sets :initarg :num-sets :accessor number-of-sample-sets :type fixnum)
   (count :initform 0 :accessor count-of :type fixnum)
   (jump :initform 0 :accessor jump-of :type fixnum)
   (samples :initform nil :accessor samples-of :type list)
   (shuffled-indices :initform nil :accessor shuffled-indices :type list)))

(defgeneric generate-samples (sampler)
  (:documentation "Responsible for generating a set of sample points
using the specific sampling technique."))

(defgeneric shuffle-x-coordinates (sampler)
  (:documentation "Shuffle the sampler's samples' x coordinates around."))

(defgeneric shuffle-y-coordinates (sampler)
  (:documentation "Shuffle the sampler's samples' y coordinates around."))

(declaim (ftype (function (sampler) 2d-point) sample-unit-square)
	 (inline sample-unit-square))
(defun sample-unit-square (sampler)
  "Retrieves the next point to take a sample of."
  (with-accessors ((count count-of) (num-samples number-of-samples) 
		   (num-sets number-of-sample-sets) (jump jump-of)) sampler
    (when (= (mod count num-samples) 0)
      (setf jump (* (mod (random num-sets) num-sets) num-samples)))
    (let ((n (mod (+ count jump) num-samples)))
      (incf count)
      (elt (samples-of sampler) n))))

;;______________________________________________________________________
;;;; Compilation

;; create a compact version for use in the renderer