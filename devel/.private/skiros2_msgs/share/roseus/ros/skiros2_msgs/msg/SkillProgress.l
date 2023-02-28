;; Auto-generated. Do not edit!


(when (boundp 'skiros2_msgs::SkillProgress)
  (if (not (find-package "SKIROS2_MSGS"))
    (make-package "SKIROS2_MSGS"))
  (shadow 'SkillProgress (find-package "SKIROS2_MSGS")))
(unless (find-package "SKIROS2_MSGS::SKILLPROGRESS")
  (make-package "SKIROS2_MSGS::SKILLPROGRESS"))

(in-package "ROS")
;;//! \htmlinclude SkillProgress.msg.html


(intern "*SUCCESS*" (find-package "SKIROS2_MSGS::SKILLPROGRESS"))
(shadow '*SUCCESS* (find-package "SKIROS2_MSGS::SKILLPROGRESS"))
(defconstant skiros2_msgs::SkillProgress::*SUCCESS* 1)
(intern "*FAILURE*" (find-package "SKIROS2_MSGS::SKILLPROGRESS"))
(shadow '*FAILURE* (find-package "SKIROS2_MSGS::SKILLPROGRESS"))
(defconstant skiros2_msgs::SkillProgress::*FAILURE* 2)
(intern "*RUNNING*" (find-package "SKIROS2_MSGS::SKILLPROGRESS"))
(shadow '*RUNNING* (find-package "SKIROS2_MSGS::SKILLPROGRESS"))
(defconstant skiros2_msgs::SkillProgress::*RUNNING* 3)
(intern "*IDLE*" (find-package "SKIROS2_MSGS::SKILLPROGRESS"))
(shadow '*IDLE* (find-package "SKIROS2_MSGS::SKILLPROGRESS"))
(defconstant skiros2_msgs::SkillProgress::*IDLE* 4)
(defclass skiros2_msgs::SkillProgress
  :super ros::object
  :slots (_robot _task_id _id _parent_label _parent_id _type _label _params _processor _state _progress_code _progress_period _progress_time _progress_message ))

(defmethod skiros2_msgs::SkillProgress
  (:init
   (&key
    ((:robot __robot) "")
    ((:task_id __task_id) 0)
    ((:id __id) 0)
    ((:parent_label __parent_label) "")
    ((:parent_id __parent_id) 0)
    ((:type __type) "")
    ((:label __label) "")
    ((:params __params) (let (r) (dotimes (i 0) (push (instance skiros2_msgs::Param :init) r)) r))
    ((:processor __processor) "")
    ((:state __state) 0)
    ((:progress_code __progress_code) 0)
    ((:progress_period __progress_period) 0.0)
    ((:progress_time __progress_time) 0.0)
    ((:progress_message __progress_message) "")
    )
   (send-super :init)
   (setq _robot (string __robot))
   (setq _task_id (round __task_id))
   (setq _id (round __id))
   (setq _parent_label (string __parent_label))
   (setq _parent_id (round __parent_id))
   (setq _type (string __type))
   (setq _label (string __label))
   (setq _params __params)
   (setq _processor (string __processor))
   (setq _state (round __state))
   (setq _progress_code (round __progress_code))
   (setq _progress_period (float __progress_period))
   (setq _progress_time (float __progress_time))
   (setq _progress_message (string __progress_message))
   self)
  (:robot
   (&optional __robot)
   (if __robot (setq _robot __robot)) _robot)
  (:task_id
   (&optional __task_id)
   (if __task_id (setq _task_id __task_id)) _task_id)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:parent_label
   (&optional __parent_label)
   (if __parent_label (setq _parent_label __parent_label)) _parent_label)
  (:parent_id
   (&optional __parent_id)
   (if __parent_id (setq _parent_id __parent_id)) _parent_id)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:label
   (&optional __label)
   (if __label (setq _label __label)) _label)
  (:params
   (&rest __params)
   (if (keywordp (car __params))
       (send* _params __params)
     (progn
       (if __params (setq _params (car __params)))
       _params)))
  (:processor
   (&optional __processor)
   (if __processor (setq _processor __processor)) _processor)
  (:state
   (&optional __state)
   (if __state (setq _state __state)) _state)
  (:progress_code
   (&optional __progress_code)
   (if __progress_code (setq _progress_code __progress_code)) _progress_code)
  (:progress_period
   (&optional __progress_period)
   (if __progress_period (setq _progress_period __progress_period)) _progress_period)
  (:progress_time
   (&optional __progress_time)
   (if __progress_time (setq _progress_time __progress_time)) _progress_time)
  (:progress_message
   (&optional __progress_message)
   (if __progress_message (setq _progress_message __progress_message)) _progress_message)
  (:serialization-length
   ()
   (+
    ;; string _robot
    4 (length _robot)
    ;; int16 _task_id
    2
    ;; int16 _id
    2
    ;; string _parent_label
    4 (length _parent_label)
    ;; int16 _parent_id
    2
    ;; string _type
    4 (length _type)
    ;; string _label
    4 (length _label)
    ;; skiros2_msgs/Param[] _params
    (apply #'+ (send-all _params :serialization-length)) 4
    ;; string _processor
    4 (length _processor)
    ;; int16 _state
    2
    ;; int16 _progress_code
    2
    ;; float32 _progress_period
    4
    ;; float32 _progress_time
    4
    ;; string _progress_message
    4 (length _progress_message)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _robot
       (write-long (length _robot) s) (princ _robot s)
     ;; int16 _task_id
       (write-word _task_id s)
     ;; int16 _id
       (write-word _id s)
     ;; string _parent_label
       (write-long (length _parent_label) s) (princ _parent_label s)
     ;; int16 _parent_id
       (write-word _parent_id s)
     ;; string _type
       (write-long (length _type) s) (princ _type s)
     ;; string _label
       (write-long (length _label) s) (princ _label s)
     ;; skiros2_msgs/Param[] _params
     (write-long (length _params) s)
     (dolist (elem _params)
       (send elem :serialize s)
       )
     ;; string _processor
       (write-long (length _processor) s) (princ _processor s)
     ;; int16 _state
       (write-word _state s)
     ;; int16 _progress_code
       (write-word _progress_code s)
     ;; float32 _progress_period
       (sys::poke _progress_period (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _progress_time
       (sys::poke _progress_time (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; string _progress_message
       (write-long (length _progress_message) s) (princ _progress_message s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _robot
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _robot (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; int16 _task_id
     (setq _task_id (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; int16 _id
     (setq _id (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; string _parent_label
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _parent_label (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; int16 _parent_id
     (setq _parent_id (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; string _type
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _type (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _label
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _label (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; skiros2_msgs/Param[] _params
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _params (let (r) (dotimes (i n) (push (instance skiros2_msgs::Param :init) r)) r))
     (dolist (elem- _params)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; string _processor
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _processor (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; int16 _state
     (setq _state (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; int16 _progress_code
     (setq _progress_code (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; float32 _progress_period
     (setq _progress_period (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _progress_time
     (setq _progress_time (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; string _progress_message
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _progress_message (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get skiros2_msgs::SkillProgress :md5sum-) "14c02d9b9938298cf43e256d5d334a4c")
(setf (get skiros2_msgs::SkillProgress :datatype-) "skiros2_msgs/SkillProgress")
(setf (get skiros2_msgs::SkillProgress :definition-)
      "#Possible states
int16 SUCCESS=1
int16 FAILURE=2
int16 RUNNING=3
int16 IDLE=4

string robot
int16 task_id
int16 id
string parent_label
int16 parent_id
string type
string label
Param[] params
string processor
int16 state
int16 progress_code
float32 progress_period
float32 progress_time
string progress_message

================================================================================
MSG: skiros2_msgs/Param
string param
")



(provide :skiros2_msgs/SkillProgress "14c02d9b9938298cf43e256d5d334a4c")


