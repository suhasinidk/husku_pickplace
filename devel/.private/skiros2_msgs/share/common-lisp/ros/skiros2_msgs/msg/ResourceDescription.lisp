; Auto-generated. Do not edit!


(cl:in-package skiros2_msgs-msg)


;//! \htmlinclude ResourceDescription.msg.html

(cl:defclass <ResourceDescription> (roslisp-msg-protocol:ros-message)
  ((type
    :reader type
    :initarg :type
    :type cl:string
    :initform "")
   (name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (params
    :reader params
    :initarg :params
    :type (cl:vector skiros2_msgs-msg:Param)
   :initform (cl:make-array 0 :element-type 'skiros2_msgs-msg:Param :initial-element (cl:make-instance 'skiros2_msgs-msg:Param))))
)

(cl:defclass ResourceDescription (<ResourceDescription>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ResourceDescription>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ResourceDescription)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name skiros2_msgs-msg:<ResourceDescription> is deprecated: use skiros2_msgs-msg:ResourceDescription instead.")))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <ResourceDescription>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-msg:type-val is deprecated.  Use skiros2_msgs-msg:type instead.")
  (type m))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <ResourceDescription>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-msg:name-val is deprecated.  Use skiros2_msgs-msg:name instead.")
  (name m))

(cl:ensure-generic-function 'params-val :lambda-list '(m))
(cl:defmethod params-val ((m <ResourceDescription>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-msg:params-val is deprecated.  Use skiros2_msgs-msg:params instead.")
  (params m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ResourceDescription>) ostream)
  "Serializes a message object of type '<ResourceDescription>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'type))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'type))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'params))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'params))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ResourceDescription>) istream)
  "Deserializes a message object of type '<ResourceDescription>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'type) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'type) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'params) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'params)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'skiros2_msgs-msg:Param))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ResourceDescription>)))
  "Returns string type for a message object of type '<ResourceDescription>"
  "skiros2_msgs/ResourceDescription")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ResourceDescription)))
  "Returns string type for a message object of type 'ResourceDescription"
  "skiros2_msgs/ResourceDescription")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ResourceDescription>)))
  "Returns md5sum for a message object of type '<ResourceDescription>"
  "f305b743733527b01e745de4106cca51")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ResourceDescription)))
  "Returns md5sum for a message object of type 'ResourceDescription"
  "f305b743733527b01e745de4106cca51")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ResourceDescription>)))
  "Returns full string definition for message of type '<ResourceDescription>"
  (cl:format cl:nil "string type~%string name~%Param[] params~%~%================================================================================~%MSG: skiros2_msgs/Param~%string param~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ResourceDescription)))
  "Returns full string definition for message of type 'ResourceDescription"
  (cl:format cl:nil "string type~%string name~%Param[] params~%~%================================================================================~%MSG: skiros2_msgs/Param~%string param~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ResourceDescription>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'type))
     4 (cl:length (cl:slot-value msg 'name))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'params) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ResourceDescription>))
  "Converts a ROS message object to a list"
  (cl:list 'ResourceDescription
    (cl:cons ':type (type msg))
    (cl:cons ':name (name msg))
    (cl:cons ':params (params msg))
))
