; Auto-generated. Do not edit!


(cl:in-package skiros2_msgs-srv)


;//! \htmlinclude SkillCommand-request.msg.html

(cl:defclass <SkillCommand-request> (roslisp-msg-protocol:ros-message)
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
   (execution_id
    :reader execution_id
    :initarg :execution_id
    :type cl:fixnum
    :initform 0)
   (skills
    :reader skills
    :initarg :skills
    :type (cl:vector skiros2_msgs-msg:ResourceDescription)
   :initform (cl:make-array 0 :element-type 'skiros2_msgs-msg:ResourceDescription :initial-element (cl:make-instance 'skiros2_msgs-msg:ResourceDescription))))
)

(cl:defclass SkillCommand-request (<SkillCommand-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SkillCommand-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SkillCommand-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name skiros2_msgs-srv:<SkillCommand-request> is deprecated: use skiros2_msgs-srv:SkillCommand-request instead.")))

(cl:ensure-generic-function 'author-val :lambda-list '(m))
(cl:defmethod author-val ((m <SkillCommand-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:author-val is deprecated.  Use skiros2_msgs-srv:author instead.")
  (author m))

(cl:ensure-generic-function 'action-val :lambda-list '(m))
(cl:defmethod action-val ((m <SkillCommand-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:action-val is deprecated.  Use skiros2_msgs-srv:action instead.")
  (action m))

(cl:ensure-generic-function 'execution_id-val :lambda-list '(m))
(cl:defmethod execution_id-val ((m <SkillCommand-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:execution_id-val is deprecated.  Use skiros2_msgs-srv:execution_id instead.")
  (execution_id m))

(cl:ensure-generic-function 'skills-val :lambda-list '(m))
(cl:defmethod skills-val ((m <SkillCommand-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:skills-val is deprecated.  Use skiros2_msgs-srv:skills instead.")
  (skills m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<SkillCommand-request>)))
    "Constants for message type '<SkillCommand-request>"
  '((:START . start)
    (:PAUSE . pause)
    (:PREEMPT . preempt)
    (:TICK_ONCE . tick_once))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'SkillCommand-request)))
    "Constants for message type 'SkillCommand-request"
  '((:START . start)
    (:PAUSE . pause)
    (:PREEMPT . preempt)
    (:TICK_ONCE . tick_once))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SkillCommand-request>) ostream)
  "Serializes a message object of type '<SkillCommand-request>"
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
  (cl:let* ((signed (cl:slot-value msg 'execution_id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'skills))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'skills))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SkillCommand-request>) istream)
  "Deserializes a message object of type '<SkillCommand-request>"
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
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'execution_id) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'skills) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'skills)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'skiros2_msgs-msg:ResourceDescription))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SkillCommand-request>)))
  "Returns string type for a service object of type '<SkillCommand-request>"
  "skiros2_msgs/SkillCommandRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SkillCommand-request)))
  "Returns string type for a service object of type 'SkillCommand-request"
  "skiros2_msgs/SkillCommandRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SkillCommand-request>)))
  "Returns md5sum for a message object of type '<SkillCommand-request>"
  "1150e5b3a081e2e52deee5d82d9efb98")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SkillCommand-request)))
  "Returns md5sum for a message object of type 'SkillCommand-request"
  "1150e5b3a081e2e52deee5d82d9efb98")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SkillCommand-request>)))
  "Returns full string definition for message of type '<SkillCommand-request>"
  (cl:format cl:nil "#Possible actions~%string START=start~%string PAUSE=pause~%string PREEMPT=preempt~%string TICK_ONCE=tick_once~%~%string author 			            #Author of the action~%string action				            #Action to perform~%int16 execution_id~%ResourceDescription[] skills~%~%================================================================================~%MSG: skiros2_msgs/ResourceDescription~%string type~%string name~%Param[] params~%~%================================================================================~%MSG: skiros2_msgs/Param~%string param~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SkillCommand-request)))
  "Returns full string definition for message of type 'SkillCommand-request"
  (cl:format cl:nil "#Possible actions~%string START=start~%string PAUSE=pause~%string PREEMPT=preempt~%string TICK_ONCE=tick_once~%~%string author 			            #Author of the action~%string action				            #Action to perform~%int16 execution_id~%ResourceDescription[] skills~%~%================================================================================~%MSG: skiros2_msgs/ResourceDescription~%string type~%string name~%Param[] params~%~%================================================================================~%MSG: skiros2_msgs/Param~%string param~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SkillCommand-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'author))
     4 (cl:length (cl:slot-value msg 'action))
     2
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'skills) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SkillCommand-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SkillCommand-request
    (cl:cons ':author (author msg))
    (cl:cons ':action (action msg))
    (cl:cons ':execution_id (execution_id msg))
    (cl:cons ':skills (skills msg))
))
;//! \htmlinclude SkillCommand-response.msg.html

(cl:defclass <SkillCommand-response> (roslisp-msg-protocol:ros-message)
  ((ok
    :reader ok
    :initarg :ok
    :type cl:boolean
    :initform cl:nil)
   (execution_id
    :reader execution_id
    :initarg :execution_id
    :type cl:fixnum
    :initform 0))
)

(cl:defclass SkillCommand-response (<SkillCommand-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SkillCommand-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SkillCommand-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name skiros2_msgs-srv:<SkillCommand-response> is deprecated: use skiros2_msgs-srv:SkillCommand-response instead.")))

(cl:ensure-generic-function 'ok-val :lambda-list '(m))
(cl:defmethod ok-val ((m <SkillCommand-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:ok-val is deprecated.  Use skiros2_msgs-srv:ok instead.")
  (ok m))

(cl:ensure-generic-function 'execution_id-val :lambda-list '(m))
(cl:defmethod execution_id-val ((m <SkillCommand-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:execution_id-val is deprecated.  Use skiros2_msgs-srv:execution_id instead.")
  (execution_id m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SkillCommand-response>) ostream)
  "Serializes a message object of type '<SkillCommand-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'ok) 1 0)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'execution_id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SkillCommand-response>) istream)
  "Deserializes a message object of type '<SkillCommand-response>"
    (cl:setf (cl:slot-value msg 'ok) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'execution_id) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SkillCommand-response>)))
  "Returns string type for a service object of type '<SkillCommand-response>"
  "skiros2_msgs/SkillCommandResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SkillCommand-response)))
  "Returns string type for a service object of type 'SkillCommand-response"
  "skiros2_msgs/SkillCommandResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SkillCommand-response>)))
  "Returns md5sum for a message object of type '<SkillCommand-response>"
  "1150e5b3a081e2e52deee5d82d9efb98")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SkillCommand-response)))
  "Returns md5sum for a message object of type 'SkillCommand-response"
  "1150e5b3a081e2e52deee5d82d9efb98")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SkillCommand-response>)))
  "Returns full string definition for message of type '<SkillCommand-response>"
  (cl:format cl:nil "bool ok~%int16 execution_id~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SkillCommand-response)))
  "Returns full string definition for message of type 'SkillCommand-response"
  (cl:format cl:nil "bool ok~%int16 execution_id~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SkillCommand-response>))
  (cl:+ 0
     1
     2
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SkillCommand-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SkillCommand-response
    (cl:cons ':ok (ok msg))
    (cl:cons ':execution_id (execution_id msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SkillCommand)))
  'SkillCommand-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SkillCommand)))
  'SkillCommand-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SkillCommand)))
  "Returns string type for a service object of type '<SkillCommand>"
  "skiros2_msgs/SkillCommand")