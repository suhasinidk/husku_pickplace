; Auto-generated. Do not edit!


(cl:in-package skiros2_msgs-msg)


;//! \htmlinclude Property.msg.html

(cl:defclass <Property> (roslisp-msg-protocol:ros-message)
  ((key
    :reader key
    :initarg :key
    :type cl:string
    :initform "")
   (dataValue
    :reader dataValue
    :initarg :dataValue
    :type cl:string
    :initform "")
   (dataType
    :reader dataType
    :initarg :dataType
    :type cl:string
    :initform ""))
)

(cl:defclass Property (<Property>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Property>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Property)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name skiros2_msgs-msg:<Property> is deprecated: use skiros2_msgs-msg:Property instead.")))

(cl:ensure-generic-function 'key-val :lambda-list '(m))
(cl:defmethod key-val ((m <Property>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-msg:key-val is deprecated.  Use skiros2_msgs-msg:key instead.")
  (key m))

(cl:ensure-generic-function 'dataValue-val :lambda-list '(m))
(cl:defmethod dataValue-val ((m <Property>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-msg:dataValue-val is deprecated.  Use skiros2_msgs-msg:dataValue instead.")
  (dataValue m))

(cl:ensure-generic-function 'dataType-val :lambda-list '(m))
(cl:defmethod dataType-val ((m <Property>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-msg:dataType-val is deprecated.  Use skiros2_msgs-msg:dataType instead.")
  (dataType m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Property>) ostream)
  "Serializes a message object of type '<Property>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'key))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'key))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'dataValue))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'dataValue))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'dataType))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'dataType))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Property>) istream)
  "Deserializes a message object of type '<Property>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'key) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'key) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'dataValue) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'dataValue) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'dataType) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'dataType) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Property>)))
  "Returns string type for a message object of type '<Property>"
  "skiros2_msgs/Property")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Property)))
  "Returns string type for a message object of type 'Property"
  "skiros2_msgs/Property")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Property>)))
  "Returns md5sum for a message object of type '<Property>"
  "5b6c0ddf599766e37ee213fe87f04771")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Property)))
  "Returns md5sum for a message object of type 'Property"
  "5b6c0ddf599766e37ee213fe87f04771")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Property>)))
  "Returns full string definition for message of type '<Property>"
  (cl:format cl:nil "string key~%string dataValue~%string dataType~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Property)))
  "Returns full string definition for message of type 'Property"
  (cl:format cl:nil "string key~%string dataValue~%string dataType~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Property>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'key))
     4 (cl:length (cl:slot-value msg 'dataValue))
     4 (cl:length (cl:slot-value msg 'dataType))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Property>))
  "Converts a ROS message object to a list"
  (cl:list 'Property
    (cl:cons ':key (key msg))
    (cl:cons ':dataValue (dataValue msg))
    (cl:cons ':dataType (dataType msg))
))
