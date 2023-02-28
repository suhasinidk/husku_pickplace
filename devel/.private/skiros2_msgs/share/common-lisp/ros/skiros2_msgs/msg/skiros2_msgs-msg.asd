
(cl:in-package :asdf)

(defsystem "skiros2_msgs-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :actionlib_msgs-msg
               :std_msgs-msg
)
  :components ((:file "_package")
    (:file "AssignTaskAction" :depends-on ("_package_AssignTaskAction"))
    (:file "_package_AssignTaskAction" :depends-on ("_package"))
    (:file "AssignTaskActionFeedback" :depends-on ("_package_AssignTaskActionFeedback"))
    (:file "_package_AssignTaskActionFeedback" :depends-on ("_package"))
    (:file "AssignTaskActionGoal" :depends-on ("_package_AssignTaskActionGoal"))
    (:file "_package_AssignTaskActionGoal" :depends-on ("_package"))
    (:file "AssignTaskActionResult" :depends-on ("_package_AssignTaskActionResult"))
    (:file "_package_AssignTaskActionResult" :depends-on ("_package"))
    (:file "AssignTaskFeedback" :depends-on ("_package_AssignTaskFeedback"))
    (:file "_package_AssignTaskFeedback" :depends-on ("_package"))
    (:file "AssignTaskGoal" :depends-on ("_package_AssignTaskGoal"))
    (:file "_package_AssignTaskGoal" :depends-on ("_package"))
    (:file "AssignTaskResult" :depends-on ("_package_AssignTaskResult"))
    (:file "_package_AssignTaskResult" :depends-on ("_package"))
    (:file "Condition" :depends-on ("_package_Condition"))
    (:file "_package_Condition" :depends-on ("_package"))
    (:file "Param" :depends-on ("_package_Param"))
    (:file "_package_Param" :depends-on ("_package"))
    (:file "Property" :depends-on ("_package_Property"))
    (:file "_package_Property" :depends-on ("_package"))
    (:file "Relation" :depends-on ("_package_Relation"))
    (:file "_package_Relation" :depends-on ("_package"))
    (:file "ResourceDescription" :depends-on ("_package_ResourceDescription"))
    (:file "_package_ResourceDescription" :depends-on ("_package"))
    (:file "SkillProgress" :depends-on ("_package_SkillProgress"))
    (:file "_package_SkillProgress" :depends-on ("_package"))
    (:file "Statement" :depends-on ("_package_Statement"))
    (:file "_package_Statement" :depends-on ("_package"))
    (:file "WmElement" :depends-on ("_package_WmElement"))
    (:file "_package_WmElement" :depends-on ("_package"))
    (:file "WmMonitor" :depends-on ("_package_WmMonitor"))
    (:file "_package_WmMonitor" :depends-on ("_package"))
  ))