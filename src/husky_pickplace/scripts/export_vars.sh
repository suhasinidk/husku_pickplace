#!/bin/bash
# To run AMCL with new description for pick and place:
export HUSKY_LMS1XX_ENABLED=1
export HUSKY_LMS1XX_XYZ="0.5206 0.0 0.00635"	# Push this forward to avoid the arm.
export HUSKY_GAZEBO_DESCRIPTION=/opt/ros/melodic/share/husky_gazebo/urdf/description.gazebo.xacro

# Old lidar and laser topic vars
export HUSKY_LASER_3D_ENABLED=0
export HUSKY_LASER_TOPIC=/realsense/scan


# To run cartographer:
export HUSKY_REALSENSE_ENABLED=0
export HUSKY_LMS1XX_ENABLED=1

# DO NOT USE
export HUSKY_REALSENSE_ENABLED=1 			# Unnecessary until vision is required.
export HUSKY_LMS1XX_SECONDARY_ENABLED=1 	# Secondary scanner collides with arm.
export HUSKY_SENSOR_ARCH_OFFSET="0 0 0"
export HUSKY_REALSENSE_XYZ="0 0 0"