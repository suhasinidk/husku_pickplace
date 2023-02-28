; Auto-generated. Do not edit!


(cl:in-package skiros2_msgs-msg)


;//! \htmlinclude WmMonitor.msg.html

(cl:defclass <WmMonitor> (roslisp-msg-protocol:ros-message)
  ((prev_snapshot_id
    :reader prev_snapshot_id
    :initarg :prev_snapshot_id
    :type cl:string
    :initform "")
   (snapshot_id
    :reader snapshot_id
    :initarg :snapshot_id
    :type cl:string
    :initform "")
   (stamp
    :reader stamp
    :initarg :stamp
    :type cl:real
    :initform 0)
   (author
    :reader author
    :initarg :author
    :type cl:string
    :initform "")
   (action
    :reader action
    :initarg :action
    :type cl:string
    :initform "")
   (elements
    :reader elements
    :initarg :elements
    :type (cl:vector skiros2_msgs-msg:WmElement)
   :initform (cl:make-array 0 :element-type 'skiros2_msgs-msg:WmElement :initial-element (cl:make-instance 'skiros2_msgs-msg:WmElement)))
   (relation
    :reader relation
    :initarg :relation
    :type (cl:vector skiros2_msgs-msg:Relation)
   :initform (cl:make-array 0 :element-type 'skiros2_msgs-msg:Relation :initial-element (cl:make-instance 'skiros2_msgs-msg:Relation))))
)

