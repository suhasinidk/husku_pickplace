;; Auto-generated. Do not edit!


(when (boundp 'skiros2_msgs::WmModify)
  (if (not (find-package "SKIROS2_MSGS"))
    (make-package "SKIROS2_MSGS"))
  (shadow 'WmModify (find-package "SKIROS2_MSGS")))
(unless (find-package "SKIROS2_MSGS::WMMODIFY")
  (make-package "SKIROS2_MSGS::WMMODIFY"))
(unless (find-package "SKIROS2_MSGS::WMMODIFYREQUEST")
  (make-package "SKIROS2_MSGS::WMMODIFYREQUEST"))
(unless (find-package "SKIROS2_MSGS::WMMODIFYRESPONSE")
  (make-package "SKIROS2_MSGS::WMMODIFYRESPONSE"))

(in-package "ROS")





(intern "*ADD*" (find-package "SKIROS2_MSGS::WMMODIFYREQUEST"))
(shadow '*ADD* (find-package "SKIROS2_MSGS::WMMODIFYREQUEST"))
(defconstant skiros2_msgs::WmModifyRequest::*ADD* "add")
(intern "*UPDATE*" (find-package "SKIROS2_MSGS::WMMODIFYREQUEST"))
(shadow '*UPDATE* (find-package "SKIROS2_MSGS::WMMODIFYREQUEST"))
(defconstant skiros2_msgs::WmModifyRequest::*UPDATE* "update")
(intern "*UPDATE_PROPERTIES*" (find-package "SKIROS2_MSGS::WMMODIFYREQUEST"))
(shadow '*UPDATE_PROPERTIES* (find-package "SKIROS2_MSGS::WMMODIFYREQUEST"))
(defconstant skiros2_msgs::WmModifyRequest::*UPDATE_PROPERTIES* "update_properties")
(intern "*REMOVE*" (find-package "SKIROS2_MSGS::WMMODIFYREQUEST"))
(shadow '*REMOVE* (find-package "SKIROS2_MSGS::WMMODIFYREQUEST"))
(defconstant skiros2_msgs::WmModifyRequest::*REMOVE* "remove")
(intern "*REMOVE_RECURSIVE*" (find-package "SKIROS2_MSGS::WMMODIFYREQUEST"))
(shadow '*REMOVE_RECURSIVE* (find-package "SKIROS2_MSGS::WMMODIFYREQUEST"))
(defconstant skiros2_msgs::WmModifyRequest::*REMOVE_RECURSIVE* "remove_recursive")
(defclass skiros2_msgs::WmModifyRequest
  :super ros::object
  :slots (_author _action _relation_filter _type_filter _context _elements ))

(defmethod skiros2_msgs::WmModifyRequest
  (:init
   (&key
    ((:author __author) "")
    ((:action __action) "")
    ((:relation_filter __relation_filter) "")
    ((:type_filter __type_filter) "")
    ((:context __context) "")
    ((:elements __elements) (let (r) (dotimes (i 0) (push (instance skiros2_msgs::WmElement :init) r)) r))
    )
   (send-super :init)
   (setq _author (string __author))
   (setq _action (string __action))
   (setq _relation_filter (string __relation_filter))
   (setq _type_filter (string __type_filter))
   (setq _context (string __context))
   (setq _elements __elements)
   self)
  (:author
   (&optional __author)
   (if __author (setq _author __author)) _author)
  (:action
   (&optional __action)
   (if __action (setq _action __action)) _action)
  (:relation_filter
   (&optional __relation_filter)
   (if __relation_filter (setq _relation_filter __relation_filter)) _relation_filter)
  (:type_filter
   (&optional __type_filter)
   (if __type_filter (setq _type_filter __type_filter)) _type_filter)
  (:context
   (&optional __context)
   (if __context (setq _context __context)) _context)
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
    ;; string _author
    4 (length _author)
    ;; string _action
    4 (length _action)
    ;; string _relation_filter
    4 (length _relation_filter)
    ;; string _type_filter
    4 (length _type_filter)
    ;; string _context
    4 (length _context)
    ;; skiros2_msgs/WmElement[] _elements
    (apply #'+ (send-all _elements :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _author
       (write-long (length _author) s) (princ _author s)
     ;; string _action
       (write-long (length _action) s) (princ _action s)
     ;; string _relation_filter
       (write-long (length _relation_filter) s) (princ _relation_filter s)
     ;; string _type_filter
       (write-long (length _type_filter) s) (princ _type_filter s)
     ;; string _context
       (write-long (length _context) s) (princ _context s)
     ;; skiros2_msgs/WmElement[] _elements
     (write-long (length _elements) s)
     (dolist (elem _elements)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _author
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _author (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _action
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _action (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _relation_filter
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _relation_filter (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _type_filter
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _type_filter (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _context
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _context (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
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

(defclass skiros2_msgs::WmModifyResponse
  :super ros::object
  :slots (_elements ))

(defmethod skiros2_msgs::WmModifyResponse
  (:init
   (&key
    ((:elements __elements) (let (r) (dotimes (i 0) (push (instance skiros2_msgs::WmElement :init) r)) r))
    )
   (send-super :init)
   (setq _elements __elements)
   self)
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
    ;; skiros2_msgs/WmElement[] _elements
    (apply #'+ (send-all _elements :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; skiros2_msgs/WmElement[] _elements
     (write-long (length _elements) s)
     (dolist (elem _elements)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
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

(defclass skiros2_msgs::WmModify
  :super ros::object
  :slots ())

(setf (get skiros2_msgs::WmModify :md5sum-) "3777804bb09a7d142574f0ae4bc21501")
(setf (get skiros2_msgs::WmModify :datatype-) "skiros2_msgs/WmModify")
(setf (get skiros2_msgs::WmModify :request) skiros2_msgs::WmModifyRequest)
(setf (get skiros2_msgs::WmModify :response) skiros2_msgs::WmModifyResponse)

(defmethod skiros2_msgs::WmModifyRequest
  (:response () (instance skiros2_msgs::WmModifyResponse :init)))

(setf (get skiros2_msgs::WmModifyRequest :md5sum-) "3777804bb09a7d142574f0ae4bc21501")
(setf (get skiros2_msgs::WmModifyRequest :datatype-) "skiros2_msgs/WmModifyRequest")
(setf (get skiros2_msgs::WmModifyRequest :definition-)
      "#Possible actions
string ADD=add
string UPDATE=update
string UPDATE_PROPERTIES=update_properties
string REMOVE=remove
string REMOVE_RECURSIVE=remove_recursive

string author
string action
string relation_filter
string type_filter
string context
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
---
#ADD/UPDATE/UPDATE_PROPERTIES: return updated elements REMOVE/REMOVE_RECURSIVE: return nothing
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

(setf (get skiros2_msgs::WmModifyResponse :md5sum-) "3777804bb09a7d142574f0ae4bc21501")
(setf (get skiros2_msgs::WmModifyResponse :datatype-) "skiros2_msgs/WmModifyResponse")
(setf (get skiros2_msgs::WmModifyResponse :definition-)
      "#Possible actions
string ADD=add
string UPDATE=update
string UPDATE_PROPERTIES=update_properties
string REMOVE=remove
string REMOVE_RECURSIVE=remove_recursive

string author
string action
string relation_filter
string type_filter
string context
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
---
#ADD/UPDATE/UPDATE_PROPERTIES: return updated elements REMOVE/REMOVE_RECURSIVE: return nothing
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



(provide :skiros2_msgs/WmModify "3777804bb09a7d142574f0ae4bc21501")


