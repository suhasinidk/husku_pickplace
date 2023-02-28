;; Auto-generated. Do not edit!


(when (boundp 'skiros2_msgs::WmGet)
  (if (not (find-package "SKIROS2_MSGS"))
    (make-package "SKIROS2_MSGS"))
  (shadow 'WmGet (find-package "SKIROS2_MSGS")))
(unless (find-package "SKIROS2_MSGS::WMGET")
  (make-package "SKIROS2_MSGS::WMGET"))
(unless (find-package "SKIROS2_MSGS::WMGETREQUEST")
  (make-package "SKIROS2_MSGS::WMGETREQUEST"))
(unless (find-package "SKIROS2_MSGS::WMGETRESPONSE")
  (make-package "SKIROS2_MSGS::WMGETRESPONSE"))

(in-package "ROS")





(intern "*GET*" (find-package "SKIROS2_MSGS::WMGETREQUEST"))
(shadow '*GET* (find-package "SKIROS2_MSGS::WMGETREQUEST"))
(defconstant skiros2_msgs::WmGetRequest::*GET* "get")
(intern "*GET_TEMPLATE*" (find-package "SKIROS2_MSGS::WMGETREQUEST"))
(shadow '*GET_TEMPLATE* (find-package "SKIROS2_MSGS::WMGETREQUEST"))
(defconstant skiros2_msgs::WmGetRequest::*GET_TEMPLATE* "get_template")
(intern "*RESOLVE*" (find-package "SKIROS2_MSGS::WMGETREQUEST"))
(shadow '*RESOLVE* (find-package "SKIROS2_MSGS::WMGETREQUEST"))
(defconstant skiros2_msgs::WmGetRequest::*RESOLVE* "resolve")
(intern "*GET_RECURSIVE*" (find-package "SKIROS2_MSGS::WMGETREQUEST"))
(shadow '*GET_RECURSIVE* (find-package "SKIROS2_MSGS::WMGETREQUEST"))
(defconstant skiros2_msgs::WmGetRequest::*GET_RECURSIVE* "get_recursive")
(defclass skiros2_msgs::WmGetRequest
  :super ros::object
  :slots (_action _context _element _relation_filter _type_filter ))

(defmethod skiros2_msgs::WmGetRequest
  (:init
   (&key
    ((:action __action) "")
    ((:context __context) "")
    ((:element __element) (instance skiros2_msgs::WmElement :init))
    ((:relation_filter __relation_filter) "")
    ((:type_filter __type_filter) "")
    )
   (send-super :init)
   (setq _action (string __action))
   (setq _context (string __context))
   (setq _element __element)
   (setq _relation_filter (string __relation_filter))
   (setq _type_filter (string __type_filter))
   self)
  (:action
   (&optional __action)
   (if __action (setq _action __action)) _action)
  (:context
   (&optional __context)
   (if __context (setq _context __context)) _context)
  (:element
   (&rest __element)
   (if (keywordp (car __element))
       (send* _element __element)
     (progn
       (if __element (setq _element (car __element)))
       _element)))
  (:relation_filter
   (&optional __relation_filter)
   (if __relation_filter (setq _relation_filter __relation_filter)) _relation_filter)
  (:type_filter
   (&optional __type_filter)
   (if __type_filter (setq _type_filter __type_filter)) _type_filter)
  (:serialization-length
   ()
   (+
    ;; string _action
    4 (length _action)
    ;; string _context
    4 (length _context)
    ;; skiros2_msgs/WmElement _element
    (send _element :serialization-length)
    ;; string _relation_filter
    4 (length _relation_filter)
    ;; string _type_filter
    4 (length _type_filter)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _action
       (write-long (length _action) s) (princ _action s)
     ;; string _context
       (write-long (length _context) s) (princ _context s)
     ;; skiros2_msgs/WmElement _element
       (send _element :serialize s)
     ;; string _relation_filter
       (write-long (length _relation_filter) s) (princ _relation_filter s)
     ;; string _type_filter
       (write-long (length _type_filter) s) (princ _type_filter s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _action
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _action (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _context
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _context (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; skiros2_msgs/WmElement _element
     (send _element :deserialize buf ptr-) (incf ptr- (send _element :serialization-length))
   ;; string _relation_filter
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _relation_filter (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _type_filter
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _type_filter (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass skiros2_msgs::WmGetResponse
  :super ros::object
  :slots (_snapshot_id _elements ))

(defmethod skiros2_msgs::WmGetResponse
  (:init
   (&key
    ((:snapshot_id __snapshot_id) "")
    ((:elements __elements) (let (r) (dotimes (i 0) (push (instance skiros2_msgs::WmElement :init) r)) r))
    )
   (send-super :init)
   (setq _snapshot_id (string __snapshot_id))
   (setq _elements __elements)
   self)
  (:snapshot_id
   (&optional __snapshot_id)
   (if __snapshot_id (setq _snapshot_id __snapshot_id)) _snapshot_id)
  (:elements
   (&rest __elements)
   (if (keywordp (car __elements))
       (send* _elements __elements)
     (progn
       (if __elements (setq _elements (car __elements)))
       _elements)))
  (:serialization-length
   ()
   (+
    ;; string _snapshot_id
    4 (length _snapshot_id)
    ;; skiros2_msgs/WmElement[] _elements
    (apply #'+ (send-all _elements :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _snapshot_id
       (write-long (length _snapshot_id) s) (princ _snapshot_id s)
     ;; skiros2_msgs/WmElement[] _elements
     (write-long (length _elements) s)
     (dolist (elem _elements)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _snapshot_id
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _snapshot_id (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; skiros2_msgs/WmElement[] _elements
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _elements (let (r) (dotimes (i n) (push (instance skiros2_msgs::WmElement :init) r)) r))
     (dolist (elem- _elements)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(defclass skiros2_msgs::WmGet
  :super ros::object
  :slots ())

(setf (get skiros2_msgs::WmGet :md5sum-) "a03c7fe28a0cdf8073d54434e678721d")
(setf (get skiros2_msgs::WmGet :datatype-) "skiros2_msgs/WmGet")
(setf (get skiros2_msgs::WmGet :request) skiros2_msgs::WmGetRequest)
(setf (get skiros2_msgs::WmGet :response) skiros2_msgs::WmGetResponse)

(defmethod skiros2_msgs::WmGetRequest
  (:response () (instance skiros2_msgs::WmGetResponse :init)))

(setf (get skiros2_msgs::WmGetRequest :md5sum-) "a03c7fe28a0cdf8073d54434e678721d")
(setf (get skiros2_msgs::WmGetRequest :datatype-) "skiros2_msgs/WmGetRequest")
(setf (get skiros2_msgs::WmGetRequest :definition-)
      "#Possible actions
string GET=get
string GET_TEMPLATE=get_template
string RESOLVE=resolve
string GET_RECURSIVE=get_recursive

string action
string context
WmElement element
string relation_filter
string type_filter

================================================================================
MSG: skiros2_msgs/WmElement
string id
string type
string label
Property[] properties
Relation[] relations

================================================================================
MSG: skiros2_msgs/Property
string key
string dataValue
string dataType

================================================================================
MSG: skiros2_msgs/Relation
string subjectId
string predicate
---
string snapshot_id
WmElement[] elements


================================================================================
MSG: skiros2_msgs/WmElement
string id
string type
string label
Property[] properties
Relation[] relations

================================================================================
MSG: skiros2_msgs/Property
string key
string dataValue
string dataType

================================================================================
MSG: skiros2_msgs/Relation
string subjectId
string predicate
")

(setf (get skiros2_msgs::WmGetResponse :md5sum-) "a03c7fe28a0cdf8073d54434e678721d")
(setf (get skiros2_msgs::WmGetResponse :datatype-) "skiros2_msgs/WmGetResponse")
(setf (get skiros2_msgs::WmGetResponse :definition-)
      "#Possible actions
string GET=get
string GET_TEMPLATE=get_template
string RESOLVE=resolve
string GET_RECURSIVE=get_recursive

string action
string context
WmElement element
string relation_filter
string type_filter

================================================================================
MSG: skiros2_msgs/WmElement
string id
string type
string label
Property[] properties
Relation[] relations

================================================================================
MSG: skiros2_msgs/Property
string key
string dataValue
string dataType

================================================================================
MSG: skiros2_msgs/Relation
string subjectId
string predicate
---
string snapshot_id
WmElement[] elements


================================================================================
MSG: skiros2_msgs/WmElement
string id
string type
string label
Property[] properties
Relation[] relations

================================================================================
MSG: skiros2_msgs/Property
string key
string dataValue
string dataType

================================================================================
MSG: skiros2_msgs/Relation
string subjectId
string predicate
")



(provide :skiros2_msgs/WmGet "a03c7fe28a0cdf8073d54434e678721d")


