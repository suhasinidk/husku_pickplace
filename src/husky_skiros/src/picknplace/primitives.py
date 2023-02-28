#!/usr/bin/env python

from actionlib_msgs.msg import GoalStatusArray
from moveit_msgs.msg import MoveGroupActionFeedback
from skiros2_common.core.abstract_skill import State
from skiros2_common.core.primitive import PrimitiveBase

from skiros2_common.core.conditions import ConditionProperty, ConditionRelation
from skiros2_common.core.params import ParamTypes
from skiros2_common.core.world_element import Element
from skiros2_skill.core.skill import SkillDescription

import math
import moveit_commander
import rospy
import sys

_LOAD_X = (0.375, 0.475)
_PASSES = 6

# Primitives
class ArmToHomePrimitiveDescription(SkillDescription):
    def createDescription(self):
        pass

class PickObjectPrimitiveDescription(SkillDescription):
    def createDescription(self):
        # self.addParam('Enter object no:', str, ParamTypes.Required)
        pass

class PlaceObjectPrimitiveDescription(SkillDescription):
    def createDescription(self):
        # self.addParam('Place', 0, ParamTypes.Required)
        pass

class ArmToHomePrimitive(PrimitiveBase):
    def createDescription(self):
        self.setDescription(ArmToHomePrimitiveDescription(), self.__class__.__name__)

    def onInit(self):
        moveit_commander.roscpp_initialize(sys.argv)
        self.mi_cmdr = moveit_commander.MoveGroupCommander('ur_and_gripper')
        rospy.Subscriber('/move_group/status', GoalStatusArray, self.feedback)

    def onStart(self):
        self.mi_cmdr.set_joint_value_target(self.mi_cmdr.get_named_target_values('home'))
        self.mi_cmdr.go(wait=False)
        self.moving = True
        return True

    def execute(self):
        if self.moving:
            return self.step('Moving arm to Home position')
        return self.success('Finished moving arm to Home position')

    def onPreempt(self):
        self.mi_cmdr.stop()
        self.mi_cmdr.clear_pose_targets()
        return self.success('Moving arm to Home position preempted')

    def feedback(self, msg):
        self.moving = any(s.status in (0, 1) for s in msg.status_list)

# class PickObjectPrimitive(PrimitiveBase):
#     def createDescription(self):
#         self.setDescription(PickObjectPrimitiveDescription(), self.__class__.__name__)

#     def onInit(self):
#         moveit_commander.roscpp_initialize(sys.argv)
#         self.mi_cmdr = moveit_commander.MoveGroupCommander('ur_and_gripper')
#         rospy.Subscriber('/move_group/feedback', MoveGroupActionFeedback, self.feedback)

#     def onStart(self):
#         # self.arm_fail = False
#         # self.move = True
#         # return True
#         self.mi_cmdr.set_joint_value_target(self.mi_cmdr.get_named_target_values('pick'))
#         self.mi_cmdr.go(wait=False)
#         self.moving = True
#         return True

#     def execute(self):
#         if self.arm_fail:
#             return self.fail('Failed to load paint (unable to plan arm motion)', -1)
         
#         obj_num = self.params['Enter object no:'].value

#         if obj_num == 0:
#             # goal0 = [-2.3233187627104246, -0.24297234927754996, 7.851575153683399e-05, -1.839794437803537, 1.5621777416779095, -3.125070785880979e-05, 0.4865]

#             # self.mi_cmdr.set_joint_angles(goal0)
#             self.mi_cmdr.set_joint_value_target(self.mi_cmdr.get_named_target_values('pick'))
#             self.mi_cmdr.go(wait=False)
#             self.moving = True
#             # self.mi_cmdr.go(wait=False)
#             self.move = False

#         if obj_num == 1:
#             goal1 = [-2.3233187627104246, -0.24297234927754996, 7.851575153683399e-05, -1.839794437803537, 1.5621777416779095, -3.125070785880979e-05, 0.4865]

#             self.mi_cmdr.set_joint_angles(goal1)
#             self.mi_cmdr.go(wait=False)
#             self.move = False
#         if obj_num == 2:
#             goal2 = [-2.3233187627104246, -0.24297234927754996, 7.851575153683399e-05, -1.839794437803537, 1.5621777416779095, -3.125070785880979e-05, 0.4865]

#             self.mi_cmdr.set_joint_angles(goal2)
#             self.mi_cmdr.go(wait=False)
#             self.move = False
#         if obj_num == 3:
#             goal3 = [-2.3233187627104246, -0.24297234927754996, 7.851575153683399e-05, -1.839794437803537, 1.5621777416779095, -3.125070785880979e-05, 0.4865]

#             self.mi_cmdr.set_joint_angles(goal3)
#             self.mi_cmdr.go(wait=False)
#             self.move = False
#         if obj_num == 4:
#             goal4 = [-2.3233187627104246, -0.24297234927754996, 7.851575153683399e-05, -1.839794437803537, 1.5621777416779095, -3.125070785880979e-05, 0.4865]

#             self.mi_cmdr.set_joint_angles(goal4)
#             self.mi_cmdr.go(wait=False)
#             self.move = False

#         return self.success('Finished loading paint')

#     def onPreempt(self):
#         self.mi_cmdr.stop()
#         self.mi_cmdr.clear_joint_angles()
#         return self.success('Loading paint preempted')

#     def feedback(self, msg):
#         if self.state != State.Running:
#             return

#         if msg.status.status == 3:
#             self.p += 1
#             self.move = True
#         elif msg.status.status == 4:
#             self.arm_fail = True

# class PlaceObjectPrimitive(PrimitiveBase):
#     def createDescription(self):
#         self.setDescription(PlaceObjectPrimitiveDescription(), self.__class__.__name__)

#     def onInit(self):
#         moveit_commander.roscpp_initialize(sys.argv)
#         self.mi_cmdr = moveit_commander.MoveGroupCommander('ur_and_gripper')
#         rospy.Subscriber('/move_group/feedback', MoveGroupActionFeedback, self.feedback)

#     def onStart(self):
#         self.mi_cmdr.set_joint_value_target(self.mi_cmdr.get_named_target_values('place'))
#         self.mi_cmdr.go(wait=False)
#         self.moving = True
#         self.arm_fail = False
#         self.move = True
#         return True

#     def execute(self):
#         # if self.arm_fail:
#         #     return self.fail('Failed to place object (unable to plan arm motion)', -1)

        
#         # if self.move:
#         #     self.mi_cmdr.set_pose_target([0, 0, 0, 0, 0, 0])
#         #     self.mi_cmdr.go(wait=False)
#         #     self.move = False
            
#         #     return self.success('Finished placing object')

#         if self.moving:
#             return self.step('Moving arm to Home position')
#         return self.success('Finished moving arm to Home position')


#     def onPreempt(self):
#         self.mi_cmdr.stop()
#         self.mi_cmdr.clear_pose_targets()
#         return self.success('Placing object preempted')

#     def feedback(self, msg):
#         if self.state != State.Running:
#             return

#         if msg.status.status == 3:
#             self.move = True
#         elif msg.status.status == 4:
#             self.arm_fail = True