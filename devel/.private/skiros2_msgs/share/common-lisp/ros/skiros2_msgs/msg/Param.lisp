; Auto-generated. Do not edit!


(cl:in-package skiros2_msgs-msg)


;//! \htmlinclude Param.msg.html

(cl:defclass <Param> (roslisp-msg-protocol:ros-message)
  ((param
    :reader param
    :initarg :param
    :type cl:string
    :initform ""))
)

(cl:defclass Param (<Param>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Param>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Param)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name skiros2_msgs-msg:<Param> is deprecated: use skiros2_msgs-msg:Param instead.")))

(cl:ensure-generic-function 'param-val :lambda-list '(m))
(cl:defmethod param-val ((m <Param>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-msg:param-val is deprecated.  Use skiros2_msgs-msg:param instead.")
  (param m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Param>) ostream)
  "Serializes a message object of type '<Param>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'param))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'param))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Param>) istream)
  "Deserializes a message object of type '<Param>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'param) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'param) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Param>)))
  "Returns string type for a message object of type '<Param>"
  "skiros2_msgs/Param")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Param)))
  "Returns string type for a message object of type 'Param"
  "skiros2_msgs/Param")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Param>)))
  "Returns md5sum for a message object of type '<Param>"
  "eb04b7504512676dca105ab8842899a4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Param)))
  "Returns md5sum for a message object of type 'Param"
  "eb04b7504512676dca105ab8842899a4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Param>)))
  "Returns full string definition for message of type '<Param>"
  (cl:format cl:nil "string param~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Param)))
  "Returns full string definition for message of type 'Param"
  (cl:format cl:nil "string param~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Param>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'param))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Param>))
  "Converts a ROS message object to a list"
  (cl:list 'Param
    (cl:cons ':param (param msg))
))
