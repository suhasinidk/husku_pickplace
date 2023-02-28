;; Auto-generated. Do not edit!


(when (boundp 'skiros2_msgs::Relation)
  (if (not (find-package "SKIROS2_MSGS"))
    (make-package "SKIROS2_MSGS"))
  (shadow 'Relation (find-package "SKIROS2_MSGS")))
(unless (find-package "SKIROS2_MSGS::RELATION")
  (make-package "SKIROS2_MSGS::RELATION"))

(in-package "ROS")
;;//! \htmlinclude Relation.msg.html


(defclass skiros2_msgs::Relation
  :super ros::object
  :slots (_subjectId _predicate _objectId ))

(defmethod skiros2_msgs::Relation
  (:init
   (&key
    ((:subjectId __subjectId) "")
    ((:predicate __predicate) "")
    ((:objectId __objectId) "")
    )
   (send-super :init)
   (setq _subjectId (string __subjectId))
   (setq _predicate (string __predicate))
   (setq _objectId (string __objectId))
   self)
  (:subjectId
   (&optional __subjectId)
   (if __subjectId (setq _subjectId __subjectId)) _subjectId)
  (:predicate
   (&optional __predicate)
   (if __predicate (setq _predicate __predicate)) _predicate)
  (:objectId
   (&optional __objectId)
   (if __objectId (setq _objectId __objectId)) _objectId)
  (:serialization-length
   ()
   (+
    ;; string _subjectId
    4 (length _subjectId)
    ;; string _predicate
    4 (length _predicate)
    ;; string _objectId
    4 (length _objectId)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _subjectId
       (write-long (length _subjectId) s) (princ _subjectId s)
     ;; string _predicate
       (write-long (length _predicate) s) (princ _predicate s)
     ;; string _objectId
       (write-long (length _objectId) s) (princ _objectId s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _subjectId
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _subjectId (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _predicate
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _predicate (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _objectId
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _objectId (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get skiros2_msgs::Relation :md5sum-) "6596e75cd61663ae5bcc18bf41e43915")
(setf (get skiros2_msgs::Relation :datatype-) "skiros2_msgs/Relation")
(setf (get skiros2_msgs::Relation :definition-)
      "string subjectId
string predicate
string objectId
")



(provide :skiros2_msgs/Relation "6596e75cd61663ae5bcc18bf41e43915")


