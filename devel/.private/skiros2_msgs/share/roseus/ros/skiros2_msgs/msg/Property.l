;; Auto-generated. Do not edit!


(when (boundp 'skiros2_msgs::Property)
  (if (not (find-package "SKIROS2_MSGS"))
    (make-package "SKIROS2_MSGS"))
  (shadow 'Property (find-package "SKIROS2_MSGS")))
(unless (find-package "SKIROS2_MSGS::PROPERTY")
  (make-package "SKIROS2_MSGS::PROPERTY"))

(in-package "ROS")
;;//! \htmlinclude Property.msg.html


(defclass skiros2_msgs::Property
  :super ros::object
  :slots (_key _dataValue _dataType ))

(defmethod skiros2_msgs::Property
  (:init
   (&key
    ((:key __key) "")
    ((:dataValue __dataValue) "")
    ((:dataType __dataType) "")
    )
   (send-super :init)
   (setq _key (string __key))
   (setq _dataValue (string __dataValue))
   (setq _dataType (string __dataType))
   self)
  (:key
   (&optional __key)
   (if __key (setq _key __key)) _key)
  (:dataValue
   (&optional __dataValue)
   (if __dataValue (setq _dataValue __dataValue)) _dataValue)
  (:dataType
   (&optional __dataType)
   (if __dataType (setq _dataType __dataType)) _dataType)
  (:serialization-length
   ()
   (+
    ;; string _key
    4 (length _key)
    ;; string _dataValue
    4 (length _dataValue)
    ;; string _dataType
    4 (length _dataType)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _key
       (write-long (length _key) s) (princ _key s)
     ;; string _dataValue
       (write-long (length _dataValue) s) (princ _dataValue s)
     ;; string _dataType
       (write-long (length _dataType) s) (princ _dataType s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _key
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _key (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _dataValue
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _dataValue (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _dataType
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _dataType (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get skiros2_msgs::Property :md5sum-) "5b6c0ddf599766e37ee213fe87f04771")
(setf (get skiros2_msgs::Property :datatype-) "skiros2_msgs/Property")
(setf (get skiros2_msgs::Property :definition-)
      "string key
string dataValue
string dataType

")



(provide :skiros2_msgs/Property "5b6c0ddf599766e37ee213fe87f04771")


