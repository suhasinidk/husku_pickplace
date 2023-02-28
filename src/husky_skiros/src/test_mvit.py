#! /usr/bin/env python

import rospy
import sys
import copy
import moveit_commander
import moveit_msgs.msg

import actionlib


class pick_n_place:

    # Constructor
    def __init__(self):

        rospy.init_node('pick_and_place_node', anonymous=True)

        self._planning_group = "ur_and_gripper"
        self._commander = moveit_commander.roscpp_initialize(sys.argv)
        self._robot = moveit_commander.RobotCommander()
        self._scene = moveit_commander.PlanningSceneInterface()
        self._group = moveit_commander.MoveGroupCommander(self._planning_group)
        self._display_trajectory_publisher = rospy.Publisher(
            '/move_group/display_planned_path', moveit_msgs.msg.DisplayTrajectory, queue_size=1)

        self._exectute_trajectory_client = actionlib.SimpleActionClient(
            'execute_trajectory', moveit_msgs.msg.ExecuteTrajectoryAction)
        self._exectute_trajectory_client.wait_for_server()

        self._planning_frame = self._group.get_planning_frame()
        self._eef_link = self._group.get_end_effector_link()
        self._group_names = self._robot.get_group_names()

        self.values = self._group.get_current_joint_values()

    def set_joint_angles(self, arg_list_joint_angles):

        list_joint_values = self._group.get_current_joint_values()
        list_joint_values = arg_list_joint_angles
        self._group.set_joint_value_target(list_joint_values)
        self._group.plan()
        self._group.go(wait=True)
        rospy.sleep(2)

    # Destructor
    def __del__(self):

        moveit_commander.roscpp_shutdown()


def main():
    
    #Decalre variable for the class pick_n_place
    arm = pick_n_place()

    print(arm.values)
   
             
    # joint angles to pick object 1
    # goal1_0 = [-2.3233187627104246, -0.24297234927754996, 7.851575153683399e-05, -1.839794437803537, 1.5621777416779095, -3.125070785880979e-05, 0.4865]
    
    # picks object 1
    # arm.set_joint_angles(goal1_0)

    # destroy class   
    del arm

if __name__ == '__main__':
    main()