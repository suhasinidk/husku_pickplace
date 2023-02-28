;; Auto-generated. Do not edit!


(when (boundp 'skiros2_msgs::WoModify)
  (if (not (find-package "SKIROS2_MSGS"))
    (make-package "SKIROS2_MSGS"))
  (shadow 'WoModify (find-package "SKIROS2_MSGS")))
(unless (find-package "SKIROS2_MSGS::WOMODIFY")
  (make-package "SKIROS2_MSGS::WOMODIFY"))
(unless (find-package "SKIROS2_MSGS::WOMODIFYREQUEST")
  (make-package "SKIROS2_MSGS::WOMODIFYREQUEST"))
(unless (find-package "SKIROS2_MSGS::WOMODIFYRESPONSE")
  (make-package "SKIROS2_MSGS::WOMODIFYRESPONSE"))

(in-package "ROS")





(defclass skiros2_msgs::WoModifyRequest
  :super ros::object
  :slots (_author _context _statements ))

(defmethod skiros2_msgs::WoModifyRequest
  (:init
   (&key
    ((:author __author) "")
    ((:context __context) "")
    ((:statements __statements) (let (r) (dotimes (i 0) (push (instance skiros2_msgs::Statement :init) r)) r))
    )
   (send-super :init)
   (setq _author (string __author))
   (setq _context (string __context))
   (setq _statements __statements)
   self)
  (:author
   (&optional __author)
   (if __author (setq _author __author)) _author)
  (:context
   (&optional __context)
   (if __context (setq _context __context)) _context)
  (:statements
   (&rest __statements)
   (if (keywordp (car __statements))
       (send* _statements __statements)
     (progn
       (if __statements (setq _statements (car __statements)))
       _statements)))
  (:serialization-length
   ()
   (+
    ;; string _author
    4 (length _author)
    ;; string _context
    4 (length _context)
    ;; skiros2_msgs/Statement[] _statements
    (apply #'+ (send-all _statements :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _author
       (write-long (length _author) s) (princ _author s)
     ;; string _context
       (write-long (length _context) s) (princ _context s)
     ;; skiros2_msgs/Statement[] _statements
     (write-long (length _statements) s)
     (dolist (elem _statements)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _author
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _author (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _context
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _context (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; skiros2_msgs/Statement[] _statements
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _statements (let (r) (dotimes (i n) (push (instance skiros2_msgs::Statement :init) r)) r))
     (dolist (elem- _statements)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(defclass skiros2_msgs::WoModifyResponse
  :super ros::object
  :slots (_ok ))

(defmethod skiros2_msgs::WoModifyResponse
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

(defclass skiros2_msgs::WoModify
  :super ros::object
  :slots ())

(setf (get skiros2_msgs::WoModify :md5sum-) "dd76bb6e56a5980cc554cb4a6047bd97")
(setf (get skiros2_msgs::WoModify :datatype-) "skiros2_msgs/WoModify")
(setf (get skiros2_msgs::WoModify :request) skiros2_msgs::WoModifyRequest)
(setf (get skiros2_msgs::WoModify :response) skiros2_msgs::WoModifyResponse)

(defmethod skiros2_msgs::WoModifyRequest
  (:response () (instance skiros2_msgs::WoModifyResponse :init)))

(setf (get skiros2_msgs::WoModifyRequest :md5sum-) "dd76bb6e56a5980cc554cb4a6047bd97")
(setf (get skiros2_msgs::WoModifyRequest :datatype-) "skiros2_msgs/WoModifyRequest")
(setf (get skiros2_msgs::WoModifyRequest :definition-)
      "string author
string context
Statement[] statements

================================================================================
MSG: skiros2_msgs/Statement
Relation relation
bool value

================================================================================
MSG: skiros2_msgs/Relation
string subjectId
string predicate
---
bool ok

")

(setf (get skiros2_msgs::WoModifyResponse :md5sum-) "dd76bb6e56a5980cc554cb4a6047bd97")
(setf (get skiros2_msgs::WoModifyResponse :datatype-) "skiros2_msgs/WoModifyResponse")
(setf (get skiros2_msgs::WoModifyResponse :definition-)
      "string author
string context
Statement[] statements

================================================================================
MSG: skiros2_msgs/Statement
Relation relation
bool value

================================================================================
MSG: skiros2_msgs/Relation
string subjectId
string predicate
---
bool ok

")



(provide :skiros2_msgs/WoModify "dd76bb6e56a5980cc554cb4a6047bd97")


