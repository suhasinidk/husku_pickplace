;; Auto-generated. Do not edit!


(when (boundp 'skiros2_msgs::WmQueryRelations)
  (if (not (find-package "SKIROS2_MSGS"))
    (make-package "SKIROS2_MSGS"))
  (shadow 'WmQueryRelations (find-package "SKIROS2_MSGS")))
(unless (find-package "SKIROS2_MSGS::WMQUERYRELATIONS")
  (make-package "SKIROS2_MSGS::WMQUERYRELATIONS"))
(unless (find-package "SKIROS2_MSGS::WMQUERYRELATIONSREQUEST")
  (make-package "SKIROS2_MSGS::WMQUERYRELATIONSREQUEST"))
(unless (find-package "SKIROS2_MSGS::WMQUERYRELATIONSRESPONSE")
  (make-package "SKIROS2_MSGS::WMQUERYRELATIONSRESPONSE"))

(in-package "ROS")





(defclass skiros2_msgs::WmQueryRelationsRequest
  :super ros::object
  :slots (_relation ))

(defmethod skiros2_msgs::WmQueryRelationsRequest
  (:init
   (&key
    ((:relation __relation) (instance skiros2_msgs::Relation :init))
    )
   (send-super :init)
   (setq _relation __relation)
   self)
  (:relation
   (&rest __relation)
   (if (keywordp (car __relation))
       (send* _relation __relation)
     (progn
       (if __relation (setq _relation (car __relation)))
       _relation)))
  (:serialization-length
   ()
   (+
    ;; skiros2_msgs/Relation _relation
    (send _relation :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; skiros2_msgs/Relation _relation
       (send _relation :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; skiros2_msgs/Relation _relation
     (send _relation :deserialize buf ptr-) (incf ptr- (send _relation :serialization-length))
   ;;
   self)
  )

(defclass skiros2_msgs::WmQueryRelationsResponse
  :super ros::object
  :slots (_matches ))

(defmethod skiros2_msgs::WmQueryRelationsResponse
  (:init
   (&key
    ((:matches __matches) (let (r) (dotimes (i 0) (push (instance skiros2_msgs::Relation :init) r)) r))
    )
   (send-super :init)
   (setq _matches __matches)
   self)
  (:matches
   (&rest __matches)
   (if (keywordp (car __matches))
       (send* _matches __matches)
     (progn
       (if __matches (setq _matches (car __matches)))
       _matches)))
  (:serialization-length
   ()
   (+
    ;; skiros2_msgs/Relation[] _matches
    (apply #'+ (send-all _matches :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; skiros2_msgs/Relation[] _matches
     (write-long (length _matches) s)
     (dolist (elem _matches)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; skiros2_msgs/Relation[] _matches
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _matches (let (r) (dotimes (i n) (push (instance skiros2_msgs::Relation :init) r)) r))
     (dolist (elem- _matches)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(defclass skiros2_msgs::WmQueryRelations
  :super ros::object
  :slots ())

(setf (get skiros2_msgs::WmQueryRelations :md5sum-) "5c95783a21284fc96a095a71049fa510")
(setf (get skiros2_msgs::WmQueryRelations :datatype-) "skiros2_msgs/WmQueryRelations")
(setf (get skiros2_msgs::WmQueryRelations :request) skiros2_msgs::WmQueryRelationsRequest)
(setf (get skiros2_msgs::WmQueryRelations :response) skiros2_msgs::WmQueryRelationsResponse)

(defmethod skiros2_msgs::WmQueryRelationsRequest
  (:response () (instance skiros2_msgs::WmQueryRelationsResponse :init)))

(setf (get skiros2_msgs::WmQueryRelationsRequest :md5sum-) "5c95783a21284fc96a095a71049fa510")
(setf (get skiros2_msgs::WmQueryRelationsRequest :datatype-) "skiros2_msgs/WmQueryRelationsRequest")
(setf (get skiros2_msgs::WmQueryRelationsRequest :definition-)
      "Relation relation

================================================================================
MSG: skiros2_msgs/Relation
string subjectId
string predicate
---
Relation[] matches


================================================================================
MSG: skiros2_msgs/Relation
string subjectId
string predicate
")

(setf (get skiros2_msgs::WmQueryRelationsResponse :md5sum-) "5c95783a21284fc96a095a71049fa510")
(setf (get skiros2_msgs::WmQueryRelationsResponse :datatype-) "skiros2_msgs/WmQueryRelationsResponse")
(setf (get skiros2_msgs::WmQueryRelationsResponse :definition-)
      "Relation relation

================================================================================
MSG: skiros2_msgs/Relation
string subjectId
string predicate
---
Relation[] matches


================================================================================
MSG: skiros2_msgs/Relation
string subjectId
string predicate
")



(provide :skiros2_msgs/WmQueryRelations "5c95783a21284fc96a095a71049fa510")


