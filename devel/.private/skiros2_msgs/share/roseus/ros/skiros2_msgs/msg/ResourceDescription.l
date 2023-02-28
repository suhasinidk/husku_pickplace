;; Auto-generated. Do not edit!


(when (boundp 'skiros2_msgs::ResourceDescription)
  (if (not (find-package "SKIROS2_MSGS"))
    (make-package "SKIROS2_MSGS"))
  (shadow 'ResourceDescription (find-package "SKIROS2_MSGS")))
(unless (find-package "SKIROS2_MSGS::RESOURCEDESCRIPTION")
  (make-package "SKIROS2_MSGS::RESOURCEDESCRIPTION"))

(in-package "ROS")
;;//! \htmlinclude ResourceDescription.msg.html


(defclass skiros2_msgs::ResourceDescription
  :super ros::object
  :slots (_type _name _params ))

(defmethod skiros2_msgs::ResourceDescription
  (:init
   (&key
    ((:type __type) "")
    ((:name __name) "")
    ((:params __params) (let (r) (dotimes (i 0) (push (instance skiros2_msgs::Param :init) r)) r))
    )
   (send-super :init)
   (setq _type (string __type))
   (setq _name (string __name))
   (setq _params __params)
   self)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:params
   (&rest __params)
   (if (keywordp (car __params))
       (send* _params __params)
     (progn
       (if __params (setq _params (car __params)))
       _params)))
  (:serialization-length
   ()
   (+
    ;; string _type
    4 (length _type)
    ;; string _name
    4 (length _name)
    ;; skiros2_msgs/Param[] _params
    (apply #'+ (send-all _params :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _type
       (write-long (length _type) s) (princ _type s)
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;; skiros2_msgs/Param[] _params
     (write-long (length _params) s)
     (dolist (elem _params)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _type
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _type (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; skiros2_msgs/Param[] _params
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _params (let (r) (dotimes (i n) (push (instance skiros2_msgs::Param :init) r)) r))
     (dolist (elem- _params)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get skiros2_msgs::ResourceDescription :md5sum-) "f305b743733527b01e745de4106cca51")
(setf (get skiros2_msgs::ResourceDescription :datatype-) "skiros2_msgs/ResourceDescription")
(setf (get skiros2_msgs::ResourceDescription :definition-)
      "string type
string name
Param[] params

================================================================================
MSG: skiros2_msgs/Param
string param
")



(provide :skiros2_msgs/ResourceDescription "f305b743733527b01e745de4106cca51")


