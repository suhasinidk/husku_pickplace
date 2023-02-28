;; Auto-generated. Do not edit!


(when (boundp 'skiros2_msgs::WoLoadAndSave)
  (if (not (find-package "SKIROS2_MSGS"))
    (make-package "SKIROS2_MSGS"))
  (shadow 'WoLoadAndSave (find-package "SKIROS2_MSGS")))
(unless (find-package "SKIROS2_MSGS::WOLOADANDSAVE")
  (make-package "SKIROS2_MSGS::WOLOADANDSAVE"))
(unless (find-package "SKIROS2_MSGS::WOLOADANDSAVEREQUEST")
  (make-package "SKIROS2_MSGS::WOLOADANDSAVEREQUEST"))
(unless (find-package "SKIROS2_MSGS::WOLOADANDSAVERESPONSE")
  (make-package "SKIROS2_MSGS::WOLOADANDSAVERESPONSE"))

(in-package "ROS")





(intern "*LOAD*" (find-package "SKIROS2_MSGS::WOLOADANDSAVEREQUEST"))
(shadow '*LOAD* (find-package "SKIROS2_MSGS::WOLOADANDSAVEREQUEST"))
(defconstant skiros2_msgs::WoLoadAndSaveRequest::*LOAD* "load")
(intern "*SAVE*" (find-package "SKIROS2_MSGS::WOLOADANDSAVEREQUEST"))
(shadow '*SAVE* (find-package "SKIROS2_MSGS::WOLOADANDSAVEREQUEST"))
(defconstant skiros2_msgs::WoLoadAndSaveRequest::*SAVE* "save")
(defclass skiros2_msgs::WoLoadAndSaveRequest
  :super ros::object
  :slots (_action _filename _context ))

(defmethod skiros2_msgs::WoLoadAndSaveRequest
  (:init
   (&key
    ((:action __action) "")
    ((:filename __filename) "")
    ((:context __context) "")
    )
   (send-super :init)
   (setq _action (string __action))
   (setq _filename (string __filename))
   (setq _context (string __context))
   self)
  (:action
   (&optional __action)
   (if __action (setq _action __action)) _action)
  (:filename
   (&optional __filename)
   (if __filename (setq _filename __filename)) _filename)
  (:context
   (&optional __context)
   (if __context (setq _context __context)) _context)
  (:serialization-length
   ()
   (+
    ;; string _action
    4 (length _action)
    ;; string _filename
    4 (length _filename)
    ;; string _context
    4 (length _context)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _action
       (write-long (length _action) s) (princ _action s)
     ;; string _filename
       (write-long (length _filename) s) (princ _filename s)
     ;; string _context
       (write-long (length _context) s) (princ _context s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _action
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _action (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _filename
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _filename (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _context
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _context (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass skiros2_msgs::WoLoadAndSaveResponse
  :super ros::object
  :slots (_ok ))

(defmethod skiros2_msgs::WoLoadAndSaveResponse
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

(defclass skiros2_msgs::WoLoadAndSave
  :super ros::object
  :slots ())

(setf (get skiros2_msgs::WoLoadAndSave :md5sum-) "c662905d73fbee6703c2eda4c56b6502")
(setf (get skiros2_msgs::WoLoadAndSave :datatype-) "skiros2_msgs/WoLoadAndSave")
(setf (get skiros2_msgs::WoLoadAndSave :request) skiros2_msgs::WoLoadAndSaveRequest)
(setf (get skiros2_msgs::WoLoadAndSave :response) skiros2_msgs::WoLoadAndSaveResponse)

(defmethod skiros2_msgs::WoLoadAndSaveRequest
  (:response () (instance skiros2_msgs::WoLoadAndSaveResponse :init)))

(setf (get skiros2_msgs::WoLoadAndSaveRequest :md5sum-) "c662905d73fbee6703c2eda4c56b6502")
(setf (get skiros2_msgs::WoLoadAndSaveRequest :datatype-) "skiros2_msgs/WoLoadAndSaveRequest")
(setf (get skiros2_msgs::WoLoadAndSaveRequest :definition-)
      "#Possible actions
string LOAD=load
string SAVE=save

string action
string filename
string context
---
bool ok
")

(setf (get skiros2_msgs::WoLoadAndSaveResponse :md5sum-) "c662905d73fbee6703c2eda4c56b6502")
(setf (get skiros2_msgs::WoLoadAndSaveResponse :datatype-) "skiros2_msgs/WoLoadAndSaveResponse")
(setf (get skiros2_msgs::WoLoadAndSaveResponse :definition-)
      "#Possible actions
string LOAD=load
string SAVE=save

string action
string filename
string context
---
bool ok
")



(provide :skiros2_msgs/WoLoadAndSave "c662905d73fbee6703c2eda4c56b6502")


