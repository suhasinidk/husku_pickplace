#!/usr/bin/env bash
# Source this script with the command:
# source $(catkin_find husky_ur_description)/scripts/husky_ur5_envar.sh

# Sensors for the Husky:
unset HUSKY_REALSENSE_ENABLED
export HUSKY_LMS1XX_ENABLED=1
# export HUSKY_LMS1XX_XYZ="0.6206 0.0 0.00635"	# Push this forward to avoid the arm.
export HUSKY_LMS1XX_XYZ="-0.3 0.0 -0.02"	# Push this back and down
export HUSKY_SENSOR_ARCH=false
export HUSKY_SENSOR_ARCH_OFFSET="-0.375 0.0 0.0"
export HUSKY_SENSOR_ARCH_RPY="0.0 0.0 3.1415927"
export HUSKY_GAZEBO_DESCRIPTION=/opt/ros/melodic/share/husky_gazebo/urdf/description.gazebo.xacro

# Enable top plate for arm:
export HUSKY_USER_RAIL_ENABLED=false
export HUSKY_LARGE_TOP_PLATE=true

# Set position of single arm:
export HUSKY_UR_XYZ="-0.105 0.0 0.0"
export HUSKY_UR_RPY="0 0 3.1415927"

# Include the URDF for the arm as a URDF EXTRA:
export HUSKY_URDF_EXTRAS=$(catkin_find husky_ur_description urdf/husky_ur5_description.urdf.xacro --first-only)

# Set positions for dual arms:
# export HUSKY_LEFT_UR_XYZ
# export HUSKY_LEFT_UR_RPY
# export HUSKY_RIGHT_UR_XYZ
# export HUSKY_RIGHT_UR_RPY

# The Realsense camera is typically mounted to an arch, so set them back and away from the arm:
# export HUSKY_REALSENSE_ENABLED=1
# export HUSKY_SENSOR_ARCH_OFFSET="0 0 0"
# export HUSKY_REALSENSE_XYZ="0 0 0"