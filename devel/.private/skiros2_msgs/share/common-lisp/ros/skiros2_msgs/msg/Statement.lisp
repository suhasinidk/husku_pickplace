; Auto-generated. Do not edit!


(cl:in-package skiros2_msgs-msg)


;//! \htmlinclude Statement.msg.html

(cl:defclass <Statement> (roslisp-msg-protocol:ros-message)
  ((relation
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

(cl:defclass Statement (<Statement>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Statement>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Statement)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name skiros2_msgs-msg:<Statement> is deprecated: use skiros2_msgs-msg:Statement instead.")))

(cl:ensure-generic-function 'relation-val :lambda-list '(m))
(cl:defmethod relation-val ((m <Statement>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-msg:relation-val is deprecated.  Use skiros2_msgs-msg:relation instead.")
  (relation m))

(cl:ensure-generic-function 'value-val :lambda-list '(m))
(cl:defmethod value-val ((m <Statement>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-msg:value-val is deprecated.  Use skiros2_msgs-msg:value instead.")
  (value m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Statement>) ostream)
  "Serializes a message object of type '<Statement>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'relation) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'value) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Statement>) istream)
  "Deserializes a message object of type '<Statement>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'relation) istream)
    (cl:setf (cl:slot-value msg 'value) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Statement>)))
  "Returns string type for a message object of type '<Statement>"
  "skiros2_msgs/Statement")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Statement)))
  "Returns string type for a message object of type 'Statement"
  "skiros2_msgs/Statement")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Statement>)))
  "Returns md5sum for a message object of type '<Statement>"
  "052db037d902fbb67131a3c41b93b371")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Statement)))
  "Returns md5sum for a message object of type 'Statement"
  "052db037d902fbb67131a3c41b93b371")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Statement>)))
  "Returns full string definition for message of type '<Statement>"
  (cl:format cl:nil "Relation relation~%bool value~%~%================================================================================~%MSG: skiros2_msgs/Relation~%string subjectId~%string predicate~%string objectId~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Statement)))
  "Returns full string definition for message of type 'Statement"
  (cl:format cl:nil "Relation relation~%bool value~%~%================================================================================~%MSG: skiros2_msgs/Relation~%string subjectId~%string predicate~%string objectId~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Statement>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'relation))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Statement>))
  "Converts a ROS message object to a list"
  (cl:list 'Statement
    (cl:cons ':relation (relation msg))
    (cl:cons ':value (value msg))
))
