; Auto-generated. Do not edit!


(cl:in-package skiros2_msgs-msg)


;//! \htmlinclude AssignTaskResult.msg.html

(cl:defclass <AssignTaskResult> (roslisp-msg-protocol:ros-message)
  ((progress_code
    :reader progress_code
    :initarg :progress_code
    :type cl:fixnum
    :initform 0)
   (progress_message
    :reader progress_message
    :initarg :progress_message
    :type cl:string
    :initform ""))
)

(cl:defclass AssignTaskResult (<AssignTaskResult>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AssignTaskResult>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AssignTaskResult)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name skiros2_msgs-msg:<AssignTaskResult> is deprecated: use skiros2_msgs-msg:AssignTaskResult instead.")))

(cl:ensure-generic-function 'progress_code-val :lambda-list '(m))
(cl:defmethod progress_code-val ((m <AssignTaskResult>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-msg:progress_code-val is deprecated.  Use skiros2_msgs-msg:progress_code instead.")
  (progress_code m))

(cl:ensure-generic-function 'progress_message-val :lambda-list '(m))
(cl:defmethod progress_message-val ((m <AssignTaskResult>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-msg:progress_message-val is deprecated.  Use skiros2_msgs-msg:progress_message instead.")
  (progress_message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AssignTaskResult>) ostream)
  "Serializes a message object of type '<AssignTaskResult>"
  (cl:let* ((signed (cl:slot-value msg 'progress_code)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'progress_message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'progress_message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AssignTaskResult>) istream)
  "Deserializes a message object of type '<AssignTaskResult>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'progress_code) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'progress_message) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'progress_message) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AssignTaskResult>)))
  "Returns string type for a message object of type '<AssignTaskResult>"
  "skiros2_msgs/AssignTaskResult")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AssignTaskResult)))
  "Returns string type for a message object of type 'AssignTaskResult"
  "skiros2_msgs/AssignTaskResult")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AssignTaskResult>)))
  "Returns md5sum for a message object of type '<AssignTaskResult>"
  "618c38785819b45ec2970116048e0af3")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AssignTaskResult)))
  "Returns md5sum for a message object of type 'AssignTaskResult"
  "618c38785819b45ec2970116048e0af3")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AssignTaskResult>)))
  "Returns full string definition for message of type '<AssignTaskResult>"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%int16 progress_code~%string progress_message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AssignTaskResult)))
  "Returns full string definition for message of type 'AssignTaskResult"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%int16 progress_code~%string progress_message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AssignTaskResult>))
  (cl:+ 0
     2
     4 (cl:length (cl:slot-value msg 'progress_message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AssignTaskResult>))
  "Converts a ROS message object to a list"
  (cl:list 'AssignTaskResult
    (cl:cons ':progress_code (progress_code msg))
    (cl:cons ':progress_message (progress_message msg))
))
