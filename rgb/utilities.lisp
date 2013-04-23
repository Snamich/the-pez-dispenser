;;__________________________________________________
;;;; Type Declaration

(deftype rgb ()
    `(simple-array single-float (3)))

;;__________________________________________________
;;;; Utilities

(defun mkstr (&rest args)
  (with-output-to-string (s)
    (dolist (a args) (princ a s))))

(defun symb (&rest args)
  (values (intern (apply #'mkstr args))))

;(defmacro defknown (name arg-types ret-type attributes &rest keys)
;  `(sb-c:defknown ,name ,arg-types ,ret-type
;       ,(mapcar #'(lambda (attr) 
;		    (intern (symbol-name attr) :sb-c)) 
;		attributes)
;     ,@keys))

(defmacro define-opt-fun (name lambda-list doc)
  (let ((vm-name (symb "%" name)))
    `(progn
       (declaim (inline ,name))
       (defun ,name ,lambda-list ,doc
	      (declare (optimize (speed 3) (safety 1) (debug 1)))
	      (,vm-name (alloc-rgb) ,@lambda-list)))))