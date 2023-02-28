/*********************************************************************
* Name:         move_pick_place.cpp
* Description:  Moves a Clearpath Husky with UR5 arm around a map to
*               pick up a drywall panel and then place it at another
*               location.
* Author:       William Turner
* Derived:      Borrowed code from pick_place_tutorial.cpp for ROS
*               Melodic.
*********************************************************************/

// MACROS
#define OBJECT_STANDOFF_TRANS_X 0.0
// Drywall panel has dimension: <size>1.2192 0.0127 1.2192</size>
// Lower the y-coordinate to the lower quarter, 1.2192/2/2 =  0.3048
// graspPoint->pose.position.y += .3048;
#define OBJECT_STANDOFF_TRANS_Y 0.2048
#define OBJECT_STANDOFF_TRANS_Z 0.03

// ROS
#include <ros/ros.h>
#include <ros/package.h>
#include <geometry_msgs/Pose.h>
#include <iostream>
#include <fstream>
#include <string>

#include <ros/ros.h>
#include <sensor_msgs/JointState.h>
#include <geometry_msgs/PoseWithCovarianceStamped.h>

// Gazebo
#include <gazebo_msgs/SetModelState.h>
#include <gazebo_msgs/GetModelState.h>
#include <gazebo_msgs/SpawnModel.h>

// MoveIt
#include <moveit/planning_scene_interface/planning_scene_interface.h>
#include <moveit/move_group_interface/move_group_interface.h>

#include <moveit_msgs/DisplayRobotState.h>
#include <moveit_msgs/DisplayTrajectory.h>

#include <moveit_msgs/AttachedCollisionObject.h>
#include <moveit_msgs/CollisionObject.h>
#include <moveit/robot_state/conversions.h>

// #include <moveit/robot_model_loader/robot_model_loader.h>
#include <moveit_visual_tools/moveit_visual_tools.h>

// TF
#include <tf2_geometry_msgs/tf2_geometry_msgs.h>
#include <tf/transform_datatypes.h>
#include <tf/transform_listener.h>

// Move Base
#include <move_base_msgs/MoveBaseAction.h>
#include <actionlib/client/simple_action_client.h>

// Simple inbounds function: https://stackoverflow.com/questions/9255887/stl-function-to-test-whether-a-value-is-within-some-range
template <typename T>
    bool IsInBounds(const T& value, const T& low, const T& high) {
    return !(value < low) && !(high < value);
}

/*  spawnDrywall: 
    A helper function to spawn the drywall_panel model on top of the drywall stack.
*/
int spawnDrywall(int drywallNum, ros::ServiceClient getModelStateClient, ros::ServiceClient spawnModelClient)
{
  // Generate messsages to interact with models (spawn + get state) as well as navigate the husky.
  gazebo_msgs::SpawnModel spawnModel;
  gazebo_msgs::GetModelState getModelState;
  geometry_msgs::Pose loadPoint;

  // Give the drywall panel a name with input number.
  std::string drywallName = "drywall_panel" + std::to_string(drywallNum);

  // Set the drywall panel name.
  getModelState.request.model_name = drywallName.c_str();

  // Call the model state to determine if the drywall panel already exists.
  if ( !getModelStateClient.call(getModelState))
  {
      // Already exists, return 0.
      ROS_WARN("Drywall panel %d already exists!", drywallNum );
      return 0;
  }

  // Drywall panel not found, create on top of drywall stack with pose, <pose frame=''>-1 -5 0.025 0 -0 0</pose>
  loadPoint.position.x = -1.0;
  loadPoint.position.y = -5.0;

  // Stack has size: <size>1.2192 1.2192 0.5</size>, drywall panel has size:
  // <size>1.2192 0.0127 1.2192</size>, so 0.50 + 0.0127/2 = 0.5064
  loadPoint.position.z = 0.507; // round up for wiggle room

  // Set the tf2 quaternion message with RPY.
  tf2::Quaternion quat_tf;
  quat_tf.setRPY(M_PI/2, 0.000, 0.000);

  // Create the quaternion message from the tf2 msg.
  geometry_msgs::Quaternion quat_msg = tf2::toMsg(quat_tf);

  // Set the orientation of the goal pose.
  loadPoint.orientation = quat_msg;

  // Open the SDF file at the local path of the package
  std::string pkg_path = ros::package::getPath("move_pick_place");
  std::string sdf_file_name = pkg_path + "/models/drywall_panel/model.sdf";

  // Open the xml file
  std::ifstream xml_file(sdf_file_name);
  std::stringstream sdf_xml;

  // Read the entire SDF file contents to the ss variable, sdf_xml
  if ( xml_file.is_open() ) {
    sdf_xml << xml_file.rdbuf();
  }
  else{
    // Report error if file could not be read.
    ROS_ERROR("FAILURE: Could not open sdf file of: %s", sdf_file_name.c_str());
  }

  // Configure the settings for it.
  spawnModel.request.model_name = drywallName.c_str();
  spawnModel.request.model_xml = sdf_xml.str().c_str();
  spawnModel.request.robot_namespace = "";
  spawnModel.request.initial_pose = loadPoint;
  spawnModel.request.reference_frame = "world";

  if (spawnModelClient.call(spawnModel))
  {
      // Success, return 0
      ROS_INFO("SUCCESS: spawn new drywall: %s", drywallName.c_str());
      return 0;
  }
  else{
      ROS_ERROR("FAILURE: spawn new drywall: %s", drywallName.c_str());
      return 1;
  }
}

