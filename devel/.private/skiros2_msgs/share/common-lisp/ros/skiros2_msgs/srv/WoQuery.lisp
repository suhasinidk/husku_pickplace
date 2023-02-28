; Auto-generated. Do not edit!


(cl:in-package skiros2_msgs-srv)


;//! \htmlinclude WoQuery-request.msg.html

(cl:defclass <WoQuery-request> (roslisp-msg-protocol:ros-message)
  ((query_string
    :reader query_string
    :initarg :query_string
    :type cl:string
    :initform "")
   (context
    :reader context
    :initarg :context
    :type cl:string
    :initform "")
   (cut_prefix
    :reader cut_prefix
    :initarg :cut_prefix
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass WoQuery-request (<WoQuery-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <WoQuery-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'WoQuery-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name skiros2_msgs-srv:<WoQuery-request> is deprecated: use skiros2_msgs-srv:WoQuery-request instead.")))

(cl:ensure-generic-function 'query_string-val :lambda-list '(m))
(cl:defmethod query_string-val ((m <WoQuery-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:query_string-val is deprecated.  Use skiros2_msgs-srv:query_string instead.")
  (query_string m))

(cl:ensure-generic-function 'context-val :lambda-list '(m))
(cl:defmethod context-val ((m <WoQuery-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:context-val is deprecated.  Use skiros2_msgs-srv:context instead.")
  (context m))

(cl:ensure-generic-function 'cut_prefix-val :lambda-list '(m))
(cl:defmethod cut_prefix-val ((m <WoQuery-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:cut_prefix-val is deprecated.  Use skiros2_msgs-srv:cut_prefix instead.")
  (cut_prefix m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <WoQuery-request>) ostream)
  "Serializes a message object of type '<WoQuery-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'query_string))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'query_string))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'context))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'context))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'cut_prefix) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <WoQuery-request>) istream)
  "Deserializes a message object of type '<WoQuery-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'query_string) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'query_string) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'context) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'context) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:slot-value msg 'cut_prefix) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<WoQuery-request>)))
  "Returns string type for a service object of type '<WoQuery-request>"
  "skiros2_msgs/WoQueryRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'WoQuery-request)))
  "Returns string type for a service object of type 'WoQuery-request"
  "skiros2_msgs/WoQueryRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<WoQuery-request>)))
  "Returns md5sum for a message object of type '<WoQuery-request>"
  "c279e11806ad32f0e36af84c5a02aba8")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'WoQuery-request)))
  "Returns md5sum for a message object of type 'WoQuery-request"
  "c279e11806ad32f0e36af84c5a02aba8")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<WoQuery-request>)))
  "Returns full string definition for message of type '<WoQuery-request>"
  (cl:format cl:nil "#World Ontology query message~%#Std Owl query (use SPARQL syntax, e.g. \"SELECT ?x WHERE { ?x rdf:type stmn:GraspingPose. }\")~%string query_string~%string context~%bool cut_prefix~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'WoQuery-request)))
  "Returns full string definition for message of type 'WoQuery-request"
  (cl:format cl:nil "#World Ontology query message~%#Std Owl query (use SPARQL syntax, e.g. \"SELECT ?x WHERE { ?x rdf:type stmn:GraspingPose. }\")~%string query_string~%string context~%bool cut_prefix~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <WoQuery-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'query_string))
     4 (cl:length (cl:slot-value msg 'context))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <WoQuery-request>))
  "Converts a ROS message object to a list"
  (cl:list 'WoQuery-request
    (cl:cons ':query_string (query_string msg))
    (cl:cons ':context (context msg))
    (cl:cons ':cut_prefix (cut_prefix msg))
))
;//! \htmlinclude WoQuery-response.msg.html

(cl:defclass <WoQuery-response> (roslisp-msg-protocol:ros-message)
  ((answer
    :reader answer
    :initarg :answer
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element "")))
)

(cl:defclass WoQuery-response (<WoQuery-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <WoQuery-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'WoQuery-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name skiros2_msgs-srv:<WoQuery-response> is deprecated: use skiros2_msgs-srv:WoQuery-response instead.")))

(cl:ensure-generic-function 'answer-val :lambda-list '(m))
(cl:defmethod answer-val ((m <WoQuery-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:answer-val is deprecated.  Use skiros2_msgs-srv:answer instead.")
  (answer m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <WoQuery-response>) ostream)
  "Serializes a message object of type '<WoQuery-response>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'answer))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'answer))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <WoQuery-response>) istream)
  "Deserializes a message object of type '<WoQuery-response>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'answer) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'answer)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<WoQuery-response>)))
  "Returns string type for a service object of type '<WoQuery-response>"
  "skiros2_msgs/WoQueryResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'WoQuery-response)))
  "Returns string type for a service object of type 'WoQuery-response"
  "skiros2_msgs/WoQueryResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<WoQuery-response>)))
  "Returns md5sum for a message object of type '<WoQuery-response>"
  "c279e11806ad32f0e36af84c5a02aba8")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'WoQuery-response)))
  "Returns md5sum for a message object of type 'WoQuery-response"
  "c279e11806ad32f0e36af84c5a02aba8")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<WoQuery-response>)))
  "Returns full string definition for message of type '<WoQuery-response>"
  (cl:format cl:nil "#Owl answer (with matches separated by endline)~%string[] answer~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'WoQuery-response)))
  "Returns full string definition for message of type 'WoQuery-response"
  (cl:format cl:nil "#Owl answer (with matches separated by endline)~%string[] answer~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <WoQuery-response>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'answer) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <WoQuery-response>))
  "Converts a ROS message object to a list"
  (cl:list 'WoQuery-response
    (cl:cons ':answer (answer msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'WoQuery)))
  'WoQuery-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'WoQuery)))
  'WoQuery-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'WoQuery)))
  "Returns string type for a service object of type '<WoQuery>"
  "skiros2_msgs/WoQuery")