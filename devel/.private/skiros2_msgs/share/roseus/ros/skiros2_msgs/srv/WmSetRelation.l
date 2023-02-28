;; Auto-generated. Do not edit!


(when (boundp 'skiros2_msgs::WmSetRelation)
  (if (not (find-package "SKIROS2_MSGS"))
    (make-package "SKIROS2_MSGS"))
  (shadow 'WmSetRelation (find-package "SKIROS2_MSGS")))
(unless (find-package "SKIROS2_MSGS::WMSETRELATION")
  (make-package "SKIROS2_MSGS::WMSETRELATION"))
(unless (find-package "SKIROS2_MSGS::WMSETRELATIONREQUEST")
  (make-package "SKIROS2_MSGS::WMSETRELATIONREQUEST"))
(unless (find-package "SKIROS2_MSGS::WMSETRELATIONRESPONSE")
  (make-package "SKIROS2_MSGS::WMSETRELATIONRESPONSE"))

(in-package "ROS")





(defclass skiros2_msgs::WmSetRelationRequest
  :super ros::object
  :slots (_author _relation _value ))

(defmethod skiros2_msgs::WmSetRelationRequest
  (:init
   (&key
    ((:author __author) "")
    ((:relation __relation) (instance skiros2_msgs::Relation :init))
    ((:value __value) nil)
    )
   (send-super :init)
   (setq _author (string __author))
   (setq _relation __relation)
   (setq _value __value)
   self)
  (:author
   (&optional __author)
   (if __author (setq _author __author)) _author)
  (:relation
   (&rest __relation)
   (if (keywordp (car __relation))
       (send* _relation __relation)
     (progn
       (if __relation (setq _relation (car __relation)))
       _relation)))
  (:value
   (&optional __value)
   (if __value (setq _value __value)) _value)
  (:serialization-length
   ()
   (+
    ;; string _author
    4 (length _author)
    ;; skiros2_msgs/Relation _relation
    (send _relation :serialization-length)
    ;; bool _value
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _author
       (write-long (length _author) s) (princ _author s)
     ;; skiros2_msgs/Relation _relation
       (send _relation :serialize s)
     ;; bool _value
       (if _value (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _author
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _author (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; skiros2_msgs/Relation _relation
     (send _relation :deserialize buf ptr-) (incf ptr- (send _relation :serialization-length))
   ;; bool _value
     (setq _value (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass skiros2_msgs::WmSetRelationResponse
  :super ros::object
  :slots (_ok ))

(defmethod skiros2_msgs::WmSetRelationResponse
  (:init
   (&key
    ((:ok __ok) nil)
    )
   (send-super :init)
   (setq _ok __ok)
   self)
  (:ok
   (&optional __ok)
   (if __ok (setq _ok __ok)) _ok)
  (:serialization-length
   ()
   (+
    ;; bool _ok
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _ok
       (if _ok (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _ok
     (setq _ok (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass skiros2_msgs::WmSetRelation
  :super ros::object
  :slots ())

(setf (get skiros2_msgs::WmSetRelation :md5sum-) "77bf924d023af391d9b60bf1607be75e")
(setf (get skiros2_msgs::WmSetRelation :datatype-) "skiros2_msgs/WmSetRelation")
(setf (get skiros2_msgs::WmSetRelation :request) skiros2_msgs::WmSetRelationRequest)
(setf (get skiros2_msgs::WmSetRelation :response) skiros2_msgs::WmSetRelationResponse)

(defmethod skiros2_msgs::WmSetRelationRequest
  (:response () (instance skiros2_msgs::WmSetRelationResponse :init)))

(setf (get skiros2_msgs::WmSetRelationRequest :md5sum-) "77bf924d023af391d9b60bf1607be75e")
(setf (get skiros2_msgs::WmSetRelationRequest :datatype-) "skiros2_msgs/WmSetRelationRequest")
(setf (get skiros2_msgs::WmSetRelationRequest :definition-)
      "string author
Relation relation
bool value

================================================================================
MSG: skiros2_msgs/Relation
string subjectId
string predicate
---
bool ok

")

(setf (get skiros2_msgs::WmSetRelationResponse :md5sum-) "77bf924d023af391d9b60bf1607be75e")
(setf (get skiros2_msgs::WmSetRelationResponse :datatype-) "skiros2_msgs/WmSetRelationResponse")
(setf (get skiros2_msgs::WmSetRelationResponse :definition-)
      "string author
Relation relation
bool value

================================================================================
MSG: skiros2_msgs/Relation
string subjectId
string predicate
---
bool ok

")



(provide :skiros2_msgs/WmSetRelation "77bf924d023af391d9b60bf1607be75e")


