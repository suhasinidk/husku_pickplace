#ifndef _MOVEPICKPLACE_H
#define _MOVEPICKPLACE_H

// MACROS
#include <limits.h>

// ROS
#include <ros/ros.h>
#include <ros/package.h>
#include <geometry_msgs/Pose.h>
#include <iostream>
#include <fstream>
#include <string>

// #include <ros/ros.h>
#include <sensor_msgs/JointState.h>
#include <geometry_msgs/PoseWithCovarianceStamped.h>
#include <geometry_msgs/Twist.h>

// Gazebo Messages
#include <gazebo_msgs/SetModelState.h>
#include <gazebo_msgs/GetModelState.h>
#include <gazebo_msgs/GetLinkState.h>
#include <gazebo_msgs/SpawnModel.h>
#include <gazebo_msgs/DeleteModel.h>
#include <gazebo_msgs/LinkStates.h>


// Gazebo Physics Plugins
#include <gazebo/gazebo.hh>
#include <gazebo/physics/physics.hh>
#include <boost/bind.hpp>
#include <gazebo/gazebo.hh>
#include <gazebo/physics/physics.hh>
#include <gazebo/physics/ContactManager.hh>
#include <gazebo/physics/Contact.hh>
#include <gazebo/common/common.hh>

// TF
#include <tf2_geometry_msgs/tf2_geometry_msgs.h>
#include <tf/transform_datatypes.h>
#include <tf/transform_listener.h>

// Simple inbounds function: https://stackoverflow.com/questions/9255887/stl-function-to-test-whether-a-value-is-within-some-range
template <typename T>
    bool IsInBounds(const T& value, const T& low, const T& high) {
    return !(value < low) && !(high < value);
}

#endif