(cl:defclass WmMonitor (<WmMonitor>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <WmMonitor>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'WmMonitor)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name skiros2_msgs-msg:<WmMonitor> is deprecated: use skiros2_msgs-msg:WmMonitor instead.")))

(cl:ensure-generic-function 'prev_snapshot_id-val :lambda-list '(m))
(cl:defmethod prev_snapshot_id-val ((m <WmMonitor>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-msg:prev_snapshot_id-val is deprecated.  Use skiros2_msgs-msg:prev_snapshot_id instead.")
  (prev_snapshot_id m))

(cl:ensure-generic-function 'snapshot_id-val :lambda-list '(m))
(cl:defmethod snapshot_id-val ((m <WmMonitor>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-msg:snapshot_id-val is deprecated.  Use skiros2_msgs-msg:snapshot_id instead.")
  (snapshot_id m))

(cl:ensure-generic-function 'stamp-val :lambda-list '(m))
(cl:defmethod stamp-val ((m <WmMonitor>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-msg:stamp-val is deprecated.  Use skiros2_msgs-msg:stamp instead.")
  (stamp m))

(cl:ensure-generic-function 'author-val :lambda-list '(m))
(cl:defmethod author-val ((m <WmMonitor>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-msg:author-val is deprecated.  Use skiros2_msgs-msg:author instead.")
  (author m))

(cl:ensure-generic-function 'action-val :lambda-list '(m))
(cl:defmethod action-val ((m <WmMonitor>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-msg:action-val is deprecated.  Use skiros2_msgs-msg:action instead.")
  (action m))

(cl:ensure-generic-function 'elements-val :lambda-list '(m))
(cl:defmethod elements-val ((m <WmMonitor>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-msg:elements-val is deprecated.  Use skiros2_msgs-msg:elements instead.")
  (elements m))

(cl:ensure-generic-function 'relation-val :lambda-list '(m))
(cl:defmethod relation-val ((m <WmMonitor>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader skiros2_msgs-msg:relation-val is deprecated.  Use skiros2_msgs-msg:relation instead.")
  (relation m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<WmMonitor>)))
    "Constants for message type '<WmMonitor>"
  '((:ADD . add)
    (:UPDATE . update)
    (:REMOVE . remove)
    (:RESET . reset))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'WmMonitor)))
    "Constants for message type 'WmMonitor"
  '((:ADD . add)
    (:UPDATE . update)
    (:REMOVE . remove)
    (:RESET . reset))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <WmMonitor>) ostream)
  "Serializes a message object of type '<WmMonitor>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'prev_snapshot_id))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'prev_snapshot_id))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'snapshot_id))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'snapshot_id))
  (cl:let ((__sec (cl:floor (cl:slot-value msg 'stamp)))
        (__nsec (cl:round (cl:* 1e9 (cl:- (cl:slot-value msg 'stamp) (cl:floor (cl:slot-value msg 'stamp)))))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 0) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __nsec) ostream))
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
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'elements))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'elements))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'relation))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'relation))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <WmMonitor>) istream)
  "Deserializes a message object of type '<WmMonitor>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'prev_snapshot_id) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'prev_snapshot_id) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'snapshot_id) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'snapshot_id) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__sec 0) (__nsec 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 0) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __nsec) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'stamp) (cl:+ (cl:coerce __sec 'cl:double-float) (cl:/ __nsec 1e9))))
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
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'relation) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'relation)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'skiros2_msgs-msg:Relation))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<WmMonitor>)))
  "Returns string type for a message object of type '<WmMonitor>"
  "skiros2_msgs/WmMonitor")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'WmMonitor)))
  "Returns string type for a message object of type 'WmMonitor"
  "skiros2_msgs/WmMonitor")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<WmMonitor>)))
  "Returns md5sum for a message object of type '<WmMonitor>"
  "ecc40ec88cb57baaf7cf8c07fd40a3c7")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'WmMonitor)))
  "Returns md5sum for a message object of type 'WmMonitor"
  "ecc40ec88cb57baaf7cf8c07fd40a3c7")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<WmMonitor>)))
  "Returns full string definition for message of type '<WmMonitor>"
  (cl:format cl:nil "#Possible actions~%string ADD=add~%string UPDATE=update~%string REMOVE=remove~%string RESET=reset~%~%#Metadata~%string prev_snapshot_id~%string snapshot_id~%time stamp~%#Change~%string author~%string action~%WmElement[] elements~%Relation[] relation~%~%================================================================================~%MSG: skiros2_msgs/WmElement~%string id~%string type~%string label~%Property[] properties~%Relation[] relations~%~%================================================================================~%MSG: skiros2_msgs/Property~%string key~%string dataValue~%string dataType~%~%================================================================================~%MSG: skiros2_msgs/Relation~%string subjectId~%string predicate~%string objectId~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'WmMonitor)))
  "Returns full string definition for message of type 'WmMonitor"
  (cl:format cl:nil "#Possible actions~%string ADD=add~%string UPDATE=update~%string REMOVE=remove~%string RESET=reset~%~%#Metadata~%string prev_snapshot_id~%string snapshot_id~%time stamp~%#Change~%string author~%string action~%WmElement[] elements~%Relation[] relation~%~%================================================================================~%MSG: skiros2_msgs/WmElement~%string id~%string type~%string label~%Property[] properties~%Relation[] relations~%~%================================================================================~%MSG: skiros2_msgs/Property~%string key~%string dataValue~%string dataType~%~%================================================================================~%MSG: skiros2_msgs/Relation~%string subjectId~%string predicate~%string objectId~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <WmMonitor>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'prev_snapshot_id))
     4 (cl:length (cl:slot-value msg 'snapshot_id))
     8
     4 (cl:length (cl:slot-value msg 'author))
     4 (cl:length (cl:slot-value msg 'action))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'elements) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'relation) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <WmMonitor>))
  "Converts a ROS message object to a list"
  (cl:list 'WmMonitor
    (cl:cons ':prev_snapshot_id (prev_snapshot_id msg))
    (cl:cons ':snapshot_id (snapshot_id msg))
    (cl:cons ':stamp (stamp msg))
    (cl:cons ':author (author msg))
    (cl:cons ':action (action msg))
    (cl:cons ':elements (elements msg))
    (cl:cons ':relation (relation msg))
))
