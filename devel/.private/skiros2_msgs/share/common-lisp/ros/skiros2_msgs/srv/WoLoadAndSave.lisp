; Auto-generated. Do not edit!


(cl:in-package skiros2_msgs-srv)


;//! \htmlinclude WoLoadAndSave-request.msg.html

(cl:defclass <WoLoadAndSave-request> (roslisp-msg-protocol:ros-message)
  ((action
    :reader action
    :initarg :action
    :type cl:string
    :initform "")
   (filename
    :reader filename
    :initarg :filename
    :type cl:string
    :initform "")
   (context
    :reader context
    :initarg :context
    :type cl:string
    :initform ""))
)

(cl:defclass WoLoadAndSave-request (<WoLoadAndSave-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <WoLoadAndSave-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'WoLoadAndSave-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name skiros2_msgs-srv:<WoLoadAndSave-request> is deprecated: use skiros2_msgs-srv:WoLoadAndSave-request instead.")))

(cl:ensure-generic-function 'action-val :lambda-list '(m))
(cl:defmethod action-val ((m <WoLoadAndSave-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:action-val is deprecated.  Use skiros2_msgs-srv:action instead.")
  (action m))

(cl:ensure-generic-function 'filename-val :lambda-list '(m))
(cl:defmethod filename-val ((m <WoLoadAndSave-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:filename-val is deprecated.  Use skiros2_msgs-srv:filename instead.")
  (filename m))

(cl:ensure-generic-function 'context-val :lambda-list '(m))
(cl:defmethod context-val ((m <WoLoadAndSave-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:context-val is deprecated.  Use skiros2_msgs-srv:context instead.")
  (context m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<WoLoadAndSave-request>)))
    "Constants for message type '<WoLoadAndSave-request>"
  '((:LOAD . load)
    (:SAVE . save))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'WoLoadAndSave-request)))
    "Constants for message type 'WoLoadAndSave-request"
  '((:LOAD . load)
    (:SAVE . save))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <WoLoadAndSave-request>) ostream)
  "Serializes a message object of type '<WoLoadAndSave-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'action))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'action))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'filename))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'filename))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'context))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'context))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <WoLoadAndSave-request>) istream)
  "Deserializes a message object of type '<WoLoadAndSave-request>"
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
      (cl:setf (cl:slot-value msg 'filename) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'filename) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'context) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'context) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<WoLoadAndSave-request>)))
  "Returns string type for a service object of type '<WoLoadAndSave-request>"
  "skiros2_msgs/WoLoadAndSaveRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'WoLoadAndSave-request)))
  "Returns string type for a service object of type 'WoLoadAndSave-request"
  "skiros2_msgs/WoLoadAndSaveRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<WoLoadAndSave-request>)))
  "Returns md5sum for a message object of type '<WoLoadAndSave-request>"
  "c662905d73fbee6703c2eda4c56b6502")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'WoLoadAndSave-request)))
  "Returns md5sum for a message object of type 'WoLoadAndSave-request"
  "c662905d73fbee6703c2eda4c56b6502")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<WoLoadAndSave-request>)))
  "Returns full string definition for message of type '<WoLoadAndSave-request>"
  (cl:format cl:nil "#Possible actions~%string LOAD=load~%string SAVE=save~%~%string action~%string filename~%string context~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'WoLoadAndSave-request)))
  "Returns full string definition for message of type 'WoLoadAndSave-request"
  (cl:format cl:nil "#Possible actions~%string LOAD=load~%string SAVE=save~%~%string action~%string filename~%string context~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <WoLoadAndSave-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'action))
     4 (cl:length (cl:slot-value msg 'filename))
     4 (cl:length (cl:slot-value msg 'context))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <WoLoadAndSave-request>))
  "Converts a ROS message object to a list"
  (cl:list 'WoLoadAndSave-request
    (cl:cons ':action (action msg))
    (cl:cons ':filename (filename msg))
    (cl:cons ':context (context msg))
))
;//! \htmlinclude WoLoadAndSave-response.msg.html

(cl:defclass <WoLoadAndSave-response> (roslisp-msg-protocol:ros-message)
  ((ok
    :reader ok
    :initarg :ok
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass WoLoadAndSave-response (<WoLoadAndSave-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <WoLoadAndSave-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'WoLoadAndSave-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name skiros2_msgs-srv:<WoLoadAndSave-response> is deprecated: use skiros2_msgs-srv:WoLoadAndSave-response instead.")))

(cl:ensure-generic-function 'ok-val :lambda-list '(m))
(cl:defmethod ok-val ((m <WoLoadAndSave-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:ok-val is deprecated.  Use skiros2_msgs-srv:ok instead.")
  (ok m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <WoLoadAndSave-response>) ostream)
  "Serializes a message object of type '<WoLoadAndSave-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'ok) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <WoLoadAndSave-response>) istream)
  "Deserializes a message object of type '<WoLoadAndSave-response>"
    (cl:setf (cl:slot-value msg 'ok) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<WoLoadAndSave-response>)))
  "Returns string type for a service object of type '<WoLoadAndSave-response>"
  "skiros2_msgs/WoLoadAndSaveResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'WoLoadAndSave-response)))
  "Returns string type for a service object of type 'WoLoadAndSave-response"
  "skiros2_msgs/WoLoadAndSaveResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<WoLoadAndSave-response>)))
  "Returns md5sum for a message object of type '<WoLoadAndSave-response>"
  "c662905d73fbee6703c2eda4c56b6502")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'WoLoadAndSave-response)))
  "Returns md5sum for a message object of type 'WoLoadAndSave-response"
  "c662905d73fbee6703c2eda4c56b6502")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<WoLoadAndSave-response>)))
  "Returns full string definition for message of type '<WoLoadAndSave-response>"
  (cl:format cl:nil "bool ok~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'WoLoadAndSave-response)))
  "Returns full string definition for message of type 'WoLoadAndSave-response"
  (cl:format cl:nil "bool ok~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <WoLoadAndSave-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <WoLoadAndSave-response>))
  "Converts a ROS message object to a list"
  (cl:list 'WoLoadAndSave-response
    (cl:cons ':ok (ok msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'WoLoadAndSave)))
  'WoLoadAndSave-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'WoLoadAndSave)))
  'WoLoadAndSave-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'WoLoadAndSave)))
  "Returns string type for a service object of type '<WoLoadAndSave>"
  "skiros2_msgs/WoLoadAndSave")