class HuskyArm{
  private:
    typedef actionlib::SimpleActionClient<move_base_msgs::MoveBaseAction> MoveBaseClient;
    ros::ServiceClient getModelStateClient;
    ros::ServiceClient setModelStateClient;
    ros::ServiceClient spawnModelClient;

    // Create a publisher to intialize the initial pose of AMCL.
    ros::Publisher initialpose_pub;
    ros::Subscriber amclpose_sub;

    // Manage a move group pointer as described here:
    // https://answers.ros.org/question/344598/cant-create-movegroupinterface-object-in-my-own-class/
    moveit::planning_interface::MoveGroupInterface* move_group_ptr_;
    moveit::planning_interface::PlanningSceneInterface* planning_scene_interface_ptr;

    MoveBaseClient *move_base_ptr_;

    // Create a goal for loading zone
    move_base_msgs::MoveBaseGoal loadZone;
    move_base_msgs::MoveBaseGoal wayPointLoad;

    // Model State Publisher and Joint States
    ros::Publisher gazebo_model_state_pub;
    ros::Subscriber joint_states_sub;

    // Variable to flag whether the demo is currently grasping the drywall panel.
    bool isGrasping;

    // Name of the grasped object.
    std::string graspObj;

    // Objects for the planner to work around
    std::vector<std::string> planning_object_ids;

    // Variable to store the NodeHandle created in the main() loop.
    ros::NodeHandle nh;

    // TF Listener Variables
    tf::TransformListener transform_listener;

    geometry_msgs::PoseWithCovarianceStamped amcl_pose;

