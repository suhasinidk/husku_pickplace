;; Auto-generated. Do not edit!


(when (boundp 'skiros2_msgs::WmElement)
  (if (not (find-package "SKIROS2_MSGS"))
    (make-package "SKIROS2_MSGS"))
  (shadow 'WmElement (find-package "SKIROS2_MSGS")))
(unless (find-package "SKIROS2_MSGS::WMELEMENT")
  (make-package "SKIROS2_MSGS::WMELEMENT"))

(in-package "ROS")
;;//! \htmlinclude WmElement.msg.html


(defclass skiros2_msgs::WmElement
  :super ros::object
  :slots (_id _type _label _properties _relations ))

(defmethod skiros2_msgs::WmElement
  (:init
   (&key
    ((:id __id) "")
    ((:type __type) "")
    ((:label __label) "")
    ((:properties __properties) (let (r) (dotimes (i 0) (push (instance skiros2_msgs::Property :init) r)) r))
    ((:relations __relations) (let (r) (dotimes (i 0) (push (instance skiros2_msgs::Relation :init) r)) r))
    )
   (send-super :init)
   (setq _id (string __id))
   (setq _type (string __type))
   (setq _label (string __label))
   (setq _properties __properties)
   (setq _relations __relations)
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:label
   (&optional __label)
   (if __label (setq _label __label)) _label)
  (:properties
   (&rest __properties)
   (if (keywordp (car __properties))
       (send* _properties __properties)
     (progn
       (if __properties (setq _properties (car __properties)))
       _properties)))
  (:relations
   (&rest __relations)
   (if (keywordp (car __relations))
       (send* _relations __relations)
     (progn
       (if __relations (setq _relations (car __relations)))
       _relations)))
  (:serialization-length
   ()
   (+
    ;; string _id
    4 (length _id)
    ;; string _type
    4 (length _type)
    ;; string _label
    4 (length _label)
    ;; skiros2_msgs/Property[] _properties
    (apply #'+ (send-all _properties :serialization-length)) 4
    ;; skiros2_msgs/Relation[] _relations
    (apply #'+ (send-all _relations :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _id
       (write-long (length _id) s) (princ _id s)
     ;; string _type
       (write-long (length _type) s) (princ _type s)
     ;; string _label
       (write-long (length _label) s) (princ _label s)
     ;; skiros2_msgs/Property[] _properties
     (write-long (length _properties) s)
     (dolist (elem _properties)
       (send elem :serialize s)
       )
     ;; skiros2_msgs/Relation[] _relations
     (write-long (length _relations) s)
     (dolist (elem _relations)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _id
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _id (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _type
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _type (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _label
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _label (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; skiros2_msgs/Property[] _properties
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _properties (let (r) (dotimes (i n) (push (instance skiros2_msgs::Property :init) r)) r))
     (dolist (elem- _properties)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; skiros2_msgs/Relation[] _relations
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _relations (let (r) (dotimes (i n) (push (instance skiros2_msgs::Relation :init) r)) r))
     (dolist (elem- _relations)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get skiros2_msgs::WmElement :md5sum-) "0fefbd22eac0424cfa1c8871ee3990af")
(setf (get skiros2_msgs::WmElement :datatype-) "skiros2_msgs/WmElement")
(setf (get skiros2_msgs::WmElement :definition-)
      "string id
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
string objectId
")



(provide :skiros2_msgs/WmElement "0fefbd22eac0424cfa1c8871ee3990af")


