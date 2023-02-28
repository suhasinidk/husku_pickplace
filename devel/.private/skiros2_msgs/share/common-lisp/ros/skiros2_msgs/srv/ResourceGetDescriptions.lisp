; Auto-generated. Do not edit!


(cl:in-package skiros2_msgs-srv)


;//! \htmlinclude ResourceGetDescriptions-request.msg.html

(cl:defclass <ResourceGetDescriptions-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass ResourceGetDescriptions-request (<ResourceGetDescriptions-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ResourceGetDescriptions-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ResourceGetDescriptions-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name skiros2_msgs-srv:<ResourceGetDescriptions-request> is deprecated: use skiros2_msgs-srv:ResourceGetDescriptions-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ResourceGetDescriptions-request>) ostream)
  "Serializes a message object of type '<ResourceGetDescriptions-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ResourceGetDescriptions-request>) istream)
  "Deserializes a message object of type '<ResourceGetDescriptions-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ResourceGetDescriptions-request>)))
  "Returns string type for a service object of type '<ResourceGetDescriptions-request>"
  "skiros2_msgs/ResourceGetDescriptionsRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ResourceGetDescriptions-request)))
  "Returns string type for a service object of type 'ResourceGetDescriptions-request"
  "skiros2_msgs/ResourceGetDescriptionsRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ResourceGetDescriptions-request>)))
  "Returns md5sum for a message object of type '<ResourceGetDescriptions-request>"
  "689dba5a19baf7321e2b246602dfca10")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ResourceGetDescriptions-request)))
  "Returns md5sum for a message object of type 'ResourceGetDescriptions-request"
  "689dba5a19baf7321e2b246602dfca10")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ResourceGetDescriptions-request>)))
  "Returns full string definition for message of type '<ResourceGetDescriptions-request>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ResourceGetDescriptions-request)))
  "Returns full string definition for message of type 'ResourceGetDescriptions-request"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ResourceGetDescriptions-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ResourceGetDescriptions-request>))
  "Converts a ROS message object to a list"
  (cl:list 'ResourceGetDescriptions-request
))
;//! \htmlinclude ResourceGetDescriptions-response.msg.html

(cl:defclass <ResourceGetDescriptions-response> (roslisp-msg-protocol:ros-message)
  ((list
    :reader list
    :initarg :list
    :type (cl:vector skiros2_msgs-msg:ResourceDescription)
   :initform (cl:make-array 0 :element-type 'skiros2_msgs-msg:ResourceDescription :initial-element (cl:make-instance 'skiros2_msgs-msg:ResourceDescription))))
)

(cl:defclass ResourceGetDescriptions-response (<ResourceGetDescriptions-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ResourceGetDescriptions-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ResourceGetDescriptions-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name skiros2_msgs-srv:<ResourceGetDescriptions-response> is deprecated: use skiros2_msgs-srv:ResourceGetDescriptions-response instead.")))

(cl:ensure-generic-function 'list-val :lambda-list '(m))
(cl:defmethod list-val ((m <ResourceGetDescriptions-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-srv:list-val is deprecated.  Use skiros2_msgs-srv:list instead.")
  (list m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ResourceGetDescriptions-response>) ostream)
  "Serializes a message object of type '<ResourceGetDescriptions-response>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'list))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'list))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ResourceGetDescriptions-response>) istream)
  "Deserializes a message object of type '<ResourceGetDescriptions-response>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'list) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'list)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'skiros2_msgs-msg:ResourceDescription))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ResourceGetDescriptions-response>)))
  "Returns string type for a service object of type '<ResourceGetDescriptions-response>"
  "skiros2_msgs/ResourceGetDescriptionsResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ResourceGetDescriptions-response)))
  "Returns string type for a service object of type 'ResourceGetDescriptions-response"
  "skiros2_msgs/ResourceGetDescriptionsResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ResourceGetDescriptions-response>)))
  "Returns md5sum for a message object of type '<ResourceGetDescriptions-response>"
  "689dba5a19baf7321e2b246602dfca10")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ResourceGetDescriptions-response)))
  "Returns md5sum for a message object of type 'ResourceGetDescriptions-response"
  "689dba5a19baf7321e2b246602dfca10")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ResourceGetDescriptions-response>)))
  "Returns full string definition for message of type '<ResourceGetDescriptions-response>"
  (cl:format cl:nil "ResourceDescription[] list~%~%~%~%~%~%================================================================================~%MSG: skiros2_msgs/ResourceDescription~%string type~%string name~%Param[] params~%~%================================================================================~%MSG: skiros2_msgs/Param~%string param~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ResourceGetDescriptions-response)))
  "Returns full string definition for message of type 'ResourceGetDescriptions-response"
  (cl:format cl:nil "ResourceDescription[] list~%~%~%~%~%~%================================================================================~%MSG: skiros2_msgs/ResourceDescription~%string type~%string name~%Param[] params~%~%================================================================================~%MSG: skiros2_msgs/Param~%string param~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ResourceGetDescriptions-response>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'list) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ResourceGetDescriptions-response>))
  "Converts a ROS message object to a list"
  (cl:list 'ResourceGetDescriptions-response
    (cl:cons ':list (list msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'ResourceGetDescriptions)))
  'ResourceGetDescriptions-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'ResourceGetDescriptions)))
  'ResourceGetDescriptions-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ResourceGetDescriptions)))
  "Returns string type for a service object of type '<ResourceGetDescriptions>"
  "skiros2_msgs/ResourceGetDescriptions")