  public:
    /*  Constructor: 
        Initialize the robot arm and stow it.
    */
    HuskyArm(ros::NodeHandle node_handle)
    {
      // Store the node handle.
      nh = node_handle;

      // These services are for the programatic creation of drywall panels
      getModelStateClient = nh.serviceClient<gazebo_msgs::GetModelState>("/gazebo/get_model_state");
      setModelStateClient = nh.serviceClient<gazebo_msgs::SetModelState>("/gazebo/set_model_state");
      spawnModelClient = nh.serviceClient<gazebo_msgs::SpawnModel>("/gazebo/spawn_sdf_model");
      initialpose_pub = nh.advertise<geometry_msgs::PoseWithCovarianceStamped>("/initialpose", 1000);
      amclpose_sub = nh.subscribe("/amcl_pose", 1, &HuskyArm::amclPoseCallback, this);

      // Initialize MoveIt interfaces.
      planning_scene_interface_ptr = new moveit::planning_interface::PlanningSceneInterface();
      move_group_ptr_ = new moveit::planning_interface::MoveGroupInterface("ur5_arm");
      move_group_ptr_->setPlanningTime(60.0);
      move_group_ptr_->startStateMonitor();
      move_group_ptr_->setWorkspace( -50, -50, 0, 50, 50, 50);

      ROS_INFO("Loaded robot model with end effector: %s", move_group_ptr_->getEndEffectorLink().c_str());

      // Started State Monitor, wait a moment to let ROS settle.
      ros::WallDuration(1.0).sleep();

      stow();
      ROS_INFO("Stow finished, waiting on ROS...");

      // Let ROS calm down before starting up Move Base client.
      ros::WallDuration(3.0).sleep();

      // Tell the action client that we want to spin a thread by default
      move_base_ptr_ = new MoveBaseClient("move_base", true);
      
      // Wait for the action server to come up
      while(!move_base_ptr_->waitForServer(ros::Duration(5.0))){
        ROS_INFO("Waiting for the move_base action server to come up");
      }

      // Initialize the loading zone settings
      loadZone.target_pose.header.frame_id = "map";

      // Initialize x and y coordinates for loading zone
      loadZone.target_pose.pose.position.x = -1.0;
      loadZone.target_pose.pose.position.y = -3.75;

      // Set the tf2 quaternion message with RPY.
      tf2::Quaternion quat_tf;
      quat_tf.setRPY(0.000, 0.000, 3*M_PI_2);

      // Create the quaternion message from the tf2 msg.
      geometry_msgs::Quaternion quat_msg = tf2::toMsg(quat_tf);

      // Set the orientation of the goal pose.
      loadZone.target_pose.pose.orientation = quat_msg;

      // Set up the grasp publisher and subscriber
      gazebo_model_state_pub = nh.advertise<gazebo_msgs::ModelState>("/gazebo/set_model_state", 1);
      joint_states_sub = nh.subscribe("/joint_states", 1, &HuskyArm::jointStatesCallback, this);

      isGrasping = false;
      graspObj = "";

      planning_object_ids.clear();

      double initialposeX, initialposeY, initialposeZ, initialposeYaw;
      if(nh.getParam("/initialposeX", initialposeX)){}else{initialposeX=0.0;};
      if(nh.getParam("/initialposeY", initialposeY)){}else{initialposeY=0.0;};
      if(nh.getParam("/initialposeZ", initialposeZ)){}else{initialposeZ=0.0;};
      if(nh.getParam("/initialposeYaw", initialposeYaw)){}else{initialposeYaw=-1.5707;};

      // Create a message for initialpose with initialized header
      geometry_msgs::PoseWithCovarianceStamped initialpose_amcl;
      initialpose_amcl.header.frame_id="map";
      initialpose_amcl.header.stamp = ros::Time::now();

      // Set the position from param server
      initialpose_amcl.pose.pose.position.x = initialposeX;
      initialpose_amcl.pose.pose.position.y = initialposeY;
      initialpose_amcl.pose.pose.position.z = initialposeZ;

      // Set a quaternion for the RPY
      quat_tf.setRPY(0.000, 0.000, initialposeYaw);

      // Create the quaternion message from the tf2 msg.
      quat_msg = tf2::toMsg(quat_tf);

      // Set the orientation of the goal pose.
      initialpose_amcl.pose.pose.orientation = quat_msg;

      // Get AMCL intialized to simulation's starting location
      initialpose_pub.publish(initialpose_amcl);

      bool match = false;
      int matchCounter = 0;

      // Wait until pose is obtained.
      while( !match && matchCounter < 10 )
      {
        match = IsInBounds(amcl_pose.pose.pose.position.x, initialpose_amcl.pose.pose.position.x-.25, initialpose_amcl.pose.pose.position.x+.25) &&
                IsInBounds(amcl_pose.pose.pose.position.y, initialpose_amcl.pose.pose.position.y-.25, initialpose_amcl.pose.pose.position.y+.25) &&
                IsInBounds(amcl_pose.pose.pose.orientation.x, initialpose_amcl.pose.pose.orientation.x-.15, initialpose_amcl.pose.pose.orientation.x+.15) &&
                IsInBounds(amcl_pose.pose.pose.orientation.y, initialpose_amcl.pose.pose.orientation.y-.15, initialpose_amcl.pose.pose.orientation.y+.15) &&
                IsInBounds(amcl_pose.pose.pose.orientation.z, initialpose_amcl.pose.pose.orientation.z-.15, initialpose_amcl.pose.pose.orientation.z+.15) &&
                IsInBounds(amcl_pose.pose.pose.orientation.w, initialpose_amcl.pose.pose.orientation.w-.15, initialpose_amcl.pose.pose.orientation.w+.15);
        ros::WallDuration(1.0).sleep();
        matchCounter++;
      }
      if( match )
      {
        ROS_INFO("AMCL reports initialpose obtained!");
      }
      else
      {
        ROS_WARN("Timed out waiting for AMCL to report initialpose!");
      }
    }

    /*  Destructor: 
        Delete the pointers for both Navigation and Manipulation.
    */
    ~HuskyArm()
    {
      delete move_group_ptr_;
      delete move_base_ptr_;
    }

    /*  TransformPoint: 
        Transform the input point to its coordinates in the new target frame.
    */
    void TransformPoint(geometry_msgs::PoseStamped *in_point, std::string target_frame)
    {
      tf::StampedTransform transform;

      // Look up the transform...
      try
      {
        transform_listener.waitForTransform(target_frame, in_point->header.frame_id, ros::Time(0), ros::Duration(10.0) );
        transform_listener.lookupTransform(target_frame, in_point->header.frame_id, ros::Time(0), transform);
      }
      catch (tf::TransformException ex)
      {
        ROS_ERROR("Transform Error: %s", ex.what());
        return;
      }

      // Create holders for XYZ and Quaternion...
      tf::Vector3 tf_point(in_point->pose.position.x, in_point->pose.position.y, in_point->pose.position.z);
      tf::Quaternion tf_quat( in_point->pose.orientation.x, in_point->pose.orientation.y, in_point->pose.orientation.z, in_point->pose.orientation.w  );

      // Perform the transform
      tf_point = transform * tf_point;
      tf_quat = transform * tf_quat;

      // Copy the components back to in_point.
      in_point->pose.position.x = tf_point.x();
      in_point->pose.position.y = tf_point.y();
      in_point->pose.position.z = tf_point.z();
      in_point->pose.orientation.x = tf_quat.x();
      in_point->pose.orientation.y = tf_quat.y();
      in_point->pose.orientation.z = tf_quat.z();
      in_point->pose.orientation.w = tf_quat.w();
      in_point->header.frame_id = target_frame;
    }

