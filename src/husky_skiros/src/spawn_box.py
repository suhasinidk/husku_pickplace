#!/usr/bin/env python

import rospy
from gazebo_msgs.srv import SpawnModel, SpawnModelRequest
from copy import deepcopy
from tf.transformations import quaternion_from_euler
import random
from gazebo_ros_link_attacher.srv import Attach, AttachRequest, AttachResponse
import rospkg
rospack = rospkg.RosPack()
path = rospack.get_path('husky_skiros')
sdf_model = open(path + '/urdf/red_box.urdf', 'r').read()

def create_model_request(sdf_model, modelname, px, py, pz, rr, rp, ry):
    
    model = deepcopy(sdf_model)
    req = SpawnModelRequest()
    req.model_name = modelname
    req.model_xml = model
    req.initial_pose.position.x = px
    req.initial_pose.position.y = py
    req.initial_pose.position.z = pz
    q = quaternion_from_euler(rr, rp, ry)
    req.initial_pose.orientation.x = q[0]
    req.initial_pose.orientation.y = q[1]
    req.initial_pose.orientation.z = q[2]
    req.initial_pose.orientation.w = q[3]
    return req

if __name__ == '__main__':
    spawn_srv = rospy.ServiceProxy('/gazebo/spawn_sdf_model', SpawnModel)
    rospy.loginfo('Waiting for /gazebo/spawn_sdf_model service...')
    spawn_srv.wait_for_service()
    rospy.loginfo('Connected to service!')
    
    pose3 = [-0.011668, 5.165944, 0.150000, -3.141591, 0.000010, 0.008610]
    rospy.loginfo('Spawning wall3')
    req3 = create_model_request(sdf_model, 'box3', pose3[0], pose3[1], pose3[2], pose3[3], pose3[4], pose3[5])
    spawn_srv.call(req3)
    
    pose2 = [-0.011668, 5.165944, 1.250000, -3.141591, 0.000010, 0.008610]
    rospy.loginfo('Spawning wall2')
    req2 = create_model_request(sdf_model, 'box2', pose2[0], pose2[1], pose2[2], pose2[3], pose2[4], pose2[5])
    spawn_srv.call(req2)

    pose1 = [-0.011668, 5.165944, 2.350000, -3.141591, 0.000010, 0.008610]
    rospy.loginfo('Spawning wall1')
    req1 = create_model_request(sdf_model, 'box1', pose1[0], pose1[1], pose1[2], pose1[3], pose1[4], pose1[5])
    spawn_srv.call(req1)
        
    rospy.sleep(10.0)