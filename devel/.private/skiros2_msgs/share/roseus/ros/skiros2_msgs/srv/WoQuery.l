;; Auto-generated. Do not edit!


(when (boundp 'skiros2_msgs::WoQuery)
  (if (not (find-package "SKIROS2_MSGS"))
    (make-package "SKIROS2_MSGS"))
  (shadow 'WoQuery (find-package "SKIROS2_MSGS")))
(unless (find-package "SKIROS2_MSGS::WOQUERY")
  (make-package "SKIROS2_MSGS::WOQUERY"))
(unless (find-package "SKIROS2_MSGS::WOQUERYREQUEST")
  (make-package "SKIROS2_MSGS::WOQUERYREQUEST"))
(unless (find-package "SKIROS2_MSGS::WOQUERYRESPONSE")
  (make-package "SKIROS2_MSGS::WOQUERYRESPONSE"))

(in-package "ROS")





(defclass skiros2_msgs::WoQueryRequest
  :super ros::object
  :slots (_query_string _context _cut_prefix ))

(defmethod skiros2_msgs::WoQueryRequest
  (:init
   (&key
    ((:query_string __query_string) "")
    ((:context __context) "")
    ((:cut_prefix __cut_prefix) nil)
    )
   (send-super :init)
   (setq _query_string (string __query_string))
   (setq _context (string __context))
   (setq _cut_prefix __cut_prefix)
   self)
  (:query_string
   (&optional __query_string)
   (if __query_string (setq _query_string __query_string)) _query_string)
  (:context
   (&optional __context)
   (if __context (setq _context __context)) _context)
  (:cut_prefix
   (&optional __cut_prefix)
   (if __cut_prefix (setq _cut_prefix __cut_prefix)) _cut_prefix)
  (:serialization-length
   ()
   (+
    ;; string _query_string
    4 (length _query_string)
    ;; string _context
    4 (length _context)
    ;; bool _cut_prefix
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _query_string
       (write-long (length _query_string) s) (princ _query_string s)
     ;; string _context
       (write-long (length _context) s) (princ _context s)
     ;; bool _cut_prefix
       (if _cut_prefix (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _query_string
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _query_string (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _context
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _context (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; bool _cut_prefix
     (setq _cut_prefix (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass skiros2_msgs::WoQueryResponse
  :super ros::object
  :slots (_answer ))

(defmethod skiros2_msgs::WoQueryResponse
  (:init
   (&key
    ((:answer __answer) (let (r) (dotimes (i 0) (push "" r)) r))
    )
   (send-super :init)
   (setq _answer __answer)
   self)
  (:answer
   (&optional __answer)
   (if __answer (setq _answer __answer)) _answer)
  (:serialization-length
   ()
   (+
    ;; string[] _answer
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _answer)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string[] _answer
     (write-long (length _answer) s)
     (dolist (elem _answer)
       (write-long (length elem) s) (princ elem s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string[] _answer
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _answer (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _answer i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;;
   self)
  )

(defclass skiros2_msgs::WoQuery
  :super ros::object
  :slots ())

(setf (get skiros2_msgs::WoQuery :md5sum-) "c279e11806ad32f0e36af84c5a02aba8")
(setf (get skiros2_msgs::WoQuery :datatype-) "skiros2_msgs/WoQuery")
(setf (get skiros2_msgs::WoQuery :request) skiros2_msgs::WoQueryRequest)
(setf (get skiros2_msgs::WoQuery :response) skiros2_msgs::WoQueryResponse)

(defmethod skiros2_msgs::WoQueryRequest
  (:response () (instance skiros2_msgs::WoQueryResponse :init)))

(setf (get skiros2_msgs::WoQueryRequest :md5sum-) "c279e11806ad32f0e36af84c5a02aba8")
(setf (get skiros2_msgs::WoQueryRequest :datatype-) "skiros2_msgs/WoQueryRequest")
(setf (get skiros2_msgs::WoQueryRequest :definition-)
      "#World Ontology query message
#Std Owl query (use SPARQL syntax, e.g. \"SELECT ?x WHERE { ?x rdf:type stmn:GraspingPose. }\")
string query_string
string context
bool cut_prefix
---
#Owl answer (with matches separated by endline)
string[] answer

")

(setf (get skiros2_msgs::WoQueryResponse :md5sum-) "c279e11806ad32f0e36af84c5a02aba8")
(setf (get skiros2_msgs::WoQueryResponse :datatype-) "skiros2_msgs/WoQueryResponse")
(setf (get skiros2_msgs::WoQueryResponse :definition-)
      "#World Ontology query message
#Std Owl query (use SPARQL syntax, e.g. \"SELECT ?x WHERE { ?x rdf:type stmn:GraspingPose. }\")
string query_string
string context
bool cut_prefix
---
#Owl answer (with matches separated by endline)
string[] answer

")



(provide :skiros2_msgs/WoQuery "c279e11806ad32f0e36af84c5a02aba8")


