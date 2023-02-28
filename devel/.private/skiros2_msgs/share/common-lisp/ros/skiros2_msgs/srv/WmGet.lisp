; Auto-generated. Do not edit!


(cl:in-package skiros2_msgs-srv)


;//! \htmlinclude WmGet-request.msg.html

(cl:defclass <WmGet-request> (roslisp-msg-protocol:ros-message)
  ((action
    :reader action
    :initarg :action
    :type cl:string
    :initform "")
   (context
    :reader context
    :initarg :context
    :type cl:string
    :initform "")
   (element
    :reader element
    :initarg :element
    :type skiros2_msgs-msg:WmElement
    :initform (cl:make-instance 'skiros2_msgs-msg:WmElement))
   (relation_filter
    :reader relation_filter
    :initarg :relation_filter
    :type cl:string
    :initform "")
   (type_filter
    :reader type_filter
    :initarg :type_filter
    :type cl:string
    :initform ""))
)

(cl:defclass WmGet-request (<WmGet-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <WmGet-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'WmGet-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name skiros2_msgs-srv:<WmGet-request> is deprecated: use skiros2_msgs-srv:WmGet-request instead.")))

(cl:ensure-generic-function 'action-val :lambda-list '(m))
(cl:defmethod action-val ((m <WmGet-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:action-val is deprecated.  Use skiros2_msgs-srv:action instead.")
  (action m))

(cl:ensure-generic-function 'context-val :lambda-list '(m))
(cl:defmethod context-val ((m <WmGet-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:context-val is deprecated.  Use skiros2_msgs-srv:context instead.")
  (context m))

(cl:ensure-generic-function 'element-val :lambda-list '(m))
(cl:defmethod element-val ((m <WmGet-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:element-val is deprecated.  Use skiros2_msgs-srv:element instead.")
  (element m))

(cl:ensure-generic-function 'relation_filter-val :lambda-list '(m))
(cl:defmethod relation_filter-val ((m <WmGet-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:relation_filter-val is deprecated.  Use skiros2_msgs-srv:relation_filter instead.")
  (relation_filter m))

(cl:ensure-generic-function 'type_filter-val :lambda-list '(m))
(cl:defmethod type_filter-val ((m <WmGet-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:type_filter-val is deprecated.  Use skiros2_msgs-srv:type_filter instead.")
  (type_filter m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<WmGet-request>)))
    "Constants for message type '<WmGet-request>"
  '((:GET . get)
    (:GET_TEMPLATE . get_template)
    (:RESOLVE . resolve)
    (:GET_RECURSIVE . get_recursive))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'WmGet-request)))
    "Constants for message type 'WmGet-request"
  '((:GET . get)
    (:GET_TEMPLATE . get_template)
    (:RESOLVE . resolve)
    (:GET_RECURSIVE . get_recursive))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <WmGet-request>) ostream)
  "Serializes a message object of type '<WmGet-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'action))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'action))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'context))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'context))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'element) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'relation_filter))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'relation_filter))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'type_filter))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'type_filter))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <WmGet-request>) istream)
  "Deserializes a message object of type '<WmGet-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'action) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'action) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'context) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'context) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'element) istream)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'relation_filter) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'relation_filter) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'type_filter) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'type_filter) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<WmGet-request>)))
  "Returns string type for a service object of type '<WmGet-request>"
  "skiros2_msgs/WmGetRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'WmGet-request)))
  "Returns string type for a service object of type 'WmGet-request"
  "skiros2_msgs/WmGetRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<WmGet-request>)))
  "Returns md5sum for a message object of type '<WmGet-request>"
  "a03c7fe28a0cdf8073d54434e678721d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'WmGet-request)))
  "Returns md5sum for a message object of type 'WmGet-request"
  "a03c7fe28a0cdf8073d54434e678721d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<WmGet-request>)))
  "Returns full string definition for message of type '<WmGet-request>"
  (cl:format cl:nil "#Possible actions~%string GET=get~%string GET_TEMPLATE=get_template~%string RESOLVE=resolve~%string GET_RECURSIVE=get_recursive~%~%string action~%string context~%WmElement element~%string relation_filter~%string type_filter~%~%================================================================================~%MSG: skiros2_msgs/WmElement~%string id~%string type~%string label~%Property[] properties~%Relation[] relations~%~%================================================================================~%MSG: skiros2_msgs/Property~%string key~%string dataValue~%string dataType~%~%================================================================================~%MSG: skiros2_msgs/Relation~%string subjectId~%string predicate~%string objectId~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'WmGet-request)))
  "Returns full string definition for message of type 'WmGet-request"
  (cl:format cl:nil "#Possible actions~%string GET=get~%string GET_TEMPLATE=get_template~%string RESOLVE=resolve~%string GET_RECURSIVE=get_recursive~%~%string action~%string context~%WmElement element~%string relation_filter~%string type_filter~%~%================================================================================~%MSG: skiros2_msgs/WmElement~%string id~%string type~%string label~%Property[] properties~%Relation[] relations~%~%================================================================================~%MSG: skiros2_msgs/Property~%string key~%string dataValue~%string dataType~%~%================================================================================~%MSG: skiros2_msgs/Relation~%string subjectId~%string predicate~%string objectId~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <WmGet-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'action))
     4 (cl:length (cl:slot-value msg 'context))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'element))
     4 (cl:length (cl:slot-value msg 'relation_filter))
     4 (cl:length (cl:slot-value msg 'type_filter))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <WmGet-request>))
  "Converts a ROS message object to a list"
  (cl:list 'WmGet-request
    (cl:cons ':action (action msg))
    (cl:cons ':context (context msg))
    (cl:cons ':element (element msg))
    (cl:cons ':relation_filter (relation_filter msg))
    (cl:cons ':type_filter (type_filter msg))
))
;//! \htmlinclude WmGet-response.msg.html

(cl:defclass <WmGet-response> (roslisp-msg-protocol:ros-message)
  ((snapshot_id
    :reader snapshot_id
    :initarg :snapshot_id
    :type cl:string
    :initform "")
   (elements
    :reader elements
    :initarg :elements
    :type (cl:vector skiros2_msgs-msg:WmElement)
   :initform (cl:make-array 0 :element-type 'skiros2_msgs-msg:WmElement :initial-element (cl:make-instance 'skiros2_msgs-msg:WmElement))))
)

(cl:defclass WmGet-response (<WmGet-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <WmGet-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'WmGet-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name skiros2_msgs-srv:<WmGet-response> is deprecated: use skiros2_msgs-srv:WmGet-response instead.")))

(cl:ensure-generic-function 'snapshot_id-val :lambda-list '(m))
(cl:defmethod snapshot_id-val ((m <WmGet-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:snapshot_id-val is deprecated.  Use skiros2_msgs-srv:snapshot_id instead.")
  (snapshot_id m))

(cl:ensure-generic-function 'elements-val :lambda-list '(m))
(cl:defmethod elements-val ((m <WmGet-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:elements-val is deprecated.  Use skiros2_msgs-srv:elements instead.")
  (elements m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <WmGet-response>) ostream)
  "Serializes a message object of type '<WmGet-response>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'snapshot_id))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'snapshot_id))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'elements))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'elements))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <WmGet-response>) istream)
  "Deserializes a message object of type '<WmGet-response>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'snapshot_id) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'snapshot_id) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'elements) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'elements)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'skiros2_msgs-msg:WmElement))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<WmGet-response>)))
  "Returns string type for a service object of type '<WmGet-response>"
  "skiros2_msgs/WmGetResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'WmGet-response)))
  "Returns string type for a service object of type 'WmGet-response"
  "skiros2_msgs/WmGetResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<WmGet-response>)))
  "Returns md5sum for a message object of type '<WmGet-response>"
  "a03c7fe28a0cdf8073d54434e678721d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'WmGet-response)))
  "Returns md5sum for a message object of type 'WmGet-response"
  "a03c7fe28a0cdf8073d54434e678721d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<WmGet-response>)))
  "Returns full string definition for message of type '<WmGet-response>"
  (cl:format cl:nil "string snapshot_id~%WmElement[] elements~%~%~%================================================================================~%MSG: skiros2_msgs/WmElement~%string id~%string type~%string label~%Property[] properties~%Relation[] relations~%~%================================================================================~%MSG: skiros2_msgs/Property~%string key~%string dataValue~%string dataType~%~%================================================================================~%MSG: skiros2_msgs/Relation~%string subjectId~%string predicate~%string objectId~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'WmGet-response)))
  "Returns full string definition for message of type 'WmGet-response"
  (cl:format cl:nil "string snapshot_id~%WmElement[] elements~%~%~%================================================================================~%MSG: skiros2_msgs/WmElement~%string id~%string type~%string label~%Property[] properties~%Relation[] relations~%~%================================================================================~%MSG: skiros2_msgs/Property~%string key~%string dataValue~%string dataType~%~%================================================================================~%MSG: skiros2_msgs/Relation~%string subjectId~%string predicate~%string objectId~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <WmGet-response>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'snapshot_id))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'elements) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <WmGet-response>))
  "Converts a ROS message object to a list"
  (cl:list 'WmGet-response
    (cl:cons ':snapshot_id (snapshot_id msg))
    (cl:cons ':elements (elements msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'WmGet)))
  'WmGet-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'WmGet)))
  'WmGet-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'WmGet)))
  "Returns string type for a service object of type '<WmGet>"
  "skiros2_msgs/WmGet")