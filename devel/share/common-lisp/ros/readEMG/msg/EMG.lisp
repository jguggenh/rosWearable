; Auto-generated. Do not edit!


(cl:in-package readEMG-msg)


;//! \htmlinclude EMG.msg.html

(cl:defclass <EMG> (roslisp-msg-protocol:ros-message)
  ((EMG1
    :reader EMG1
    :initarg :EMG1
    :type cl:integer
    :initform 0)
   (EMG2
    :reader EMG2
    :initarg :EMG2
    :type cl:integer
    :initform 0))
)

(cl:defclass EMG (<EMG>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <EMG>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'EMG)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name readEMG-msg:<EMG> is deprecated: use readEMG-msg:EMG instead.")))

(cl:ensure-generic-function 'EMG1-val :lambda-list '(m))
(cl:defmethod EMG1-val ((m <EMG>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader readEMG-msg:EMG1-val is deprecated.  Use readEMG-msg:EMG1 instead.")
  (EMG1 m))

(cl:ensure-generic-function 'EMG2-val :lambda-list '(m))
(cl:defmethod EMG2-val ((m <EMG>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader readEMG-msg:EMG2-val is deprecated.  Use readEMG-msg:EMG2 instead.")
  (EMG2 m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <EMG>) ostream)
  "Serializes a message object of type '<EMG>"
  (cl:let* ((signed (cl:slot-value msg 'EMG1)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'EMG2)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <EMG>) istream)
  "Deserializes a message object of type '<EMG>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'EMG1) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'EMG2) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<EMG>)))
  "Returns string type for a message object of type '<EMG>"
  "readEMG/EMG")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'EMG)))
  "Returns string type for a message object of type 'EMG"
  "readEMG/EMG")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<EMG>)))
  "Returns md5sum for a message object of type '<EMG>"
  "6de4f5ec7394cd197be042ac9d31b8b5")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'EMG)))
  "Returns md5sum for a message object of type 'EMG"
  "6de4f5ec7394cd197be042ac9d31b8b5")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<EMG>)))
  "Returns full string definition for message of type '<EMG>"
  (cl:format cl:nil "int64 EMG1~%int64 EMG2~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'EMG)))
  "Returns full string definition for message of type 'EMG"
  (cl:format cl:nil "int64 EMG1~%int64 EMG2~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <EMG>))
  (cl:+ 0
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <EMG>))
  "Converts a ROS message object to a list"
  (cl:list 'EMG
    (cl:cons ':EMG1 (EMG1 msg))
    (cl:cons ':EMG2 (EMG2 msg))
))
