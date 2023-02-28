;; Auto-generated. Do not edit!


(when (boundp 'skiros2_msgs::WmMonitor)
  (if (not (find-package "SKIROS2_MSGS"))
    (make-package "SKIROS2_MSGS"))
  (shadow 'WmMonitor (find-package "SKIROS2_MSGS")))
(unless (find-package "SKIROS2_MSGS::WMMONITOR")
  (make-package "SKIROS2_MSGS::WMMONITOR"))

(in-package "ROS")
;;//! \htmlinclude WmMonitor.msg.html


(intern "*ADD*" (find-package "SKIROS2_MSGS::WMMONITOR"))
(shadow '*ADD* (find-package "SKIROS2_MSGS::WMMONITOR"))
(defconstant skiros2_msgs::WmMonitor::*ADD* "add")
(intern "*UPDATE*" (find-package "SKIROS2_MSGS::WMMONITOR"))
(shadow '*UPDATE* (find-package "SKIROS2_MSGS::WMMONITOR"))
(defconstant skiros2_msgs::WmMonitor::*UPDATE* "update")
(intern "*REMOVE*" (find-package "SKIROS2_MSGS::WMMONITOR"))
(shadow '*REMOVE* (find-package "SKIROS2_MSGS::WMMONITOR"))
(defconstant skiros2_msgs::WmMonitor::*REMOVE* "remove")
(intern "*RESET*" (find-package "SKIROS2_MSGS::WMMONITOR"))
(shadow '*RESET* (find-package "SKIROS2_MSGS::WMMONITOR"))
(defconstant skiros2_msgs::WmMonitor::*RESET* "reset")
(defclass skiros2_msgs::WmMonitor
  :super ros::object
  :slots (_prev_snapshot_id _snapshot_id _stamp _author _action _elements _relation ))

(defmethod skiros2_msgs::WmMonitor
  (:init
   (&key
    ((:prev_snapshot_id __prev_snapshot_id) "")
    ((:snapshot_id __snapshot_id) "")
    ((:stamp __stamp) (instance ros::time :init))
    ((:author __author) "")
    ((:action __action) "")
    ((:elements __elements) (let (r) (dotimes (i 0) (push (instance skiros2_msgs::WmElement :init) r)) r))
    ((:relation __relation) (let (r) (dotimes (i 0) (push (instance skiros2_msgs::Relation :init) r)) r))
    )
   (send-super :init)
   (setq _prev_snapshot_id (string __prev_snapshot_id))
   (setq _snapshot_id (string __snapshot_id))
   (setq _stamp __stamp)
   (setq _author (string __author))
   (setq _action (string __action))
   (setq _elements __elements)
   (setq _relation __relation)
   self)
  (:prev_snapshot_id
   (&optional __prev_snapshot_id)
   (if __prev_snapshot_id (setq _prev_snapshot_id __prev_snapshot_id)) _prev_snapshot_id)
  (:snapshot_id
   (&optional __snapshot_id)
   (if __snapshot_id (setq _snapshot_id __snapshot_id)) _snapshot_id)
  (:stamp
   (&optional __stamp)
   (if __stamp (setq _stamp __stamp)) _stamp)
  (:author
   (&optional __author)
   (if __author (setq _author __author)) _author)
  (:action
   (&optional __action)
   (if __action (setq _action __action)) _action)
  (:elements
   (&rest __elements)
   (if (keywordp (car __elements))
       (send* _elements __elements)
     (progn
       (if __elements (setq _elements (car __elements)))
       _elements)))
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
    ;; string _prev_snapshot_id
    4 (length _prev_snapshot_id)
    ;; string _snapshot_id
    4 (length _snapshot_id)
    ;; time _stamp
    8
    ;; string _author
    4 (length _author)
    ;; string _action
    4 (length _action)
    ;; skiros2_msgs/WmElement[] _elements
    (apply #'+ (send-all _elements :serialization-length)) 4
    ;; skiros2_msgs/Relation[] _relation
    (apply #'+ (send-all _relation :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _prev_snapshot_id
       (write-long (length _prev_snapshot_id) s) (princ _prev_snapshot_id s)
     ;; string _snapshot_id
       (write-long (length _snapshot_id) s) (princ _snapshot_id s)
     ;; time _stamp
       (write-long (send _stamp :sec) s) (write-long (send _stamp :nsec) s)
     ;; string _author
       (write-long (length _author) s) (princ _author s)
     ;; string _action
       (write-long (length _action) s) (princ _action s)
     ;; skiros2_msgs/WmElement[] _elements
     (write-long (length _elements) s)
     (dolist (elem _elements)
       (send elem :serialize s)
       )
     ;; skiros2_msgs/Relation[] _relation
     (write-long (length _relation) s)
     (dolist (elem _relation)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _prev_snapshot_id
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _prev_snapshot_id (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _snapshot_id
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _snapshot_id (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; time _stamp
     (send _stamp :sec (sys::peek buf ptr- :integer)) (incf ptr- 4)  (send _stamp :nsec (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string _author
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _author (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _action
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _action (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; skiros2_msgs/WmElement[] _elements
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _elements (let (r) (dotimes (i n) (push (instance skiros2_msgs::WmElement :init) r)) r))
     (dolist (elem- _elements)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; skiros2_msgs/Relation[] _relation
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _relation (let (r) (dotimes (i n) (push (instance skiros2_msgs::Relation :init) r)) r))
     (dolist (elem- _relation)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get skiros2_msgs::WmMonitor :md5sum-) "ecc40ec88cb57baaf7cf8c07fd40a3c7")
(setf (get skiros2_msgs::WmMonitor :datatype-) "skiros2_msgs/WmMonitor")
(setf (get skiros2_msgs::WmMonitor :definition-)
      "#Possible actions
string ADD=add
string UPDATE=update
string REMOVE=remove
string RESET=reset

#Metadata
string prev_snapshot_id
string snapshot_id
time stamp
#Change
string author
string action
WmElement[] elements
Relation[] relation

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
string objectId
")



(provide :skiros2_msgs/WmMonitor "ecc40ec88cb57baaf7cf8c07fd40a3c7")


