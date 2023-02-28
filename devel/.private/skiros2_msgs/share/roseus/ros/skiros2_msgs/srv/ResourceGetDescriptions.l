;; Auto-generated. Do not edit!


(when (boundp 'skiros2_msgs::ResourceGetDescriptions)
  (if (not (find-package "SKIROS2_MSGS"))
    (make-package "SKIROS2_MSGS"))
  (shadow 'ResourceGetDescriptions (find-package "SKIROS2_MSGS")))
(unless (find-package "SKIROS2_MSGS::RESOURCEGETDESCRIPTIONS")
  (make-package "SKIROS2_MSGS::RESOURCEGETDESCRIPTIONS"))
(unless (find-package "SKIROS2_MSGS::RESOURCEGETDESCRIPTIONSREQUEST")
  (make-package "SKIROS2_MSGS::RESOURCEGETDESCRIPTIONSREQUEST"))
(unless (find-package "SKIROS2_MSGS::RESOURCEGETDESCRIPTIONSRESPONSE")
  (make-package "SKIROS2_MSGS::RESOURCEGETDESCRIPTIONSRESPONSE"))

(in-package "ROS")





(defclass skiros2_msgs::ResourceGetDescriptionsRequest
  :super ros::object
  :slots ())

(defmethod skiros2_msgs::ResourceGetDescriptionsRequest
  (:init
   (&key
    )
   (send-super :init)
   self)
  (:serialization-length
   ()
   (+
    0
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;;
   self)
  )

(defclass skiros2_msgs::ResourceGetDescriptionsResponse
  :super ros::object
  :slots (_list ))

(defmethod skiros2_msgs::ResourceGetDescriptionsResponse
  (:init
   (&key
    ((:list __list) (let (r) (dotimes (i 0) (push (instance skiros2_msgs::ResourceDescription :init) r)) r))
    )
   (send-super :init)
   (setq _list __list)
   self)
  (:list
   (&rest __list)
   (if (keywordp (car __list))
       (send* _list __list)
     (progn
       (if __list (setq _list (car __list)))
       _list)))
  (:serialization-length
   ()
   (+
    ;; skiros2_msgs/ResourceDescription[] _list
    (apply #'+ (send-all _list :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; skiros2_msgs/ResourceDescription[] _list
     (write-long (length _list) s)
     (dolist (elem _list)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; skiros2_msgs/ResourceDescription[] _list
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _list (let (r) (dotimes (i n) (push (instance skiros2_msgs::ResourceDescription :init) r)) r))
     (dolist (elem- _list)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(defclass skiros2_msgs::ResourceGetDescriptions
  :super ros::object
  :slots ())

(setf (get skiros2_msgs::ResourceGetDescriptions :md5sum-) "689dba5a19baf7321e2b246602dfca10")
(setf (get skiros2_msgs::ResourceGetDescriptions :datatype-) "skiros2_msgs/ResourceGetDescriptions")
(setf (get skiros2_msgs::ResourceGetDescriptions :request) skiros2_msgs::ResourceGetDescriptionsRequest)
(setf (get skiros2_msgs::ResourceGetDescriptions :response) skiros2_msgs::ResourceGetDescriptionsResponse)

(defmethod skiros2_msgs::ResourceGetDescriptionsRequest
  (:response () (instance skiros2_msgs::ResourceGetDescriptionsResponse :init)))

(setf (get skiros2_msgs::ResourceGetDescriptionsRequest :md5sum-) "689dba5a19baf7321e2b246602dfca10")
(setf (get skiros2_msgs::ResourceGetDescriptionsRequest :datatype-) "skiros2_msgs/ResourceGetDescriptionsRequest")
(setf (get skiros2_msgs::ResourceGetDescriptionsRequest :definition-)
      "---
ResourceDescription[] list





================================================================================
MSG: skiros2_msgs/ResourceDescription
string type
string name
Param[] params

================================================================================
MSG: skiros2_msgs/Param
")

(setf (get skiros2_msgs::ResourceGetDescriptionsResponse :md5sum-) "689dba5a19baf7321e2b246602dfca10")
(setf (get skiros2_msgs::ResourceGetDescriptionsResponse :datatype-) "skiros2_msgs/ResourceGetDescriptionsResponse")
(setf (get skiros2_msgs::ResourceGetDescriptionsResponse :definition-)
      "---
ResourceDescription[] list





================================================================================
MSG: skiros2_msgs/ResourceDescription
string type
string name
Param[] params

================================================================================
MSG: skiros2_msgs/Param
")



(provide :skiros2_msgs/ResourceGetDescriptions "689dba5a19baf7321e2b246602dfca10")


