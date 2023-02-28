;; Auto-generated. Do not edit!


(when (boundp 'skiros2_msgs::Condition)
  (if (not (find-package "SKIROS2_MSGS"))
    (make-package "SKIROS2_MSGS"))
  (shadow 'Condition (find-package "SKIROS2_MSGS")))
(unless (find-package "SKIROS2_MSGS::CONDITION")
  (make-package "SKIROS2_MSGS::CONDITION"))

(in-package "ROS")
;;//! \htmlinclude Condition.msg.html


(defclass skiros2_msgs::Condition
  :super ros::object
  :slots (_type _label _subject _predicate _object _state ))

(defmethod skiros2_msgs::Condition
  (:init
   (&key
    ((:type __type) "")
    ((:label __label) "")
    ((:subject __subject) "")
    ((:predicate __predicate) "")
    ((:object __object) "")
    ((:state __state) nil)
    )
   (send-super :init)
   (setq _type (string __type))
   (setq _label (string __label))
   (setq _subject (string __subject))
   (setq _predicate (string __predicate))
   (setq _object (string __object))
   (setq _state __state)
   self)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:label
   (&optional __label)
   (if __label (setq _label __label)) _label)
  (:subject
   (&optional __subject)
   (if __subject (setq _subject __subject)) _subject)
  (:predicate
   (&optional __predicate)
   (if __predicate (setq _predicate __predicate)) _predicate)
  (:object
   (&optional __object)
   (if __object (setq _object __object)) _object)
  (:state
   (&optional __state)
   (if __state (setq _state __state)) _state)
  (:serialization-length
   ()
   (+
    ;; string _type
    4 (length _type)
    ;; string _label
    4 (length _label)
    ;; string _subject
    4 (length _subject)
    ;; string _predicate
    4 (length _predicate)
    ;; string _object
    4 (length _object)
    ;; bool _state
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _type
       (write-long (length _type) s) (princ _type s)
     ;; string _label
       (write-long (length _label) s) (princ _label s)
     ;; string _subject
       (write-long (length _subject) s) (princ _subject s)
     ;; string _predicate
       (write-long (length _predicate) s) (princ _predicate s)
     ;; string _object
       (write-long (length _object) s) (princ _object s)
     ;; bool _state
       (if _state (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _type
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _type (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _label
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _label (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _subject
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _subject (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _predicate
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _predicate (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _object
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _object (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; bool _state
     (setq _state (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get skiros2_msgs::Condition :md5sum-) "bb14a9ac922b0de986bc6c6a486485a0")
(setf (get skiros2_msgs::Condition :datatype-) "skiros2_msgs/Condition")
(setf (get skiros2_msgs::Condition :definition-)
      "string type
string label
string subject
string predicate
string object
bool state

")



(provide :skiros2_msgs/Condition "bb14a9ac922b0de986bc6c6a486485a0")