    /*  getDrywallGraspPoint: 
        Return a point near the base of the drywall panel to perform the grasp.
    */
    void getDrywallGraspPoint(geometry_msgs::PoseStamped *graspPoint, std::string drywallName)
    {
      gazebo_msgs::GetModelState getModelState;
      getModelState.request.model_name = drywallName.c_str();

      if (getModelStateClient.call(getModelState))
      {
          // Set the graspPoint pose to the response from Get Model State
          graspPoint->pose = getModelState.response.pose;

          // Force these coordinates as being in the map frame.
          graspPoint->header.frame_id = "map";

          // Force the end-effector to face straight down.
          graspPoint->pose.orientation.x = 0;
          graspPoint->pose.orientation.y = -1;
          graspPoint->pose.orientation.z = 0;
          graspPoint->pose.orientation.w = 0;

         // Add small z-coordinate standoff distance for flat drywall
          graspPoint->pose.position.z += OBJECT_STANDOFF_TRANS_Z;

         // Add small y-coordinate  distance to grasph at lower point on drywall panel
          graspPoint->pose.position.y += OBJECT_STANDOFF_TRANS_Y;

          // Transform this point to the Husky's base_link frame (where all grasps are referenced.)
          TransformPoint(graspPoint, "base_link");
      }
      else{
          ROS_ERROR("Failed to query ROS service for drywall - grasp point invalid.");
      }
    }

    /*  STOW
        Initialize the robot arm to a stowed configuration.
        Husky should not move.
    */
    void stow()
    {
      // Create a new plan variable
      moveit::planning_interface::MoveGroupInterface::Plan my_plan_arm;
      
      // Flush the PoseTargets now.
      move_group_ptr_->clearPoseTargets();

      // Set the Joints to the stow positions
      move_group_ptr_->setJointValueTarget(move_group_ptr_->getNamedTargetValues("stow"));

      bool success = (move_group_ptr_->plan(my_plan_arm) == moveit::planning_interface::MoveItErrorCode::SUCCESS);

      if( success ){
        move_group_ptr_->move();
        ROS_INFO("Arm Stowed: SUCCESS");
      }
      else{
        ROS_ERROR("Arm Stowed: FAILURE"); 
      }
    }

    /*  SET GRASP
        Sets internal flags to have the object follow the arm just beyond the end effector, see jointStatesCallback
    */
    void setGrasp(std::string objectName)
    {
      isGrasping = true;
      graspObj = objectName;
      move_group_ptr_->attachObject( objectName.c_str() );
    }

    /*  UNSET GRASP
        Unsets internal flags and the object should be allowed to drop with Gazebo physics.
    */
    void unsetGrasp(std::string objectName)
    {
      isGrasping = false;
      graspObj = "";
      move_group_ptr_->detachObject( objectName.c_str() );
    }

    /*  REMOVE drywall from STACK 
        Removes the drywall stack from the planner's view of the world.
    */
    void removeStack()
    {
      ROS_INFO("Removing drywall stack from the world...");
      auto stack_it = std::find(planning_object_ids.begin(), planning_object_ids.end(), "drywall_stack");

      if ( stack_it != planning_object_ids.end())
      { 
        // Create string vector for JUST the drywall stack name
        std::vector<std::string> drywall_removal;
        std::string stack_name = *stack_it;

        ROS_INFO("Here is the name of the drywall stack found: %s", stack_name.c_str() );
        // Add the drywall stack's name
        drywall_removal.push_back(*stack_it);

        // Remove the drywall stack listed in the original vector of id's
        planning_object_ids.erase(stack_it);

        // Remove the drywall stack from the collision objects in the world
        planning_scene_interface_ptr->removeCollisionObjects(drywall_removal);
      }
    }
    
