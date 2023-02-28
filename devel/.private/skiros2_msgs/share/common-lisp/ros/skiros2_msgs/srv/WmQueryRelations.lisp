; Auto-generated. Do not edit!


(cl:in-package skiros2_msgs-srv)


;//! \htmlinclude WmQueryRelations-request.msg.html

(cl:defclass <WmQueryRelations-request> (roslisp-msg-protocol:ros-message)
  ((relation
    :reader relation
    :initarg :relation
    :type skiros2_msgs-msg:Relation
    :initform (cl:make-instance 'skiros2_msgs-msg:Relation)))
)

(cl:defclass WmQueryRelations-request (<WmQueryRelations-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <WmQueryRelations-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'WmQueryRelations-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name skiros2_msgs-srv:<WmQueryRelations-request> is deprecated: use skiros2_msgs-srv:WmQueryRelations-request instead.")))

(cl:ensure-generic-function 'relation-val :lambda-list '(m))
(cl:defmethod relation-val ((m <WmQueryRelations-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:relation-val is deprecated.  Use skiros2_msgs-srv:relation instead.")
  (relation m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <WmQueryRelations-request>) ostream)
  "Serializes a message object of type '<WmQueryRelations-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'relation) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <WmQueryRelations-request>) istream)
  "Deserializes a message object of type '<WmQueryRelations-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'relation) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<WmQueryRelations-request>)))
  "Returns string type for a service object of type '<WmQueryRelations-request>"
  "skiros2_msgs/WmQueryRelationsRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'WmQueryRelations-request)))
  "Returns string type for a service object of type 'WmQueryRelations-request"
  "skiros2_msgs/WmQueryRelationsRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<WmQueryRelations-request>)))
  "Returns md5sum for a message object of type '<WmQueryRelations-request>"
  "5c95783a21284fc96a095a71049fa510")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'WmQueryRelations-request)))
  "Returns md5sum for a message object of type 'WmQueryRelations-request"
  "5c95783a21284fc96a095a71049fa510")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<WmQueryRelations-request>)))
  "Returns full string definition for message of type '<WmQueryRelations-request>"
  (cl:format cl:nil "Relation relation~%~%================================================================================~%MSG: skiros2_msgs/Relation~%string subjectId~%string predicate~%string objectId~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'WmQueryRelations-request)))
  "Returns full string definition for message of type 'WmQueryRelations-request"
  (cl:format cl:nil "Relation relation~%~%================================================================================~%MSG: skiros2_msgs/Relation~%string subjectId~%string predicate~%string objectId~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <WmQueryRelations-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'relation))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <WmQueryRelations-request>))
  "Converts a ROS message object to a list"
  (cl:list 'WmQueryRelations-request
    (cl:cons ':relation (relation msg))
))
;//! \htmlinclude WmQueryRelations-response.msg.html

(cl:defclass <WmQueryRelations-response> (roslisp-msg-protocol:ros-message)
  ((matches
    :reader matches
    :initarg :matches
    :type (cl:vector skiros2_msgs-msg:Relation)
   :initform (cl:make-array 0 :element-type 'skiros2_msgs-msg:Relation :initial-element (cl:make-instance 'skiros2_msgs-msg:Relation))))
)

(cl:defclass WmQueryRelations-response (<WmQueryRelations-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <WmQueryRelations-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'WmQueryRelations-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name skiros2_msgs-srv:<WmQueryRelations-response> is deprecated: use skiros2_msgs-srv:WmQueryRelations-response instead.")))

(cl:ensure-generic-function 'matches-val :lambda-list '(m))
(cl:defmethod matches-val ((m <WmQueryRelations-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:matches-val is deprecated.  Use skiros2_msgs-srv:matches instead.")
  (matches m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <WmQueryRelations-response>) ostream)
  "Serializes a message object of type '<WmQueryRelations-response>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'matches))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'matches))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <WmQueryRelations-response>) istream)
  "Deserializes a message object of type '<WmQueryRelations-response>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'matches) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'matches)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'skiros2_msgs-msg:Relation))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<WmQueryRelations-response>)))
  "Returns string type for a service object of type '<WmQueryRelations-response>"
  "skiros2_msgs/WmQueryRelationsResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'WmQueryRelations-response)))
  "Returns string type for a service object of type 'WmQueryRelations-response"
  "skiros2_msgs/WmQueryRelationsResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<WmQueryRelations-response>)))
  "Returns md5sum for a message object of type '<WmQueryRelations-response>"
  "5c95783a21284fc96a095a71049fa510")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'WmQueryRelations-response)))
  "Returns md5sum for a message object of type 'WmQueryRelations-response"
  "5c95783a21284fc96a095a71049fa510")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<WmQueryRelations-response>)))
  "Returns full string definition for message of type '<WmQueryRelations-response>"
  (cl:format cl:nil "Relation[] matches~%~%~%================================================================================~%MSG: skiros2_msgs/Relation~%string subjectId~%string predicate~%string objectId~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'WmQueryRelations-response)))
  "Returns full string definition for message of type 'WmQueryRelations-response"
  (cl:format cl:nil "Relation[] matches~%~%~%================================================================================~%MSG: skiros2_msgs/Relation~%string subjectId~%string predicate~%string objectId~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <WmQueryRelations-response>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'matches) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <WmQueryRelations-response>))
  "Converts a ROS message object to a list"
  (cl:list 'WmQueryRelations-response
    (cl:cons ':matches (matches msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'WmQueryRelations)))
  'WmQueryRelations-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'WmQueryRelations)))
  'WmQueryRelations-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'WmQueryRelations)))
  "Returns string type for a service object of type '<WmQueryRelations>"
  "skiros2_msgs/WmQueryRelations")