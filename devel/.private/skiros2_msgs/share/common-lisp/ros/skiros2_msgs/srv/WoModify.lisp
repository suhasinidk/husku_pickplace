; Auto-generated. Do not edit!


(cl:in-package skiros2_msgs-srv)


;//! \htmlinclude WoModify-request.msg.html

(cl:defclass <WoModify-request> (roslisp-msg-protocol:ros-message)
  ((author
    :reader author
    :initarg :author
    :type cl:string
    :initform "")
   (context
    :reader context
    :initarg :context
    :type cl:string
    :initform "")
   (statements
    :reader statements
    :initarg :statements
    :type (cl:vector skiros2_msgs-msg:Statement)
   :initform (cl:make-array 0 :element-type 'skiros2_msgs-msg:Statement :initial-element (cl:make-instance 'skiros2_msgs-msg:Statement))))
)

(cl:defclass WoModify-request (<WoModify-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <WoModify-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'WoModify-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name skiros2_msgs-srv:<WoModify-request> is deprecated: use skiros2_msgs-srv:WoModify-request instead.")))

(cl:ensure-generic-function 'author-val :lambda-list '(m))
(cl:defmethod author-val ((m <WoModify-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:author-val is deprecated.  Use skiros2_msgs-srv:author instead.")
  (author m))

(cl:ensure-generic-function 'context-val :lambda-list '(m))
(cl:defmethod context-val ((m <WoModify-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:context-val is deprecated.  Use skiros2_msgs-srv:context instead.")
  (context m))

(cl:ensure-generic-function 'statements-val :lambda-list '(m))
(cl:defmethod statements-val ((m <WoModify-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:statements-val is deprecated.  Use skiros2_msgs-srv:statements instead.")
  (statements m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <WoModify-request>) ostream)
  "Serializes a message object of type '<WoModify-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'author))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'author))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'context))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'context))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'statements))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'statements))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <WoModify-request>) istream)
  "Deserializes a message object of type '<WoModify-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'author) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'author) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'context) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'context) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'statements) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'statements)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'skiros2_msgs-msg:Statement))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<WoModify-request>)))
  "Returns string type for a service object of type '<WoModify-request>"
  "skiros2_msgs/WoModifyRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'WoModify-request)))
  "Returns string type for a service object of type 'WoModify-request"
  "skiros2_msgs/WoModifyRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<WoModify-request>)))
  "Returns md5sum for a message object of type '<WoModify-request>"
  "dd76bb6e56a5980cc554cb4a6047bd97")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'WoModify-request)))
  "Returns md5sum for a message object of type 'WoModify-request"
  "dd76bb6e56a5980cc554cb4a6047bd97")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<WoModify-request>)))
  "Returns full string definition for message of type '<WoModify-request>"
  (cl:format cl:nil "string author~%string context~%Statement[] statements~%~%================================================================================~%MSG: skiros2_msgs/Statement~%Relation relation~%bool value~%~%================================================================================~%MSG: skiros2_msgs/Relation~%string subjectId~%string predicate~%string objectId~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'WoModify-request)))
  "Returns full string definition for message of type 'WoModify-request"
  (cl:format cl:nil "string author~%string context~%Statement[] statements~%~%================================================================================~%MSG: skiros2_msgs/Statement~%Relation relation~%bool value~%~%================================================================================~%MSG: skiros2_msgs/Relation~%string subjectId~%string predicate~%string objectId~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <WoModify-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'author))
     4 (cl:length (cl:slot-value msg 'context))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'statements) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <WoModify-request>))
  "Converts a ROS message object to a list"
  (cl:list 'WoModify-request
    (cl:cons ':author (author msg))
    (cl:cons ':context (context msg))
    (cl:cons ':statements (statements msg))
))
;//! \htmlinclude WoModify-response.msg.html

(cl:defclass <WoModify-response> (roslisp-msg-protocol:ros-message)
  ((ok
    :reader ok
    :initarg :ok
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass WoModify-response (<WoModify-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <WoModify-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'WoModify-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name skiros2_msgs-srv:<WoModify-response> is deprecated: use skiros2_msgs-srv:WoModify-response instead.")))

(cl:ensure-generic-function 'ok-val :lambda-list '(m))
(cl:defmethod ok-val ((m <WoModify-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:ok-val is deprecated.  Use skiros2_msgs-srv:ok instead.")
  (ok m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <WoModify-response>) ostream)
  "Serializes a message object of type '<WoModify-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'ok) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <WoModify-response>) istream)
  "Deserializes a message object of type '<WoModify-response>"
    (cl:setf (cl:slot-value msg 'ok) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<WoModify-response>)))
  "Returns string type for a service object of type '<WoModify-response>"
  "skiros2_msgs/WoModifyResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'WoModify-response)))
  "Returns string type for a service object of type 'WoModify-response"
  "skiros2_msgs/WoModifyResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<WoModify-response>)))
  "Returns md5sum for a message object of type '<WoModify-response>"
  "dd76bb6e56a5980cc554cb4a6047bd97")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'WoModify-response)))
  "Returns md5sum for a message object of type 'WoModify-response"
  "dd76bb6e56a5980cc554cb4a6047bd97")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<WoModify-response>)))
  "Returns full string definition for message of type '<WoModify-response>"
  (cl:format cl:nil "bool ok~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'WoModify-response)))
  "Returns full string definition for message of type 'WoModify-response"
  (cl:format cl:nil "bool ok~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <WoModify-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <WoModify-response>))
  "Converts a ROS message object to a list"
  (cl:list 'WoModify-response
    (cl:cons ':ok (ok msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'WoModify)))
  'WoModify-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'WoModify)))
  'WoModify-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'WoModify)))
  "Returns string type for a service object of type '<WoModify>"
  "skiros2_msgs/WoModify")