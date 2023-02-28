;; Auto-generated. Do not edit!


(when (boundp 'skiros2_msgs::Param)
  (if (not (find-package "SKIROS2_MSGS"))
    (make-package "SKIROS2_MSGS"))
  (shadow 'Param (find-package "SKIROS2_MSGS")))
(unless (find-package "SKIROS2_MSGS::PARAM")
  (make-package "SKIROS2_MSGS::PARAM"))

(in-package "ROS")
;;//! \htmlinclude Param.msg.html


(defclass skiros2_msgs::Param
  :super ros::object
  :slots (_param ))

(defmethod skiros2_msgs::Param
  (:init
   (&key
    ((:param __param) "")
    )
   (send-super :init)
   (setq _param (string __param))
   self)
  (:param
   (&optional __param)
   (if __param (setq _param __param)) _param)
  (:serialization-length
   ()
   (+
    ;; string _param
    4 (length _param)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _param
       (write-long (length _param) s) (princ _param s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _param
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _param (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get skiros2_msgs::Param :md5sum-) "eb04b7504512676dca105ab8842899a4")
(setf (get skiros2_msgs::Param :datatype-) "skiros2_msgs/Param")
(setf (get skiros2_msgs::Param :definition-)
      "string param
")



(provide :skiros2_msgs/Param "eb04b7504512676dca105ab8842899a4")


