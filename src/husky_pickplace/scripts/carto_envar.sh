#!/bin/bash

# To run cartographer:
export HUSKY_REALSENSE_ENABLED=0
export HUSKY_LMS1XX_ENABLED=1
export HUSKY_GAZEBO_DESCRIPTION=/opt/ros/melodic/share/husky_gazebo/urdf/description.gazebo.xacro
export HUSKY_LMS1XX_XYZ="-0.3 0.0 -0.02"	# Push this back and down
export HUSKY_SENSOR_ARCH=false
export HUSKY_SENSOR_ARCH_OFFSET="-0.375 0.0 0.0"
export HUSKY_SENSOR_ARCH_RPY="0.0 0.0 3.1415927"

# Do not turn on the arm:
unset HUSKY_URDF_EXTRAS

# Enable top plate for arm:
export HUSKY_USER_RAIL_ENABLED=false
export HUSKY_LARGE_TOP_PLATE=true