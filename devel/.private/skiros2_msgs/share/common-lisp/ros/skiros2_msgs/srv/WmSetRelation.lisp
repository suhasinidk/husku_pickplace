; Auto-generated. Do not edit!


(cl:in-package skiros2_msgs-srv)


;//! \htmlinclude WmSetRelation-request.msg.html

(cl:defclass <WmSetRelation-request> (roslisp-msg-protocol:ros-message)
  ((author
    :reader author
    :initarg :author
    :type cl:string
    :initform "")
   (relation
    :reader relation
    :initarg :relation
    :type skiros2_msgs-msg:Relation
    :initform (cl:make-instance 'skiros2_msgs-msg:Relation))
   (value
    :reader value
    :initarg :value
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass WmSetRelation-request (<WmSetRelation-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <WmSetRelation-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'WmSetRelation-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name skiros2_msgs-srv:<WmSetRelation-request> is deprecated: use skiros2_msgs-srv:WmSetRelation-request instead.")))

(cl:ensure-generic-function 'author-val :lambda-list '(m))
(cl:defmethod author-val ((m <WmSetRelation-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:author-val is deprecated.  Use skiros2_msgs-srv:author instead.")
  (author m))

(cl:ensure-generic-function 'relation-val :lambda-list '(m))
(cl:defmethod relation-val ((m <WmSetRelation-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:relation-val is deprecated.  Use skiros2_msgs-srv:relation instead.")
  (relation m))

(cl:ensure-generic-function 'value-val :lambda-list '(m))
(cl:defmethod value-val ((m <WmSetRelation-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:value-val is deprecated.  Use skiros2_msgs-srv:value instead.")
  (value m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <WmSetRelation-request>) ostream)
  "Serializes a message object of type '<WmSetRelation-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'author))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'author))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'relation) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'value) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <WmSetRelation-request>) istream)
  "Deserializes a message object of type '<WmSetRelation-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'author) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'author) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'relation) istream)
    (cl:setf (cl:slot-value msg 'value) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<WmSetRelation-request>)))
  "Returns string type for a service object of type '<WmSetRelation-request>"
  "skiros2_msgs/WmSetRelationRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'WmSetRelation-request)))
  "Returns string type for a service object of type 'WmSetRelation-request"
  "skiros2_msgs/WmSetRelationRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<WmSetRelation-request>)))
  "Returns md5sum for a message object of type '<WmSetRelation-request>"
  "77bf924d023af391d9b60bf1607be75e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'WmSetRelation-request)))
  "Returns md5sum for a message object of type 'WmSetRelation-request"
  "77bf924d023af391d9b60bf1607be75e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<WmSetRelation-request>)))
  "Returns full string definition for message of type '<WmSetRelation-request>"
  (cl:format cl:nil "string author~%Relation relation~%bool value~%~%================================================================================~%MSG: skiros2_msgs/Relation~%string subjectId~%string predicate~%string objectId~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'WmSetRelation-request)))
  "Returns full string definition for message of type 'WmSetRelation-request"
  (cl:format cl:nil "string author~%Relation relation~%bool value~%~%================================================================================~%MSG: skiros2_msgs/Relation~%string subjectId~%string predicate~%string objectId~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <WmSetRelation-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'author))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'relation))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <WmSetRelation-request>))
  "Converts a ROS message object to a list"
  (cl:list 'WmSetRelation-request
    (cl:cons ':author (author msg))
    (cl:cons ':relation (relation msg))
    (cl:cons ':value (value msg))
))
;//! \htmlinclude WmSetRelation-response.msg.html

(cl:defclass <WmSetRelation-response> (roslisp-msg-protocol:ros-message)
  ((ok
    :reader ok
    :initarg :ok
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass WmSetRelation-response (<WmSetRelation-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <WmSetRelation-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'WmSetRelation-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name skiros2_msgs-srv:<WmSetRelation-response> is deprecated: use skiros2_msgs-srv:WmSetRelation-response instead.")))

(cl:ensure-generic-function 'ok-val :lambda-list '(m))
(cl:defmethod ok-val ((m <WmSetRelation-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:ok-val is deprecated.  Use skiros2_msgs-srv:ok instead.")
  (ok m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <WmSetRelation-response>) ostream)
  "Serializes a message object of type '<WmSetRelation-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'ok) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <WmSetRelation-response>) istream)
  "Deserializes a message object of type '<WmSetRelation-response>"
    (cl:setf (cl:slot-value msg 'ok) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<WmSetRelation-response>)))
  "Returns string type for a service object of type '<WmSetRelation-response>"
  "skiros2_msgs/WmSetRelationResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'WmSetRelation-response)))
  "Returns string type for a service object of type 'WmSetRelation-response"
  "skiros2_msgs/WmSetRelationResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<WmSetRelation-response>)))
  "Returns md5sum for a message object of type '<WmSetRelation-response>"
  "77bf924d023af391d9b60bf1607be75e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'WmSetRelation-response)))
  "Returns md5sum for a message object of type 'WmSetRelation-response"
  "77bf924d023af391d9b60bf1607be75e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<WmSetRelation-response>)))
  "Returns full string definition for message of type '<WmSetRelation-response>"
  (cl:format cl:nil "bool ok~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'WmSetRelation-response)))
  "Returns full string definition for message of type 'WmSetRelation-response"
  (cl:format cl:nil "bool ok~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <WmSetRelation-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <WmSetRelation-response>))
  "Converts a ROS message object to a list"
  (cl:list 'WmSetRelation-response
    (cl:cons ':ok (ok msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'WmSetRelation)))
  'WmSetRelation-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'WmSetRelation)))
  'WmSetRelation-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'WmSetRelation)))
  "Returns string type for a service object of type '<WmSetRelation>"
  "skiros2_msgs/WmSetRelation")