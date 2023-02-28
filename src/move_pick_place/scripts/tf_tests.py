#!/usr/bin/env python  
import roslib
# roslib.load_manifest('learning_tf')
import rospy
import math
import tf
import geometry_msgs.msg
# import turtlesim.srv

if __name__ == '__main__':
    rospy.init_node('tf_tester_wmt')

    listener = tf.TransformListener()

    # rospy.wait_for_service('spawn')
    # spawner = rospy.ServiceProxy('spawn', turtlesim.srv.Spawn)
    # spawner(4, 2, 0, 'turtle2')

    # turtle_vel = rospy.Publisher('turtle2/cmd_vel', geometry_msgs.msg.Twist,queue_size=1)

    rate = rospy.Rate(10.0)
    while not rospy.is_shutdown():
        try:
            # tf_listener_.getLatestCommonTime("/ur_arm_tool0", "/frame")
   
            (trans,rot) = listener.lookupTransform('/ur_arm_tool0', '/map', rospy.Time(0))
            print "Translational Matrix from arm_tool to map:"
            print trans;

            print "Rotational Matrix from arm_tool to map:"
            print rot
            
            p1 = geometry_msgs.msg.PoseStamped()
            p1.header.frame_id = "map"
            p1.pose.position.x = 3
            p1.pose.position.y = -5
            p1.pose.position.z = 0.0475

            quaternion = tf.transformations.quaternion_from_euler(0, 0, math.pi/2)
            # quaternion = tf.transformations.quaternion_from_euler(-math.pi/2, -math.pi/2, math.pi)

            p1.pose.orientation.x = quaternion[0]
            p1.pose.orientation.y = quaternion[1]
            p1.pose.orientation.z = quaternion[2]
            p1.pose.orientation.w = quaternion[3]
            
            p_in_base = listener.transformPose("/base_link", p1)
            print "Position of the frame in the robot base:"
            print p_in_base

            p_in_arm = listener.transformPose("/ur_arm_tool0", p1)
            print "Position of the frame in the ur_arm_tool0 base:"
            print p_in_arm
            

        except (tf.LookupException, tf.ConnectivityException, tf.ExtrapolationException):
            continue

        # angular = 4 * math.atan2(trans[1], trans[0])
        # linear = 0.5 * math.sqrt(trans[0] ** 2 + trans[1] ** 2)
        # cmd = geometry_msgs.msg.Twist()
        # cmd.linear.x = linear
        # cmd.angular.z = angular
        # turtle_vel.publish(cmd)

        rate.sleep()

# class myNode:
#     def __init__(self, *args):
#         self.tf_listener_ = TransformListener()

#     def example_function(self):
#         if self.tf.frameExists("/ur_arm_tool0") and self.tf.frameExists("/frame"):
#             t = self.tf_listener_.getLatestCommonTime("/ur_arm_tool0", "/frame")
#             p1 = geometry_msgs.msg.PoseStamped()
#             p1.header.frame_id = "frame"
#             p1.pose.orientation.w = 1.0    # Neutral orientation
#             p_in_base = self.tf_listener_.transformPose("/base_link", p1)
#             print "Position of the frame in the robot base:"
#             print p_in_base