    /*  GO TO LOADING ZONE
        Arm remains stowed.
        Husky moves to the loading zone.
    */
    void goToLoadZone()
    {
      // Announce move to loading zone
      ROS_INFO("Moving to loading zone...");

      // Tag the latest time.
      loadZone.target_pose.header.stamp = ros::Time::now();

      // Set the goal as the loading zone
      move_base_ptr_->sendGoal(loadZone);

      // Wait for arrival
      move_base_ptr_->waitForResult();

      // Check if arrived and report.
      if(move_base_ptr_->getState() == actionlib::SimpleClientGoalState::SUCCEEDED)
        ROS_INFO("Arrived at loading zone.");
      else
        ROS_ERROR("Failed to arrive at loading zone.");
    }

    /*  GO TO HUSKY POSE
        Arm remains stowed.
        Husky moves to the goal point.
    */
    void goToHuskyPose(double x_in, double y_in, double yaw_in)
    {
      move_base_msgs::MoveBaseGoal goalPoint;

      goalPoint.target_pose.header.frame_id = "map";

      // Set x and y coordinates for a clear space, away from the drywall stack
      goalPoint.target_pose.pose.position.x = x_in;
      goalPoint.target_pose.pose.position.y = y_in;

      // Set the tf2 quaternion message with RPY.
      tf2::Quaternion quat_tf;

      // Face away from drywall stack
      quat_tf.setRPY(0.000, 0.000, yaw_in);

      // Create the quaternion message from the tf2 msg.
      geometry_msgs::Quaternion quat_msg = tf2::toMsg(quat_tf);

      // Set the orientation of the goal pose.
      goalPoint.target_pose.pose.orientation = quat_msg;

      // Announce move to loading zone
      ROS_INFO("Moving to goal...");

      // Tag the latest time.
      goalPoint.target_pose.header.stamp = ros::Time::now();

      // Set the goal as the loading zone
      move_base_ptr_->sendGoal(goalPoint);

      // Wait for arrival
      move_base_ptr_->waitForResult();

      // Convert to RPY
      tf::Quaternion q(goalPoint.target_pose.pose.orientation.x, goalPoint.target_pose.pose.orientation.y, 
        goalPoint.target_pose.pose.orientation.z, goalPoint.target_pose.pose.orientation.w);
      double roll=0, pitch=0, yaw=0;
      tf::Matrix3x3(q).getRPY(roll, pitch, yaw);

      // Check if arrived and report.
      if(move_base_ptr_->getState() == actionlib::SimpleClientGoalState::SUCCEEDED)
      {
        ROS_INFO("Arrived at goal: x= %f, y= %f, yaw= %f.", goalPoint.target_pose.pose.position.x, goalPoint.target_pose.pose.position.y, yaw);
      }

      else
      {
        ROS_ERROR("Failed to arrive at goal: x= %f, y= %f, yaw= %f.", goalPoint.target_pose.pose.position.x, goalPoint.target_pose.pose.position.y, yaw);
      }
    }

    /* GO TO ARM POSE
     * Helper function that sets the arm to the preconfigured pose based on input poseName.
     */
    void goToArmPose(std::string poseName)
    {
        ROS_INFO("Now going to arm pose...");
        double jointTolerance = move_group_ptr_->getGoalJointTolerance();
        // ROS_INFO("Get joint tolerance for pose on entry: %f", jointTolerance);

        move_group_ptr_->setGoalTolerance(0.2);
        // ROS_INFO("Set goal tolerance for pose: 0.2");

        jointTolerance = move_group_ptr_->getGoalJointTolerance();
        // ROS_INFO("Get joint tolerance for pose on exit: %f", jointTolerance);
  
        jointTolerance = move_group_ptr_->getGoalPositionTolerance();
        // ROS_INFO("Get position goal tolerance for pose on exit: %f", jointTolerance);

        move_group_ptr_->setStartStateToCurrentState();

        // Set the Joints to the lift positions
        move_group_ptr_->setJointValueTarget(move_group_ptr_->getNamedTargetValues(poseName.c_str()));
        // ROS_INFO("Set JointValueTarget...");

        moveit::planning_interface::MoveGroupInterface::Plan my_plan_arm;

        bool success = (move_group_ptr_->plan(my_plan_arm) == moveit::planning_interface::MoveItErrorCode::SUCCESS);
        // ROS_INFO("Made a plan...");

        if( success ){
          move_group_ptr_->execute(my_plan_arm);
          ROS_INFO("GO TO ARM POSE SUCCESS: %s", poseName.c_str() );
        }
        else{
          ROS_ERROR("GO TO ARM POSE FAILURE: %s", poseName.c_str() );
        }
    }

