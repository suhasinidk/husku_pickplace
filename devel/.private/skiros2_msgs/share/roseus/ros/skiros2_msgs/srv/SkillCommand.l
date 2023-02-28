;; Auto-generated. Do not edit!


(when (boundp 'skiros2_msgs::SkillCommand)
  (if (not (find-package "SKIROS2_MSGS"))
    (make-package "SKIROS2_MSGS"))
  (shadow 'SkillCommand (find-package "SKIROS2_MSGS")))
(unless (find-package "SKIROS2_MSGS::SKILLCOMMAND")
  (make-package "SKIROS2_MSGS::SKILLCOMMAND"))
(unless (find-package "SKIROS2_MSGS::SKILLCOMMANDREQUEST")
  (make-package "SKIROS2_MSGS::SKILLCOMMANDREQUEST"))
(unless (find-package "SKIROS2_MSGS::SKILLCOMMANDRESPONSE")
  (make-package "SKIROS2_MSGS::SKILLCOMMANDRESPONSE"))

(in-package "ROS")





(intern "*START*" (find-package "SKIROS2_MSGS::SKILLCOMMANDREQUEST"))
(shadow '*START* (find-package "SKIROS2_MSGS::SKILLCOMMANDREQUEST"))
(defconstant skiros2_msgs::SkillCommandRequest::*START* "start")
(intern "*PAUSE*" (find-package "SKIROS2_MSGS::SKILLCOMMANDREQUEST"))
(shadow '*PAUSE* (find-package "SKIROS2_MSGS::SKILLCOMMANDREQUEST"))
(defconstant skiros2_msgs::SkillCommandRequest::*PAUSE* "pause")
(intern "*PREEMPT*" (find-package "SKIROS2_MSGS::SKILLCOMMANDREQUEST"))
(shadow '*PREEMPT* (find-package "SKIROS2_MSGS::SKILLCOMMANDREQUEST"))
(defconstant skiros2_msgs::SkillCommandRequest::*PREEMPT* "preempt")
(intern "*TICK_ONCE*" (find-package "SKIROS2_MSGS::SKILLCOMMANDREQUEST"))
(shadow '*TICK_ONCE* (find-package "SKIROS2_MSGS::SKILLCOMMANDREQUEST"))
(defconstant skiros2_msgs::SkillCommandRequest::*TICK_ONCE* "tick_once")
(defclass skiros2_msgs::SkillCommandRequest
  :super ros::object
  :slots (_author _action _execution_id _skills ))

(defmethod skiros2_msgs::SkillCommandRequest
  (:init
   (&key
    ((:author __author) "")
    ((:action __action) "")
    ((:execution_id __execution_id) 0)
    ((:skills __skills) (let (r) (dotimes (i 0) (push (instance skiros2_msgs::ResourceDescription :init) r)) r))
    )
   (send-super :init)
   (setq _author (string __author))
   (setq _action (string __action))
   (setq _execution_id (round __execution_id))
   (setq _skills __skills)
   self)
  (:author
   (&optional __author)
   (if __author (setq _author __author)) _author)
  (:action
   (&optional __action)
   (if __action (setq _action __action)) _action)
  (:execution_id
   (&optional __execution_id)
   (if __execution_id (setq _execution_id __execution_id)) _execution_id)
  (:skills
   (&rest __skills)
   (if (keywordp (car __skills))
       (send* _skills __skills)
     (progn
       (if __skills (setq _skills (car __skills)))
       _skills)))
  (:serialization-length
   ()
   (+
    ;; string _author
    4 (length _author)
    ;; string _action
    4 (length _action)
    ;; int16 _execution_id
    2
    ;; skiros2_msgs/ResourceDescription[] _skills
    (apply #'+ (send-all _skills :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _author
       (write-long (length _author) s) (princ _author s)
     ;; string _action
       (write-long (length _action) s) (princ _action s)
     ;; int16 _execution_id
       (write-word _execution_id s)
     ;; skiros2_msgs/ResourceDescription[] _skills
     (write-long (length _skills) s)
     (dolist (elem _skills)
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
   ;; int16 _execution_id
     (setq _execution_id (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; skiros2_msgs/ResourceDescription[] _skills
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _skills (let (r) (dotimes (i n) (push (instance skiros2_msgs::ResourceDescription :init) r)) r))
     (dolist (elem- _skills)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(defclass skiros2_msgs::SkillCommandResponse
  :super ros::object
  :slots (_ok _execution_id ))

(defmethod skiros2_msgs::SkillCommandResponse
  (:init
   (&key
    ((:ok __ok) nil)
    ((:execution_id __execution_id) 0)
    )
   (send-super :init)
   (setq _ok __ok)
   (setq _execution_id (round __execution_id))
   self)
  (:ok
   (&optional __ok)
   (if __ok (setq _ok __ok)) _ok)
  (:execution_id
   (&optional __execution_id)
   (if __execution_id (setq _execution_id __execution_id)) _execution_id)
  (:serialization-length
   ()
   (+
    ;; bool _ok
    1
    ;; int16 _execution_id
    2
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _ok
       (if _ok (write-byte -1 s) (write-byte 0 s))
     ;; int16 _execution_id
       (write-word _execution_id s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _ok
     (setq _ok (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int16 _execution_id
     (setq _execution_id (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;;
   self)
  )

(defclass skiros2_msgs::SkillCommand
  :super ros::object
  :slots ())

(setf (get skiros2_msgs::SkillCommand :md5sum-) "1150e5b3a081e2e52deee5d82d9efb98")
(setf (get skiros2_msgs::SkillCommand :datatype-) "skiros2_msgs/SkillCommand")
(setf (get skiros2_msgs::SkillCommand :request) skiros2_msgs::SkillCommandRequest)
(setf (get skiros2_msgs::SkillCommand :response) skiros2_msgs::SkillCommandResponse)

(defmethod skiros2_msgs::SkillCommandRequest
  (:response () (instance skiros2_msgs::SkillCommandResponse :init)))

(setf (get skiros2_msgs::SkillCommandRequest :md5sum-) "1150e5b3a081e2e52deee5d82d9efb98")
(setf (get skiros2_msgs::SkillCommandRequest :datatype-) "skiros2_msgs/SkillCommandRequest")
(setf (get skiros2_msgs::SkillCommandRequest :definition-)
      "#Possible actions
string START=start
string PAUSE=pause
string PREEMPT=preempt
string TICK_ONCE=tick_once

string author 			            #Author of the action
string action				            #Action to perform
int16 execution_id
ResourceDescription[] skills

================================================================================
MSG: skiros2_msgs/ResourceDescription
string type
string name
Param[] params

================================================================================
MSG: skiros2_msgs/Param
---
bool ok
int16 execution_id

")

(setf (get skiros2_msgs::SkillCommandResponse :md5sum-) "1150e5b3a081e2e52deee5d82d9efb98")
(setf (get skiros2_msgs::SkillCommandResponse :datatype-) "skiros2_msgs/SkillCommandResponse")
(setf (get skiros2_msgs::SkillCommandResponse :definition-)
      "#Possible actions
string START=start
string PAUSE=pause
string PREEMPT=preempt
string TICK_ONCE=tick_once

string author 			            #Author of the action
string action				            #Action to perform
int16 execution_id
ResourceDescription[] skills

================================================================================
MSG: skiros2_msgs/ResourceDescription
string type
string name
Param[] params

================================================================================
MSG: skiros2_msgs/Param
---
bool ok
int16 execution_id

")



(provide :skiros2_msgs/SkillCommand "1150e5b3a081e2e52deee5d82d9efb98")


