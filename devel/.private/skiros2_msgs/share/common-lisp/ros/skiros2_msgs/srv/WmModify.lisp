; Auto-generated. Do not edit!


(cl:in-package skiros2_msgs-srv)


;//! \htmlinclude WmModify-request.msg.html

(cl:defclass <WmModify-request> (roslisp-msg-protocol:ros-message)
  ((author
    :reader author
    :initarg :author
    :type cl:string
    :initform "")
   (action
    :reader action
    :initarg :action
    :type cl:string
    :initform "")
   (relation_filter
    :reader relation_filter
    :initarg :relation_filter
    :type cl:string
    :initform "")
   (type_filter
    :reader type_filter
    :initarg :type_filter
    :type cl:string
    :initform "")
   (context
    :reader context
    :initarg :context
    :type cl:string
    :initform "")
   (elements
    :reader elements
    :initarg :elements
    :type (cl:vector skiros2_msgs-msg:WmElement)
   :initform (cl:make-array 0 :element-type 'skiros2_msgs-msg:WmElement :initial-element (cl:make-instance 'skiros2_msgs-msg:WmElement))))
)

(cl:defclass WmModify-request (<WmModify-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <WmModify-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'WmModify-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name skiros2_msgs-srv:<WmModify-request> is deprecated: use skiros2_msgs-srv:WmModify-request instead.")))

(cl:ensure-generic-function 'author-val :lambda-list '(m))
(cl:defmethod author-val ((m <WmModify-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:author-val is deprecated.  Use skiros2_msgs-srv:author instead.")
  (author m))

(cl:ensure-generic-function 'action-val :lambda-list '(m))
(cl:defmethod action-val ((m <WmModify-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:action-val is deprecated.  Use skiros2_msgs-srv:action instead.")
  (action m))

(cl:ensure-generic-function 'relation_filter-val :lambda-list '(m))
(cl:defmethod relation_filter-val ((m <WmModify-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:relation_filter-val is deprecated.  Use skiros2_msgs-srv:relation_filter instead.")
  (relation_filter m))

(cl:ensure-generic-function 'type_filter-val :lambda-list '(m))
(cl:defmethod type_filter-val ((m <WmModify-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:type_filter-val is deprecated.  Use skiros2_msgs-srv:type_filter instead.")
  (type_filter m))

(cl:ensure-generic-function 'context-val :lambda-list '(m))
(cl:defmethod context-val ((m <WmModify-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:context-val is deprecated.  Use skiros2_msgs-srv:context instead.")
  (context m))

(cl:ensure-generic-function 'elements-val :lambda-list '(m))
(cl:defmethod elements-val ((m <WmModify-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:elements-val is deprecated.  Use skiros2_msgs-srv:elements instead.")
  (elements m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<WmModify-request>)))
    "Constants for message type '<WmModify-request>"
  '((:ADD . add)
    (:UPDATE . update)
    (:UPDATE_PROPERTIES . update_properties)
    (:REMOVE . remove)
    (:REMOVE_RECURSIVE . remove_recursive))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'WmModify-request)))
    "Constants for message type 'WmModify-request"
  '((:ADD . add)
    (:UPDATE . update)
    (:UPDATE_PROPERTIES . update_properties)
    (:REMOVE . remove)
    (:REMOVE_RECURSIVE . remove_recursive))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <WmModify-request>) ostream)
  "Serializes a message object of type '<WmModify-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'author))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'author))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'action))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'action))
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
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'context))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'context))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'elements))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'elements))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <WmModify-request>) istream)
  "Deserializes a message object of type '<WmModify-request>"
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
      (cl:setf (cl:slot-value msg 'action) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'action) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
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
  (cl:setf (cl:slot-value msg 'elements) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'elements)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'skiros2_msgs-msg:WmElement))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<WmModify-request>)))
  "Returns string type for a service object of type '<WmModify-request>"
  "skiros2_msgs/WmModifyRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'WmModify-request)))
  "Returns string type for a service object of type 'WmModify-request"
  "skiros2_msgs/WmModifyRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<WmModify-request>)))
  "Returns md5sum for a message object of type '<WmModify-request>"
  "3777804bb09a7d142574f0ae4bc21501")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'WmModify-request)))
  "Returns md5sum for a message object of type 'WmModify-request"
  "3777804bb09a7d142574f0ae4bc21501")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<WmModify-request>)))
  "Returns full string definition for message of type '<WmModify-request>"
  (cl:format cl:nil "#Possible actions~%string ADD=add~%string UPDATE=update~%string UPDATE_PROPERTIES=update_properties~%string REMOVE=remove~%string REMOVE_RECURSIVE=remove_recursive~%~%string author~%string action~%string relation_filter~%string type_filter~%string context~%WmElement[] elements~%~%================================================================================~%MSG: skiros2_msgs/WmElement~%string id~%string type~%string label~%Property[] properties~%Relation[] relations~%~%================================================================================~%MSG: skiros2_msgs/Property~%string key~%string dataValue~%string dataType~%~%================================================================================~%MSG: skiros2_msgs/Relation~%string subjectId~%string predicate~%string objectId~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'WmModify-request)))
  "Returns full string definition for message of type 'WmModify-request"
  (cl:format cl:nil "#Possible actions~%string ADD=add~%string UPDATE=update~%string UPDATE_PROPERTIES=update_properties~%string REMOVE=remove~%string REMOVE_RECURSIVE=remove_recursive~%~%string author~%string action~%string relation_filter~%string type_filter~%string context~%WmElement[] elements~%~%================================================================================~%MSG: skiros2_msgs/WmElement~%string id~%string type~%string label~%Property[] properties~%Relation[] relations~%~%================================================================================~%MSG: skiros2_msgs/Property~%string key~%string dataValue~%string dataType~%~%================================================================================~%MSG: skiros2_msgs/Relation~%string subjectId~%string predicate~%string objectId~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <WmModify-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'author))
     4 (cl:length (cl:slot-value msg 'action))
     4 (cl:length (cl:slot-value msg 'relation_filter))
     4 (cl:length (cl:slot-value msg 'type_filter))
     4 (cl:length (cl:slot-value msg 'context))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'elements) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <WmModify-request>))
  "Converts a ROS message object to a list"
  (cl:list 'WmModify-request
    (cl:cons ':author (author msg))
    (cl:cons ':action (action msg))
    (cl:cons ':relation_filter (relation_filter msg))
    (cl:cons ':type_filter (type_filter msg))
    (cl:cons ':context (context msg))
    (cl:cons ':elements (elements msg))
))
;//! \htmlinclude WmModify-response.msg.html

(cl:defclass <WmModify-response> (roslisp-msg-protocol:ros-message)
  ((elements
    :reader elements
    :initarg :elements
    :type (cl:vector skiros2_msgs-msg:WmElement)
   :initform (cl:make-array 0 :element-type 'skiros2_msgs-msg:WmElement :initial-element (cl:make-instance 'skiros2_msgs-msg:WmElement))))
)

(cl:defclass WmModify-response (<WmModify-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <WmModify-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'WmModify-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name skiros2_msgs-srv:<WmModify-response> is deprecated: use skiros2_msgs-srv:WmModify-response instead.")))

(cl:ensure-generic-function 'elements-val :lambda-list '(m))
(cl:defmethod elements-val ((m <WmModify-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:elements-val is deprecated.  Use skiros2_msgs-srv:elements instead.")
  (elements m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <WmModify-response>) ostream)
  "Serializes a message object of type '<WmModify-response>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'elements))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'elements))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <WmModify-response>) istream)
  "Deserializes a message object of type '<WmModify-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<WmModify-response>)))
  "Returns string type for a service object of type '<WmModify-response>"
  "skiros2_msgs/WmModifyResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'WmModify-response)))
  "Returns string type for a service object of type 'WmModify-response"
  "skiros2_msgs/WmModifyResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<WmModify-response>)))
  "Returns md5sum for a message object of type '<WmModify-response>"
  "3777804bb09a7d142574f0ae4bc21501")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'WmModify-response)))
  "Returns md5sum for a message object of type 'WmModify-response"
  "3777804bb09a7d142574f0ae4bc21501")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<WmModify-response>)))
  "Returns full string definition for message of type '<WmModify-response>"
  (cl:format cl:nil "#ADD/UPDATE/UPDATE_PROPERTIES: return updated elements REMOVE/REMOVE_RECURSIVE: return nothing~%WmElement[] elements~%~%~%================================================================================~%MSG: skiros2_msgs/WmElement~%string id~%string type~%string label~%Property[] properties~%Relation[] relations~%~%================================================================================~%MSG: skiros2_msgs/Property~%string key~%string dataValue~%string dataType~%~%================================================================================~%MSG: skiros2_msgs/Relation~%string subjectId~%string predicate~%string objectId~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'WmModify-response)))
  "Returns full string definition for message of type 'WmModify-response"
  (cl:format cl:nil "#ADD/UPDATE/UPDATE_PROPERTIES: return updated elements REMOVE/REMOVE_RECURSIVE: return nothing~%WmElement[] elements~%~%~%================================================================================~%MSG: skiros2_msgs/WmElement~%string id~%string type~%string label~%Property[] properties~%Relation[] relations~%~%================================================================================~%MSG: skiros2_msgs/Property~%string key~%string dataValue~%string dataType~%~%================================================================================~%MSG: skiros2_msgs/Relation~%string subjectId~%string predicate~%string objectId~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <WmModify-response>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'elements) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <WmModify-response>))
  "Converts a ROS message object to a list"
  (cl:list 'WmModify-response
    (cl:cons ':elements (elements msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'WmModify)))
  'WmModify-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'WmModify)))
  'WmModify-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'WmModify)))
  "Returns string type for a service object of type '<WmModify>"
  "skiros2_msgs/WmModify")