    /* PICK UP drywall from STACK
     * Modified from MoveIt Pick-and-Place Tutorial:
     * http://docs.ros.org/en/melodic/api/moveit_tutorials/html/doc/pick_place/pick_place_tutorial.html
     */
    void pickupStack(int drywallNum )
    {
      // Add collision objects for planning.
      this->addPlanningObjects(drywallNum);
      
      // Spawn a new drywall panel to grasp.
      std::string drywallName = "drywall_panel" + std::to_string(drywallNum);
      spawnDrywall(drywallNum, getModelStateClient, spawnModelClient);

      bool success = false;
      int tryCounter = 0;

      // Try up to five times to find a grasp plan.
      while( !success && tryCounter < 5 )
      {
        // Determine the point on the drywall to grasp.
        geometry_msgs::PoseStamped graspPoint;

        getDrywallGraspPoint(&graspPoint, drywallName);

        // Check if the grasp point was found in robot reference frame
        if( graspPoint.header.frame_id != "base_link" )
        {
          // Drywall not found, print error and return
          ROS_ERROR("DryWall NOT found: %s", drywallName.c_str() );
          return;
        }

        // Drywall found, proceed.
        ROS_INFO("DryWall found! %s", drywallName.c_str() );

        // Convert to RPY as found here: https://answers.ros.org/question/50113/transform-quaternion/
        tf::Quaternion q(graspPoint.pose.orientation.x, graspPoint.pose.orientation.y, 
          graspPoint.pose.orientation.z, graspPoint.pose.orientation.w);
        double roll=0, pitch=0, yaw=0;
        tf::Matrix3x3(q).getRPY(roll, pitch, yaw);

        // Pick up the board
        ROS_INFO("Picking up drywall...");

        // Give ROS a second
        ros::WallDuration(1.0).sleep();

        // Go to the lift position first to allow the planner less distance to plan.
        goToArmPose("lift");
       
        // Convert the target from the map frame frame to the base_link frame.
        geometry_msgs::PoseStamped target_pose1;
       
        // Flush the PoseTargets now.
        move_group_ptr_->clearPoseTarget();
        move_group_ptr_->clearPoseTargets();

        // Set new PoseTarget along with other planning parameters
        move_group_ptr_->setGoalTolerance(0.2);
        move_group_ptr_->setStartStateToCurrentState();
        move_group_ptr_->setPoseTarget(graspPoint);
        move_group_ptr_->setNumPlanningAttempts(50);
        move_group_ptr_->setPlanningTime(15.0);
        move_group_ptr_->setPlannerId("RRTstar");
        move_group_ptr_->setWorkspace( -50, -50, -50, 50, 50, 50);
        move_group_ptr_->allowLooking( true );

        // Create a new plan variable
        moveit::planning_interface::MoveGroupInterface::Plan my_plan_arm;

        // Make a plan for the motion
        moveit::planning_interface::MoveItErrorCode planError = move_group_ptr_->plan(my_plan_arm);
        
        // Check if plan was a success
        success = (planError == moveit::planning_interface::MoveItErrorCode::SUCCESS);
        
        // Time to settle
        ros::WallDuration(1.0).sleep();

        if( success ){
          ROS_INFO("Plan Grasp: SUCCESS");
          move_group_ptr_->execute(my_plan_arm);

          ROS_INFO("Now attach to arm...");

          setGrasp(drywallName);

          ROS_INFO("Attached object to arm");

          // Flush the PoseTargets now.
          move_group_ptr_->clearPoseTarget();
          move_group_ptr_->clearPoseTargets();

          // ROS_INFO("Waiting before lift...");
          ros::WallDuration(5.0).sleep();

          // Raise the board up by going to the lift pose.
          goToArmPose("lift");
        }
        else{
          ROS_ERROR("Position arm to grasp: FAILURE"); 
        }

        // Increment try counter.
        ROS_INFO("Plan grasp attempt: %d", tryCounter);
        tryCounter++;
      }
    }

