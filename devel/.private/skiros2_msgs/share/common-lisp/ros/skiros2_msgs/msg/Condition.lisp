; Auto-generated. Do not edit!


(cl:in-package skiros2_msgs-msg)


;//! \htmlinclude Condition.msg.html

(cl:defclass <Condition> (roslisp-msg-protocol:ros-message)
  ((type
    :reader type
    :initarg :type
    :type cl:string
    :initform "")
   (label
    :reader label
    :initarg :label
    :type cl:string
    :initform "")
   (subject
    :reader subject
    :initarg :subject
    :type cl:string
    :initform "")
   (predicate
    :reader predicate
    :initarg :predicate
    :type cl:string
    :initform "")
   (object
    :reader object
    :initarg :object
    :type cl:string
    :initform "")
   (state
    :reader state
    :initarg :state
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass Condition (<Condition>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Condition>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Condition)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name skiros2_msgs-msg:<Condition> is deprecated: use skiros2_msgs-msg:Condition instead.")))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <Condition>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-msg:type-val is deprecated.  Use skiros2_msgs-msg:type instead.")
  (type m))

(cl:ensure-generic-function 'label-val :lambda-list '(m))
(cl:defmethod label-val ((m <Condition>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-msg:label-val is deprecated.  Use skiros2_msgs-msg:label instead.")
  (label m))

(cl:ensure-generic-function 'subject-val :lambda-list '(m))
(cl:defmethod subject-val ((m <Condition>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-msg:subject-val is deprecated.  Use skiros2_msgs-msg:subject instead.")
  (subject m))

(cl:ensure-generic-function 'predicate-val :lambda-list '(m))
(cl:defmethod predicate-val ((m <Condition>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-msg:predicate-val is deprecated.  Use skiros2_msgs-msg:predicate instead.")
  (predicate m))

(cl:ensure-generic-function 'object-val :lambda-list '(m))
(cl:defmethod object-val ((m <Condition>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-msg:object-val is deprecated.  Use skiros2_msgs-msg:object instead.")
  (object m))

(cl:ensure-generic-function 'state-val :lambda-list '(m))
(cl:defmethod state-val ((m <Condition>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-msg:state-val is deprecated.  Use skiros2_msgs-msg:state instead.")
  (state m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Condition>) ostream)
  "Serializes a message object of type '<Condition>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'type))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'type))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'label))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'label))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'subject))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'subject))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'predicate))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'predicate))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'object))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'object))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'state) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Condition>) istream)
  "Deserializes a message object of type '<Condition>"
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
      (cl:setf (cl:slot-value msg 'label) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'label) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'subject) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'subject) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'predicate) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'predicate) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'object) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'object) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:slot-value msg 'state) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Condition>)))
  "Returns string type for a message object of type '<Condition>"
  "skiros2_msgs/Condition")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Condition)))
  "Returns string type for a message object of type 'Condition"
  "skiros2_msgs/Condition")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Condition>)))
  "Returns md5sum for a message object of type '<Condition>"
  "bb14a9ac922b0de986bc6c6a486485a0")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Condition)))
  "Returns md5sum for a message object of type 'Condition"
  "bb14a9ac922b0de986bc6c6a486485a0")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Condition>)))
  "Returns full string definition for message of type '<Condition>"
  (cl:format cl:nil "string type~%string label~%string subject~%string predicate~%string object~%bool state~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Condition)))
  "Returns full string definition for message of type 'Condition"
  (cl:format cl:nil "string type~%string label~%string subject~%string predicate~%string object~%bool state~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Condition>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'type))
     4 (cl:length (cl:slot-value msg 'label))
     4 (cl:length (cl:slot-value msg 'subject))
     4 (cl:length (cl:slot-value msg 'predicate))
     4 (cl:length (cl:slot-value msg 'object))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Condition>))
  "Converts a ROS message object to a list"
  (cl:list 'Condition
    (cl:cons ':type (type msg))
    (cl:cons ':label (label msg))
    (cl:cons ':subject (subject msg))
    (cl:cons ':predicate (predicate msg))
    (cl:cons ':object (object msg))
    (cl:cons ':state (state msg))
))
