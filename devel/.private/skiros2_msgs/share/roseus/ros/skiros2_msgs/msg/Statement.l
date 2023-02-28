;; Auto-generated. Do not edit!


(when (boundp 'skiros2_msgs::Statement)
  (if (not (find-package "SKIROS2_MSGS"))
    (make-package "SKIROS2_MSGS"))
  (shadow 'Statement (find-package "SKIROS2_MSGS")))
(unless (find-package "SKIROS2_MSGS::STATEMENT")
  (make-package "SKIROS2_MSGS::STATEMENT"))

(in-package "ROS")
;;//! \htmlinclude Statement.msg.html


(defclass skiros2_msgs::Statement
  :super ros::object
  :slots (_relation _value ))

(defmethod skiros2_msgs::Statement
  (:init
   (&key
    ((:relation __relation) (instance skiros2_msgs::Relation :init))
    ((:value __value) nil)
    )
   (send-super :init)
   (setq _relation __relation)
   (setq _value __value)
   self)
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
    ;; skiros2_msgs/Relation _relation
    (send _relation :serialization-length)
    ;; bool _value
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; skiros2_msgs/Relation _relation
       (send _relation :serialize s)
     ;; bool _value
       (if _value (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; skiros2_msgs/Relation _relation
     (send _relation :deserialize buf ptr-) (incf ptr- (send _relation :serialization-length))
   ;; bool _value
     (setq _value (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get skiros2_msgs::Statement :md5sum-) "052db037d902fbb67131a3c41b93b371")
(setf (get skiros2_msgs::Statement :datatype-) "skiros2_msgs/Statement")
(setf (get skiros2_msgs::Statement :definition-)
      "Relation relation
bool value

================================================================================
MSG: skiros2_msgs/Relation
string subjectId
string predicate
string objectId
")



(provide :skiros2_msgs/Statement "052db037d902fbb67131a3c41b93b371")