    /* Add Objects for Planning the Pick
     * Modified from MoveIt Pick-and-Place Tutorial:
     * http://docs.ros.org/en/melodic/api/moveit_tutorials/html/doc/pick_place/pick_place_tutorial.html
     */
    void addPlanningObjects(int drywallNum)
    {
      // Mock Environment
      // ^^^^^^^^^^^^^^^^^^^^
      // Create vector to hold 2 collision objects.
      std::vector<moveit_msgs::CollisionObject> collision_objects;
      collision_objects.resize(2);

      // Add the pallet where the drywall panel will originally be kept.
      collision_objects[0].id = "drywall_stack";
      planning_object_ids.push_back("drywall_stack");

      // collision_objects[0].header.frame_id = "ur_arm_base_link";
      collision_objects[0].header.frame_id = move_group_ptr_->getPlanningFrame();

      /* Define the primitive and its dimensions. */
      collision_objects[0].primitives.resize(1);
      collision_objects[0].primitives[0].type = collision_objects[0].primitives[0].BOX;
      collision_objects[0].primitives[0].dimensions.resize(3);

      // Drywall stack dimensions are: 1.2192 1.2192  0.4318
      collision_objects[0].primitives[0].dimensions[0] = 1.2192;
      collision_objects[0].primitives[0].dimensions[1] = 1.2192;
      collision_objects[0].primitives[0].dimensions[2] = 0.4318;

      geometry_msgs::PoseStamped objectPoint;
      objectPoint.pose.position.x = -1.000;
      objectPoint.pose.position.y = -5.000;
      objectPoint.pose.position.z = 0.2159;
      objectPoint.pose.orientation.x = 0.0;
      objectPoint.pose.orientation.y = 0.0;
      objectPoint.pose.orientation.z = 0.0;
      objectPoint.pose.orientation.w = 1.0;
      objectPoint.header.frame_id = "map";
      TransformPoint(&objectPoint, "base_link");

      /* Define the pose of the stack: -1 -5 0.1524 */
      collision_objects[0].primitive_poses.resize(1);
      collision_objects[0].primitive_poses[0].position.x = objectPoint.pose.position.x;
      collision_objects[0].primitive_poses[0].position.y = objectPoint.pose.position.y;
      collision_objects[0].primitive_poses[0].position.z = objectPoint.pose.position.z;

      // Add the stack
      collision_objects[0].operation = collision_objects[0].ADD;

      // Add the drywall panel for grasping.
      collision_objects[1].id = "drywall_panel" + std::to_string(drywallNum);
      planning_object_ids.push_back("drywall_panel");
      collision_objects[1].header.frame_id = move_group_ptr_->getPlanningFrame();

      /* Define the primitive and its dimensions. */
      collision_objects[1].primitives.resize(1);
      collision_objects[1].primitives[0].type = collision_objects[1].primitives[0].BOX;
      collision_objects[1].primitives[0].dimensions.resize(3);

      // Drywall panel dimensions are: 1.2192 1.2192  0.0217
      collision_objects[1].primitives[0].dimensions[0] = 1.2192;
      collision_objects[1].primitives[0].dimensions[1] = 1.2192;
      collision_objects[1].primitives[0].dimensions[2] = 0.0217;

      // On top of the stack, .4318 + .0217/2 = 0.44265.
      objectPoint.pose.position.x = -1.000;
      objectPoint.pose.position.y = -5.000;
      objectPoint.pose.position.z = 0.44265;
      objectPoint.pose.orientation.x = 0.0;
      objectPoint.pose.orientation.y = 0.0;
      objectPoint.pose.orientation.z = 0.0;
      objectPoint.pose.orientation.w = 1.0;
      objectPoint.header.frame_id = "map";
      TransformPoint(&objectPoint, "base_link");

      /* Define the pose of the drywall panel: -1 -5  0.43815 */
      collision_objects[1].primitive_poses.resize(1);
      collision_objects[1].primitive_poses[0].position.x = objectPoint.pose.position.x;
      collision_objects[1].primitive_poses[0].position.y = objectPoint.pose.position.y;
      collision_objects[1].primitive_poses[0].position.z = objectPoint.pose.position.z;

      // Add the panel
      collision_objects[1].operation = collision_objects[1].ADD;

      // Set the two objects as part of the scene.
      planning_scene_interface_ptr->applyCollisionObjects(collision_objects);
    }

    /* REMOVE OBJECTS for PLANNING the pick
     * Modified from MoveIt Pick-and-Place Tutorial:
     * http://docs.ros.org/en/melodic/api/moveit_tutorials/html/doc/pick_place/pick_place_tutorial.html
     */
    void removePlanningObjects()
    {
      ROS_INFO("Removing objects from the world");
      if( planning_object_ids.size() > 0 ){
        ROS_INFO("Removed objects:");
        for( int i=0; i<planning_object_ids.size(); i++){
          ROS_INFO("%s", planning_object_ids[i].c_str());
        }

        planning_scene_interface_ptr->removeCollisionObjects(planning_object_ids);
      }
    }

