;; Auto-generated. Do not edit!


(when (boundp 'readEMG::EMG)
  (if (not (find-package "READEMG"))
    (make-package "READEMG"))
  (shadow 'EMG (find-package "READEMG")))
(unless (find-package "READEMG::EMG")
  (make-package "READEMG::EMG"))

(in-package "ROS")
;;//! \htmlinclude EMG.msg.html


(defclass readEMG::EMG
  :super ros::object
  :slots (_EMG1 _EMG2 ))

(defmethod readEMG::EMG
  (:init
   (&key
    ((:EMG1 __EMG1) 0)
    ((:EMG2 __EMG2) 0)
    )
   (send-super :init)
   (setq _EMG1 (round __EMG1))
   (setq _EMG2 (round __EMG2))
   self)
  (:EMG1
   (&optional __EMG1)
   (if __EMG1 (setq _EMG1 __EMG1)) _EMG1)
  (:EMG2
   (&optional __EMG2)
   (if __EMG2 (setq _EMG2 __EMG2)) _EMG2)
  (:serialization-length
   ()
   (+
    ;; int64 _EMG1
    8
    ;; int64 _EMG2
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int64 _EMG1
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _EMG1 (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _EMG1) (= (length (_EMG1 . bv)) 2)) ;; bignum
              (write-long (ash (elt (_EMG1 . bv) 0) 0) s)
              (write-long (ash (elt (_EMG1 . bv) 1) -1) s))
             ((and (class _EMG1) (= (length (_EMG1 . bv)) 1)) ;; big1
              (write-long (elt (_EMG1 . bv) 0) s)
              (write-long (if (>= _EMG1 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _EMG1 s)(write-long (if (>= _EMG1 0) 0 #xffffffff) s)))
     ;; int64 _EMG2
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _EMG2 (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _EMG2) (= (length (_EMG2 . bv)) 2)) ;; bignum
              (write-long (ash (elt (_EMG2 . bv) 0) 0) s)
              (write-long (ash (elt (_EMG2 . bv) 1) -1) s))
             ((and (class _EMG2) (= (length (_EMG2 . bv)) 1)) ;; big1
              (write-long (elt (_EMG2 . bv) 0) s)
              (write-long (if (>= _EMG2 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _EMG2 s)(write-long (if (>= _EMG2 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int64 _EMG1
#+(or :alpha :irix6 :x86_64)
      (setf _EMG1 (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _EMG1 (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _EMG2
#+(or :alpha :irix6 :x86_64)
      (setf _EMG2 (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _EMG2 (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;;
   self)
  )

(setf (get readEMG::EMG :md5sum-) "6de4f5ec7394cd197be042ac9d31b8b5")
(setf (get readEMG::EMG :datatype-) "readEMG/EMG")
(setf (get readEMG::EMG :definition-)
      "int64 EMG1
int64 EMG2

")



(provide :readEMG/EMG "6de4f5ec7394cd197be042ac9d31b8b5")


