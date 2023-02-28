; Auto-generated. Do not edit!


(cl:in-package skiros2_msgs-msg)


;//! \htmlinclude Relation.msg.html

(cl:defclass <Relation> (roslisp-msg-protocol:ros-message)
  ((subjectId
    :reader subjectId
    :initarg :subjectId
    :type cl:string
    :initform "")
   (predicate
    :reader predicate
    :initarg :predicate
    :type cl:string
    :initform "")
   (objectId
    :reader objectId
    :initarg :objectId
    :type cl:string
    :initform ""))
)

(cl:defclass Relation (<Relation>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Relation>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Relation)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name skiros2_msgs-msg:<Relation> is deprecated: use skiros2_msgs-msg:Relation instead.")))

(cl:ensure-generic-function 'subjectId-val :lambda-list '(m))
(cl:defmethod subjectId-val ((m <Relation>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-msg:subjectId-val is deprecated.  Use skiros2_msgs-msg:subjectId instead.")
  (subjectId m))

(cl:ensure-generic-function 'predicate-val :lambda-list '(m))
(cl:defmethod predicate-val ((m <Relation>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-msg:predicate-val is deprecated.  Use skiros2_msgs-msg:predicate instead.")
  (predicate m))

(cl:ensure-generic-function 'objectId-val :lambda-list '(m))
(cl:defmethod objectId-val ((m <Relation>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-msg:objectId-val is deprecated.  Use skiros2_msgs-msg:objectId instead.")
  (objectId m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Relation>) ostream)
  "Serializes a message object of type '<Relation>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'subjectId))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'subjectId))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'predicate))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'predicate))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'objectId))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'objectId))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Relation>) istream)
  "Deserializes a message object of type '<Relation>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'subjectId) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'subjectId) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
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
      (cl:setf (cl:slot-value msg 'objectId) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'objectId) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Relation>)))
  "Returns string type for a message object of type '<Relation>"
  "skiros2_msgs/Relation")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Relation)))
  "Returns string type for a message object of type 'Relation"
  "skiros2_msgs/Relation")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Relation>)))
  "Returns md5sum for a message object of type '<Relation>"
  "6596e75cd61663ae5bcc18bf41e43915")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Relation)))
  "Returns md5sum for a message object of type 'Relation"
  "6596e75cd61663ae5bcc18bf41e43915")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Relation>)))
  "Returns full string definition for message of type '<Relation>"
  (cl:format cl:nil "string subjectId~%string predicate~%string objectId~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Relation)))
  "Returns full string definition for message of type 'Relation"
  (cl:format cl:nil "string subjectId~%string predicate~%string objectId~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Relation>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'subjectId))
     4 (cl:length (cl:slot-value msg 'predicate))
     4 (cl:length (cl:slot-value msg 'objectId))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Relation>))
  "Converts a ROS message object to a list"
  (cl:list 'Relation
    (cl:cons ':subjectId (subjectId msg))
    (cl:cons ':predicate (predicate msg))
    (cl:cons ':objectId (objectId msg))
))