    /* JOINT STATES CALLBACK
     * Modified from alternative Pick and Place Tutorial:
     * https://erdalpekel.de/?p=178
     * Callback updates frequently as the robot moves. On each update, if "grasping," the callbackk will calculate
     * a point small distance away from the last link in the arm. The grasp point of the drywall is transformed to
     * the point a small distance away...effectively holding the drywall panel at the end of the arm as if it were
     * grasped by a tool in the Gazebo environment.
     */
    void jointStatesCallback(const sensor_msgs::JointState &joint_states_current)
    {
      // Get the kinematic state from the move_group's robot model.
      robot_state::RobotStatePtr kinematic_state = robot_state::RobotStatePtr(new robot_state::RobotState(move_group_ptr_->getRobotModel()));

      // Only attach if grasping
      if( isGrasping )
      {
        // Copy the state of the joints to a kinematic state variable
        jointStateToRobotState(joint_states_current, *kinematic_state);

        // Set end effector as the end of the arm as there isn't any tool there to perform the grasp
        const Eigen::Affine3d &end_effector_state = kinematic_state->getGlobalLinkTransform("ur_arm_tool0");

        // Set an offset from the ur_arm_tool0
        Eigen::Affine3d tmp_transform(Eigen::Translation3d(Eigen::Vector3d(0.0, -OBJECT_STANDOFF_TRANS_Y, OBJECT_STANDOFF_TRANS_Z)));

        // Transform (translate) a point off the end effector
        Eigen::Affine3d newState = end_effector_state * tmp_transform;
        
        // Create a new geometry message for the pose of this new point.
        geometry_msgs::Pose pose;
        pose.position.x = newState.translation().x();
        pose.position.y = newState.translation().y();
        pose.position.z = newState.translation().z();

        Eigen::Quaterniond quat(newState.rotation());

        pose.orientation.w = quat.w();
        pose.orientation.x = quat.x();
        pose.orientation.y = quat.y();
        pose.orientation.z = quat.z();

        // Convert to RPY and roll by pi/2
        tf::Quaternion q(pose.orientation.x, pose.orientation.y, pose.orientation.z, pose.orientation.w);
        double roll=0, pitch=0, yaw=0;
        tf::Matrix3x3(q).getRPY(roll, pitch, yaw);
        roll += M_PI_2;

        // Convert back to quaternion
        tf2::Quaternion quat_tf;
        quat_tf.setRPY(roll, pitch, yaw);
        pose.orientation.x = quat_tf.x();
        pose.orientation.y = quat_tf.y();
        pose.orientation.z = quat_tf.z();
        pose.orientation.w = quat_tf.w();

        // Publish the model state for this model, the drywall panel
        gazebo_msgs::ModelState model_state;

        // Provide the name, pose, and reference frame for the drywall panel
        model_state.model_name = graspObj;
        model_state.pose = pose;
        model_state.reference_frame = std::string("base_link");

        // Publish on state publisher
        gazebo_model_state_pub.publish(model_state);
      }
    }

    /* AMCL POSE CALLBACK
     * The amcl_pose variable is set with the pose that is passed in at the callback.
     * This variable is compared in a loop at the init to determine the initial pose of the Husky when it is spawned
     * in Gazebo.
     */
    void amclPoseCallback(const geometry_msgs::PoseWithCovarianceStamped &pose_in)
    {
      amcl_pose = pose_in;
    }
};

/*  MAIN
    The main() function will: 1) create the ROS node, 2) create an instance of HuskyArm, 3) direct
    the HuskyArm to the loading zone, 4) pick up the drywall panel from the stack, 5) remove the
    drywall stack from planning, 6) transition the drywall to the carry pose, 7) go to a destination
    goal.
*/
int main(int argc, char** argv)
{
  ros::init(argc, argv, "husky_ur5_move_pick_place");
  ros::NodeHandle nh;
  ros::AsyncSpinner spinner(1);
  spinner.start();

  ros::WallDuration(1.0).sleep();

  // Create the Husky + UR5 arm combination, with nodehandle for its own publish/subscribers
  HuskyArm huskyArm(nh);

  // Direct the Husky to go to the loading zone in front of the drywall stack.
  huskyArm.goToLoadZone();

  // Wait a bit for ROS to settle, then pickup the drywall panel from the stack.
  ros::WallDuration(1.0).sleep();
  huskyArm.pickupStack( 0 );

  // Wait a bit for ROS to settle, then remove the stack from planning.
  ROS_INFO("REMOVE THE DRYWALL STACK FROM PLANNING.");
  ros::WallDuration(1.0).sleep();
  huskyArm.removeStack();

  // goToHuskyPose will issue a pose message for the input (X, Y, YAW) destination and add the timestamp.
  ROS_INFO("DRIVING TO CARRY POSITION");
  huskyArm.goToHuskyPose(-2.0, -2.0, M_PI);

  // Now that the Husky is in a clearing, flip to the carry pose
  ROS_INFO("SHIFT DRYWALL TO CARRY POSE");
  huskyArm.goToArmPose("carry");

  // Drive somewhere else in the map.
  ROS_INFO("DRIVE TO NEW GOAL");
  huskyArm.goToHuskyPose(5.0, 5.0, -M_PI_2);

  /*  PLACE
      With Husky stationary, perform a place().
  */
  // place(group);

  ros::waitForShutdown();
  huskyArm.removePlanningObjects();
  return 0;
}
