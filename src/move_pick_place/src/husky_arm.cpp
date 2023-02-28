/*********************************************************************
* Name:         move_pick_place.cpp
* Description:  Class definition for HuskyArm to navigate, grasp, and
*               perform other functions for a Husky with UR5 arm
*               attached.
* Author:       William Turner
* Derived:      Base code for grasping from MoveIt's 
*               pick_place_tutorial.cpp for ROS Melodic.
*               Additional arm code from husky_manipulation tutorial.
*********************************************************************/
#include <move_pick_place/move_pick_place.h>
#include <move_pick_place/husky_arm.h>

/*  Constructor: 
    Initialize the robot arm and stow it.
*/
HuskyArm::HuskyArm(ros::NodeHandle node_handle)
{
  // Initialize the global variables for the callback so that it does not manipulate objects.
  isGrasping = false;
  graspObj = "";

  // Store the node handle.
  ROS_INFO("NODE HANDLE");
  _nh = node_handle;

  ROS_INFO("ROS SERVICES");
  // These services are for the programatic creation of drywall panels
  getModelStateClient = _nh.serviceClient<gazebo_msgs::GetModelState>("/gazebo/get_model_state");
  setModelStateClient = _nh.serviceClient<gazebo_msgs::SetModelState>("/gazebo/set_model_state");
  spawnModelClient = _nh.serviceClient<gazebo_msgs::SpawnModel>("/gazebo/spawn_sdf_model");
  deleteModelClient = _nh.serviceClient<gazebo_msgs::DeleteModel>("/gazebo/delete_model");
  attachMaterialClient = _nh.serviceClient<gazebo_ros_link_attacher::Attach>("/link_attacher_node/attach");
  detachMaterialClient = _nh.serviceClient<gazebo_ros_link_attacher::Attach>("/link_attacher_node/detach");
  getLinkStateClient = _nh.serviceClient<gazebo_msgs::GetLinkState>("/gazebo/get_link_state");

  ROS_INFO("ROS PUB/SUB");
  initialpose_pub = _nh.advertise<geometry_msgs::PoseWithCovarianceStamped>("/initialpose", 1000);
  amclpose_sub = _nh.subscribe("/amcl_pose", 1, &HuskyArm::amclPoseCallback, this);
  linkStatesSub = _nh.subscribe("/gazebo/link_states", 1, &HuskyArm::linkStatesCallback, this);
  huskyVelController_pub = _nh.advertise<geometry_msgs::Twist>("/husky_velocity_controller/cmd_vel", 1);
  armControllerPub = _nh.advertise<trajectory_msgs::JointTrajectory>("/arm_position_controller/command",1);

  // Initialize MoveIt interfaces.
  ROS_INFO("PLANNING SCENE PTR");
  planning_scene_interface_ptr = new moveit::planning_interface::PlanningSceneInterface();

  ROS_INFO("PLANNING SCENE MOVE GROUP INTERFACE");
  move_group_ptr_ = new moveit::planning_interface::MoveGroupInterface("ur5_arm");

  ROS_INFO("MOVE GROUP PTR SET PLANNING TIME");
  move_group_ptr_->setPlanningTime(60.0);

  ROS_INFO("MOVE GROUP PTR START STATE MONITOR");
  move_group_ptr_->startStateMonitor();

  ROS_INFO("MOVE GROUP PTR SET WORKSPACE");
  move_group_ptr_->setWorkspace( -50, -50, 0, 50, 50, 50);

  ROS_INFO("Loaded robot model with end effector: %s", move_group_ptr_->getEndEffectorLink().c_str());

  // Started State Monitor, wait a moment to let ROS settle.
  ros::WallDuration(1.0).sleep();

  // Stow the arm on creation.
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
  gazebo_model_state_pub = _nh.advertise<gazebo_msgs::ModelState>("/gazebo/set_model_state", 1);
  joint_states_sub = _nh.subscribe("/joint_states", 1, &HuskyArm::jointStatesCallback, this);

  // Clear the planning_object_ids vector.
  _planning_object_ids.clear();

  // Get the parameters for the initial location of the Husky
  double initialposeX, initialposeY, initialposeZ, initialposeYaw;
  if(_nh.getParam("/initialposeX", initialposeX)){}else{initialposeX=0.0;};
  if(_nh.getParam("/initialposeY", initialposeY)){}else{initialposeY=0.0;};
  if(_nh.getParam("/initialposeZ", initialposeZ)){}else{initialposeZ=0.0;};
  if(_nh.getParam("/initialposeYaw", initialposeYaw)){}else{initialposeYaw=-1.5707;};

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

  // Set variables to track if AMCL's reported location matches with sent location, and counter.
  bool match = false;
  int matchCounter = 0;

  // Wait until pose is obtained.
  while( !match && matchCounter < 10 )
  {
    // Check if the initialpose_amcl set is within bounds of the amcl_pose reported.
    match = IsInBounds(amcl_pose.pose.pose.position.x, initialpose_amcl.pose.pose.position.x-.25, initialpose_amcl.pose.pose.position.x+.25) &&
            IsInBounds(amcl_pose.pose.pose.position.y, initialpose_amcl.pose.pose.position.y-.25, initialpose_amcl.pose.pose.position.y+.25) &&
            IsInBounds(amcl_pose.pose.pose.orientation.x, initialpose_amcl.pose.pose.orientation.x-.15, initialpose_amcl.pose.pose.orientation.x+.15) &&
            IsInBounds(amcl_pose.pose.pose.orientation.y, initialpose_amcl.pose.pose.orientation.y-.15, initialpose_amcl.pose.pose.orientation.y+.15) &&
            IsInBounds(amcl_pose.pose.pose.orientation.z, initialpose_amcl.pose.pose.orientation.z-.15, initialpose_amcl.pose.pose.orientation.z+.15) &&
            IsInBounds(amcl_pose.pose.pose.orientation.w, initialpose_amcl.pose.pose.orientation.w-.15, initialpose_amcl.pose.pose.orientation.w+.15);

    // Wait a moment for AMCL to update in Gazebo simulation.
    ros::WallDuration(1.0).sleep();

    // Increment counter
    matchCounter++;
  }
  if( match )
  {
    // Report AMCL is now initialized.
    ROS_INFO("AMCL reports initialpose obtained!");
  }
  else
  {
    // Warn that AMCL is not initialized.
    ROS_WARN("Timed out waiting for AMCL to report initialpose!");
  }

  // Set front load flag and end effector offset for drywall settings as default.
  _isFrontLoad = true;
  _endEffectorOffset = 0.06;

  debugCounter = 0;    
}

/*  Destructor: 
    Delete the pointers for both Navigation and Manipulation.
*/
HuskyArm::~HuskyArm()
{
  ROS_INFO("ENTERED DESTRUCTOR");
  // Clean up the class resources.
  delete move_group_ptr_;
  ROS_INFO("DELETED move_group_ptr_");
  delete move_base_ptr_;
  ROS_INFO("DELETED move_base_ptr_ AND EXITING...");
}

/*  TransformPoint: 
    Transform the input point to its coordinates in the new target frame.
*/
void HuskyArm::TransformPoint(geometry_msgs::PoseStamped *in_point, std::string target_frame)
{
  // Create variable to hold transform.
  tf::StampedTransform transform;

  // Look up the transform...
  try
  {
    // Wait for transform to become available.
    transform_listener.waitForTransform(target_frame, in_point->header.frame_id, ros::Time(0), ros::Duration(10.0) );

    // Get trainsform as it should be available.
    transform_listener.lookupTransform(target_frame, in_point->header.frame_id, ros::Time(0), transform);
  }
  catch (tf::TransformException ex)
  {
    // Report error and exit
    ROS_ERROR("Transform Error: %s", ex.what());
    return;
  }

  // Create holders for XYZ and Quaternion...
  tf::Vector3 tf_point(in_point->pose.position.x, in_point->pose.position.y, in_point->pose.position.z);
  tf::Quaternion tf_quat( in_point->pose.orientation.x, in_point->pose.orientation.y, 
    in_point->pose.orientation.z, in_point->pose.orientation.w  );

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

/*  getMaterialGraspPoint: 
    Return a point near the base of the material to perform the grasp.
*/
void HuskyArm::getMaterialGraspPoint(geometry_msgs::PoseStamped *graspPoint, std::string materialName)
{
  gazebo_msgs::GetModelState getModelState;
  getModelState.request.model_name = materialName.c_str();

  if (getModelStateClient.call(getModelState))
  {
    // Set the graspPoint pose to the response from Get Model State
    graspPoint->pose = getModelState.response.pose;

    // Quaternion to RPY
    tf::Quaternion q(graspPoint->pose.orientation.x, graspPoint->pose.orientation.y, 
      graspPoint->pose.orientation.z, graspPoint->pose.orientation.w);
    double roll=0, pitch=0, yaw=0;
    tf::Matrix3x3(q).getRPY(roll, pitch, yaw);

    ROS_INFO("GET GRASP POINT: GET MODEL, XYZ= %f, %f, %f", graspPoint->pose.position.x, graspPoint->pose.position.y, graspPoint->pose.position.z);
    ROS_INFO("GET GRASP POINT: GET MODEL, RPY= %f, %f, %f", roll, pitch, yaw);

    // Force these coordinates as being in the map frame.
    graspPoint->header.frame_id = "map";

    // Add offset distance from EE to material (along z-axis).
    graspPoint->pose.position.z += _zOffset;
    ROS_INFO("GET GRASP POINT: pose.position.z += _zOffset= %f", graspPoint->pose.position.z);

    // Add small offset to grasp at lower point on material
    if( _isFrontLoad ){
      // If front loading, then adjust y-coordinate
      graspPoint->pose.position.y += OBJECT_STANDOFF_TRANS_Y;
      ROS_INFO("GET GRASP POINT: from the front!");
    }
    else{
      // If side loading, then adjust x-coordinate
      graspPoint->pose.position.x -= OBJECT_STANDOFF_TRANS_Y;
      ROS_INFO("GET GRASP POINT: from the side!");
    }

    // Force the end-effector to face straight down.
    graspPoint->pose.orientation.x = 0;
    graspPoint->pose.orientation.y = -1;
    graspPoint->pose.orientation.z = 0;
    graspPoint->pose.orientation.w = 0;

    // Convert back to quaternion
    tf2::Quaternion quat_tf;
    quat_tf.setRPY(roll, pitch, yaw);

    ROS_INFO("GET GRASP POINT: PRE-TRANFORM XYZ= %f, %f, %f", 
      graspPoint->pose.position.x, graspPoint->pose.position.y, graspPoint->pose.position.z);
    q = tf::Quaternion(graspPoint->pose.orientation.x, graspPoint->pose.orientation.y, 
      graspPoint->pose.orientation.z, graspPoint->pose.orientation.w);
    tf::Matrix3x3(q).getRPY(roll, pitch, yaw);
    ROS_INFO("GET GRASP POINT: PRE-TRANFORM RPY: %f, %f, %f", roll, pitch, yaw);

    // Transform this point in map frame to the Husky's base_link frame (where all grasps are referenced.)
    TransformPoint(graspPoint, "base_link");

    q = tf::Quaternion(graspPoint->pose.orientation.x, graspPoint->pose.orientation.y, 
      graspPoint->pose.orientation.z, graspPoint->pose.orientation.w);
    tf::Matrix3x3(q).getRPY(roll, pitch, yaw);
    ROS_INFO("GET GRASP POINT: POST-TRANFORM XYZ: %f, %f, %f", 
      graspPoint->pose.position.x, graspPoint->pose.position.y, graspPoint->pose.position.z);
    ROS_INFO("GET GRASP POINT: POST-TRANFORM RPY: %f, %f, %f", roll, pitch, yaw);
  }
  else{
    ROS_ERROR("Failed to query ROS service for drywall - grasp point invalid.");
  }
}

/*  STOW
    Initialize the robot arm to a stowed configuration.
    Husky should not move.
*/
void HuskyArm::stow()
{
  // Create a new plan variable
  moveit::planning_interface::MoveGroupInterface::Plan my_plan_arm;
  
  // Flush the PoseTargets now.
  move_group_ptr_->clearPoseTargets();

  // Set the Joints to the stow positions
  move_group_ptr_->setJointValueTarget(move_group_ptr_->getNamedTargetValues("stow"));

  // Create a plan with the move_group.
  bool success = (move_group_ptr_->plan(my_plan_arm) == moveit::planning_interface::MoveItErrorCode::SUCCESS);

  if( success ){
    // Execute the plan made.
    move_group_ptr_->execute(my_plan_arm);

    // Report success.
    ROS_INFO("Arm Stowed: SUCCESS");
  }
  else{
    // Report failure.
    ROS_ERROR("Arm Stowed: FAILURE"); 
  }
}

/*  SET GRASP
    Sets internal flags to have the object follow the arm just beyond the end effector, see jointStatesCallback
*/
void HuskyArm::setGrasp(std::string objectName)
{
  // Set the name of the object for the joint_states callback to acquire the Gazebo model.
  graspObj = objectName;

  // Set the global to true, joint_states callback will now simulate the grasp.
  isGrasping = true;

  // Attach object to the move_group so that MoveIt's planner uses object in plans.
  move_group_ptr_->attachObject( objectName.c_str() );
}

/*  UNSET GRASP
    Unsets internal flags and the object should be allowed to drop with Gazebo physics.
*/
void HuskyArm::unsetGrasp(std::string objectName)
{
  // Set global to false, joint_states callback should stop setting the drywall pose
  isGrasping = false;

  // Clear the name of the grasp object so that joint_states callback can no longer grasp
  graspObj = "";

  // Detach object from the move_group so that MoveIt's planner no longer uses drywall in plans.
  move_group_ptr_->detachObject( objectName.c_str() );
}

/*  REMOVE drywall from STACK 
    Removes the drywall stack from the planner's view of the world.
*/
void HuskyArm::removeStack(std::string stackType)
{
  ROS_INFO("Removing drywall stack from the world...");
  std::string stackName = stackType + "_stack";

  // Use iterator to find the drywall stack in planning_object_ids vector
  auto stack_it = std::find(_planning_object_ids.begin(), _planning_object_ids.end(), stackName);

  // Check if not found
  if ( stack_it != _planning_object_ids.end())
  { 
    // Create string vector for JUST the drywall stack name
    std::vector<std::string> drywall_removal;
    std::string stackName = *stack_it;

    ROS_INFO("Here is the name of the stack found: %s", stackName.c_str() );
    // Add the drywall stack's name
    drywall_removal.push_back(*stack_it);

    // Remove the drywall stack listed in the original vector of id's
    _planning_object_ids.erase(stack_it);

    // Remove the drywall stack from the collision objects in the world
    planning_scene_interface_ptr->removeCollisionObjects(drywall_removal);
  }
}
  
/*  GO TO LOADING ZONE
    Arm remains stowed.
    Husky moves to the loading zone.
*/
void HuskyArm::goToLoadZone()
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
  {
    // Report success.
    ROS_INFO("Arrived at loading zone.");
  }
  else
  {
    // Report failure.
    ROS_ERROR("Failed to arrive at loading zone.");
  }
}

/*  GO TO HUSKY POSE
    Arm remains stowed.
    Husky moves to the goal point.
*/
int HuskyArm::goToHuskyPose(double x_in, double y_in, double yaw_in)
{
  // Re-Initialize the AMCL pose with Gazebo coordinates.
  initializeAmclFromGazebo();

  // Create a goal variabel for move base
  move_base_msgs::MoveBaseGoal goalPoint;

  // Reference frame is the map frame.
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
  ROS_INFO("goToHuskyPose: Moving to goal...");

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
    // Report success.
    ROS_INFO("goToHuskyPose: Arrived at goal: x= %f, y= %f, yaw= %f.", 
      goalPoint.target_pose.pose.position.x, goalPoint.target_pose.pose.position.y, yaw);
    
      q = tf::Quaternion(amcl_pose.pose.pose.orientation.x, amcl_pose.pose.pose.orientation.y, 
        amcl_pose.pose.pose.orientation.z, amcl_pose.pose.pose.orientation.w);
      tf::Matrix3x3(q).getRPY(roll, pitch, yaw);

    ROS_INFO("goToHuskyPose: Arrived at AMCL goal: x= %f, y= %f, yaw= %f.", 
      amcl_pose.pose.pose.position.x, amcl_pose.pose.pose.position.y, yaw);

    return 0;
  }
  else
  {
    // Report failure.
    ROS_ERROR("goToHuskyPose: Failed to arrive at goal: x= %f, y= %f, yaw= %f. Back up and try again.", 
      goalPoint.target_pose.pose.position.x, goalPoint.target_pose.pose.position.y, yaw);

    retreat(10);
    ros::WallDuration(3.0).sleep();

    // Set the goal as the loading zone
    move_base_ptr_->sendGoal(goalPoint);

    // Wait for arrival
    move_base_ptr_->waitForResult();

    // Check if arrived and report.
    if(move_base_ptr_->getState() == actionlib::SimpleClientGoalState::SUCCEEDED)
    {
      // Report success.
      ROS_INFO("goToHuskyPose: Arrived at goal: x= %f, y= %f, yaw= %f.", 
        goalPoint.target_pose.pose.position.x, goalPoint.target_pose.pose.position.y, yaw);
      
        q = tf::Quaternion(amcl_pose.pose.pose.orientation.x, amcl_pose.pose.pose.orientation.y, 
          amcl_pose.pose.pose.orientation.z, amcl_pose.pose.pose.orientation.w);
        tf::Matrix3x3(q).getRPY(roll, pitch, yaw);

      ROS_INFO("goToHuskyPose: Arrived at AMCL goal: x= %f, y= %f, yaw= %f.", 
        amcl_pose.pose.pose.position.x, amcl_pose.pose.pose.position.y, yaw);

      return 0;
    }
    else
    { 
      ROS_ERROR("goToHuskyPose: Failed to arrive at goal for second try, report failure, exit goToHuskyPose.");   
      return 1;
    }
  }
}

/* GO TO ARM POSE
 * Helper function that sets the arm to the preconfigured pose based on input poseName.
 */
void HuskyArm::goToArmPose(std::string poseName, bool isGrasp, std::string materialName, std::string stackType, int stackNum, int materialNum)
{
    ROS_INFO("Now going to arm pose, %s.", poseName.c_str());

    // Increase the tolerance of what's acceptable for a goal (makes it easier on the planner)
    move_group_ptr_->setGoalTolerance(0.075); //0.2
    /*  Various tests of other tolerances:
    // move_group_ptr_->setGoalOrientationTolerance(.01);
    // move_group_ptr_->setGoalTolerance(0.1);
    // move_group_ptr_->setGoalJointTolerance(0.001);
    */

    // Explicitly set the start state, but this should be been done by MoveIt without this line. 
    move_group_ptr_->setStartStateToCurrentState();

    // Set the Joints to the lift positions
    move_group_ptr_->setJointValueTarget(move_group_ptr_->getNamedTargetValues(poseName.c_str()));

    // Create plan variable
    moveit::planning_interface::MoveGroupInterface::Plan my_plan_arm;

    // Add objects for planning the pose movement.
    addPoseObjects(stackType, stackNum, materialNum);  // This adds a floor, create own addPoseObjects if addPlaceObjects changes.

    // Make a plan and check if the planning was successful
    bool success = (move_group_ptr_->plan(my_plan_arm) == moveit::planning_interface::MoveItErrorCode::SUCCESS);

    // Check if the plan was a success
    if( success ){
      // Execute the plan
      move_group_ptr_->execute(my_plan_arm);
      ROS_INFO("GO TO ARM POSE: EXECUTED %s", poseName.c_str() );

      // Give ROS a second, in case execute takes some time.
      ros::WallDuration(1.0).sleep();

      // Report success.
      ROS_INFO("GO TO ARM POSE: EXECUTION SUCCESS, %s", poseName.c_str() );
    }
    else{
      // Else report an error.
      ROS_ERROR("GO TO ARM POSE: PLAN FAILURE, %s", poseName.c_str() );
    }
    // Remove just the asphalt plane that was added for planning above.
    removePlanningObject("asphalt_plane");
}

/* PICK UP material from STACK
 * Modified from MoveIt Pick-and-Place Tutorial:
 * http://docs.ros.org/en/melodic/api/moveit_tutorials/html/doc/pick_place/pick_place_tutorial.html
 */
bool HuskyArm::pickFromStack(int materialNum, std::string stackType, int stackNum )
{
  std::string materialName;

  // Determine new material to grasp.
  if( stackType == "drywall" )
  {
    // materialName= "drywall_panel" + std::to_string(materialNum);
    materialName= "drywall" + std::to_string(materialNum);
  }
  else
  {
    materialName= "frame" + std::to_string(materialNum);
  }

  anchorHusky();

  // Add collision objects for planning.
  this->addPickObjects(stackType, stackNum, materialNum);
  
  // Reset tracking variables for success of planner and number of tries to plan.
  bool success = false;
  int tryCounter = 0;

  // Try up to five times to find a grasp plan.
  while( !success && tryCounter < 5 )
  {
    // Determine the point on the drywall to grasp.
    geometry_msgs::PoseStamped graspPoint;

    getMaterialGraspPoint(&graspPoint, materialName);
    ROS_INFO("PLANNING...%s GRASP POINT AT XYZ: %f, %f, %f",
      stackType.c_str(), graspPoint.pose.position.x, graspPoint.pose.position.y, graspPoint.pose.position.z);

    // Check if the grasp point was found in robot reference frame
    if( graspPoint.header.frame_id != "base_link" )
    {
      // Material not found, print error and return
      ROS_ERROR("Material NOT found: %s", materialName.c_str() );
      detachHusky();
      return false;
    }

    // Material found, proceed.
    ROS_INFO("Material found! %s", materialName.c_str() );

    // Announce picking up the material
    ROS_INFO("Next to pick up material...");

    // Go to the lift position first to allow the planner less distance to plan.
    if( stackType == "drywall" )
    {
      ROS_INFO("Lift above drywall stack!");
      goToArmPose("twisted_lift", false, "", stackType, stackNum, materialNum );
    }
    else
    {
      ROS_INFO("Lift above frame stack!");
      goToArmPose("twisted_lift", false, "", stackType, stackNum, materialNum );
    }
        
    // Flush the PoseTargets now.
    move_group_ptr_->clearPoseTarget();
    move_group_ptr_->clearPoseTargets();

    // Set new PoseTarget along with other planning parameters
    move_group_ptr_->setGoalTolerance(0.075); //0.075
    move_group_ptr_->setGoalOrientationTolerance(.01);

    move_group_ptr_->setStartStateToCurrentState();
    move_group_ptr_->setPoseTarget(graspPoint);
    move_group_ptr_->setNumPlanningAttempts(50);
    move_group_ptr_->setPlanningTime(15.0);       //15
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

      ROS_INFO("Now attach %s to arm...", materialName.c_str());
    
      // Set the name of the object for the joint_states callback to acquire the Gazebo model.
      graspObj = materialName;

      // Flush the PoseTargets now.
      move_group_ptr_->clearPoseTarget();
      move_group_ptr_->clearPoseTargets();


      // The arm should be attached in the world now (Gazebo)
      isGrasping = true;

      // Give the jointStatesCallback time to attach the material
      ROS_INFO("PICK FROM STACK: Sleep 5s before adding back planning objects.");
      ros::WallDuration(1.0).sleep();

      // Now attach in Moveit
      move_group_ptr_->attachObject( materialName.c_str() );

      // Raise the board up by going to the lift pose.
      if( stackType == "drywall" )
      {
        ROS_INFO("Lift drywall with grasp!");
        goToArmPose("twisted_lift", true, materialName, stackType, stackNum, materialNum );
      }
      else
      {
        ROS_INFO("Lift frame with grasp!");
        goToArmPose("twisted_lift", true, materialName, stackType, stackNum, materialNum );
      }
    }
    else{
      // Report error.
      ROS_ERROR("Position arm to grasp: FAILURE"); 
    }

    // Increment try counter.
    ROS_INFO("Plan grasp attempt: %d", tryCounter);
    tryCounter++;
  }

  detachHusky();
  return success;
}
/* Find Collision Object
 * Checks the names of the internal vector and returns TRUE if the collision object
 *  is in the array...meaning it is already included in the plan.
 */
bool HuskyArm::findCollisionObject(std::string objectName)
{
  std::vector<std::string>::iterator it;

  it = find (_planning_object_ids.begin(), _planning_object_ids.end(), objectName);
  if (it != _planning_object_ids.end())
  {
    ROS_INFO("findCollisionObject: %s FOUND in planner!", objectName.c_str() );
    return true;
  }
  else
  {
    ROS_INFO("findCollisionObject: %s NOT FOUND in planner!", objectName.c_str() );
    return false;
  }
}
/* Add Objects for Planning the Place
 * Modified from MoveIt Pick-and-Place Tutorial:
 * http://docs.ros.org/en/melodic/api/moveit_tutorials/html/doc/pick_place/pick_place_tutorial.html
 */
void HuskyArm::addPlaceObjects()
{
  // Create vector to hold 1 collision object: the asphalt plane.
  // _collision_objects.resize(1);

  if( !findCollisionObject("asphalt_plane") )
  {
    /* This is the internal vector for defining the collision objects:
     std::vector<moveit_msgs::CollisionObject> _collision_objects;
     */
    moveit_msgs::CollisionObject collisionObject;

    // The asphalt plane was not found, add it to the string vector.
    _planning_object_ids.push_back("asphalt_plane");

    // Add the asphalt plane
    collisionObject.id = "asphalt_plane";
    collisionObject.header.frame_id = move_group_ptr_->getPlanningFrame();

    /* Define the primitive and its dimensions. */
    collisionObject.primitives.resize(1);
    collisionObject.primitives[0].type = collisionObject.primitives[0].BOX;
    collisionObject.primitives[0].dimensions.resize(3);

    // Asphalt plane dimensions are: 20 20 0.1
    collisionObject.primitives[0].dimensions[0] = 20;
    collisionObject.primitives[0].dimensions[1] = 20;
    collisionObject.primitives[0].dimensions[2] = 0.1;

    // Create pose for asphalt plane
    geometry_msgs::PoseStamped objectPoint;

    // Asphalt plane sits at origin.
    objectPoint.pose.position.x = 0.0;
    objectPoint.pose.position.y = 0.0;
    // Give the z-coordinate a bump up so the arm has some margin for movements near the plane.
    // objectPoint.pose.orientation.z = 0.025;
    // The planner appears to add additional movements when using the margin.
    // Use zero for place() as the starting pose is 'prop' which makes for a simple push forward.
    objectPoint.pose.position.z = 0.0;
    objectPoint.pose.orientation.x = 0.0;
    objectPoint.pose.orientation.y = 0.0;
    objectPoint.pose.orientation.z = 0.0;
    objectPoint.pose.orientation.w = 1.0;
    objectPoint.header.frame_id = "map";

    // Transform the point from the map frame defined above to the base_link for Moveit

    TransformPoint(&objectPoint, "base_link");

    /* Define the pose of the asphalt plane */
    collisionObject.primitive_poses.resize(1);
    collisionObject.primitive_poses[0].position = objectPoint.pose.position;
    collisionObject.primitive_poses[0].orientation = objectPoint.pose.orientation;

    // Identify this object as one to add.
    collisionObject.operation = collisionObject.ADD;

    // Push back to vector of all collision objects.
    _collision_objects.push_back(collisionObject);

    // Set the object as part of the scene.
    planning_scene_interface_ptr->applyCollisionObject(collisionObject);
  }

}

/* Add Objects for Planning the Pose
 * Modified from MoveIt Pick-and-Place Tutorial:
 * http://docs.ros.org/en/melodic/api/moveit_tutorials/html/doc/pick_place/pick_place_tutorial.html
 */
void HuskyArm::addPoseObjects(std::string stackType, int stackNum, int materialNum)
{
  // Create vector to hold 1 collision object: the asphalt plane.
  std::vector<moveit_msgs::CollisionObject> collision_objects;
  collision_objects.resize(1);

  // Add the pallet where the asphalt plane will originally be kept.
  collision_objects[0].id = "asphalt_plane";
  _planning_object_ids.push_back("asphalt_plane");
  
  // collision_objects[0].header.frame_id = "base_link";
  collision_objects[0].header.frame_id = move_group_ptr_->getPlanningFrame();

  /* Define the primitive and its dimensions. */
  collision_objects[0].primitives.resize(1);
  collision_objects[0].primitives[0].type = collision_objects[0].primitives[0].BOX;
  collision_objects[0].primitives[0].dimensions.resize(3);

  // Asphalt plane dimensions are: 20 20 0.1
  collision_objects[0].primitives[0].dimensions[0] = 20;
  collision_objects[0].primitives[0].dimensions[1] = 20;
  collision_objects[0].primitives[0].dimensions[2] = 0.1;

  // Create pose for asphalt plane
  geometry_msgs::PoseStamped objectPoint;

  // Asphalt plane sits at origin.
  objectPoint.pose.position.x = 0.0;
  objectPoint.pose.position.y = 0.0;
  objectPoint.pose.position.z = 0.0;
  objectPoint.pose.orientation.x = 0.0;
  objectPoint.pose.orientation.y = 0.0;
  // Give the z-coordinate a bump up so the arm has some margin for movements near the plane.
  objectPoint.pose.orientation.z = 0.025;
  objectPoint.pose.orientation.w = 1.0;
  objectPoint.header.frame_id = "map";

  // Transform the point from the map frame defined above to the base_link for Moveit
  TransformPoint(&objectPoint, "base_link");

  /* Define the pose of the asphalt plane */
  collision_objects[0].primitive_poses.resize(1);
  collision_objects[0].primitive_poses[0].position = objectPoint.pose.position;
  collision_objects[0].primitive_poses[0].orientation = objectPoint.pose.orientation;

  // Add the asphalt plane
  collision_objects[0].operation = collision_objects[0].ADD;

  // Set the object(s) as part of the scene.
  planning_scene_interface_ptr->applyCollisionObjects(collision_objects);
}

/* Add Objects for Planning the Pick
 * Modified from MoveIt Pick-and-Place Tutorial:
 * http://docs.ros.org/en/melodic/api/moveit_tutorials/html/doc/pick_place/pick_place_tutorial.html
 */
void HuskyArm::addPickObjects(std::string stackType, int stackNum, int materialNum)
{
  // Create vector to hold 2 collision objects.
  std::vector<moveit_msgs::CollisionObject> collision_objects;
  collision_objects.resize(2);

  // NOW STACK, get values on param server
  std::string baseParamString = "/material/stack/" + stackType + "/" + std::to_string(stackNum) + "/";

  // Add the pallet where the drywall panel will originally be kept.
  collision_objects[0].id = stackType + "_stack";
  _planning_object_ids.push_back(stackType + "_stack");

  // collision_objects[0].header.frame_id = "base_link";
  collision_objects[0].header.frame_id = move_group_ptr_->getPlanningFrame();

  /* Define the primitive and its dimensions. */
  collision_objects[0].primitives.resize(1);
  collision_objects[0].primitives[0].type = collision_objects[0].primitives[0].BOX;
  collision_objects[0].primitives[0].dimensions.resize(3);

  // Get stack length from param server
  if( _nh.getParam( (baseParamString + "box/x").c_str(), collision_objects[0].primitives[0].dimensions[0]) )
  {
    ROS_INFO("FOUND stack LENGTH=%f on param server", collision_objects[0].primitives[0].dimensions[0]);
  }
  else
  {
    collision_objects[0].primitives[0].dimensions[0]=0.0;
    ROS_WARN("NOT FOUND stack LENGTH on param server");
  }

  // Get stack width from param server
  if(_nh.getParam( (baseParamString + "box/y").c_str(), collision_objects[0].primitives[0].dimensions[1]))
  {
    ROS_INFO("FOUND stack WIDTH= %f on param server", collision_objects[0].primitives[0].dimensions[1]);
  }
  else
  {
    collision_objects[0].primitives[0].dimensions[1]=0.0;
    ROS_WARN("NOT FOUND stack WIDTH on param server");
  }

  // Get stack height from param server
  if(_nh.getParam( (baseParamString + "box/z").c_str(), collision_objects[0].primitives[0].dimensions[2]))
  {
    ROS_INFO("FOUND stack HEIGHT= %f on param server", collision_objects[0].primitives[0].dimensions[2]);
  }
  else
  {
    collision_objects[0].primitives[0].dimensions[2]=0.0;
    ROS_WARN("NOT FOUND stack HEIGHT on param server");
  }

  // Create a pose for the stack
  geometry_msgs::PoseStamped materialPose;

  // Get stack x position from param server
  if(_nh.getParam( (baseParamString + "position/x").c_str(), materialPose.pose.position.x))
  {
    ROS_INFO("FOUND stack X POSITION= %f on param server", materialPose.pose.position.x);
  }
  else
  {
    materialPose.pose.position.x=0.0;
    ROS_WARN("NOT FOUND stack X POSITION on param server");
  }

  // Get stack y position from param server
  if(_nh.getParam( (baseParamString + "position/y").c_str(), materialPose.pose.position.y))
  {
    ROS_INFO("FOUND stack Y POSITION= %f on param server", materialPose.pose.position.y);
  }
  else
  {
    materialPose.pose.position.y=0.0;
    ROS_WARN("NOT FOUND stack Y POSITION on param server");
  }

  // Get stack z position from param server
  if(_nh.getParam( (baseParamString + "position/z").c_str(), materialPose.pose.position.z))
  {
    ROS_INFO("FOUND stack Z POSITION= %f on param server", materialPose.pose.position.z);
  }
  else
  {
    materialPose.pose.position.z=0.0;
    ROS_WARN("NOT FOUND stack Z POSITION on param server");
  }

  // Get x orientation from param server
  if(_nh.getParam( (baseParamString + "orientation/x").c_str(), materialPose.pose.orientation.x))
  {
    ROS_INFO("FOUND stack orientation X= %f on param server", materialPose.pose.orientation.x);
  }
  else
  {
    materialPose.pose.orientation.x=0.0;
    ROS_WARN("NOT FOUND stack orientation X on param server");
  }
  // Get y orientation from param server
  if(_nh.getParam( (baseParamString + "orientation/y").c_str(), materialPose.pose.orientation.y))
  {
    ROS_INFO("FOUND stack orientation Y= %f on param server", materialPose.pose.orientation.y);
  }
  else
  {
    materialPose.pose.orientation.y=0.0;
    ROS_WARN("NOT FOUND stack orientation Y on param server");
  }
  // Get z orientation from param server
  if(_nh.getParam( (baseParamString + "orientation/z").c_str(), materialPose.pose.orientation.z))
  {
    ROS_INFO("FOUND stack orientation Z= %f on param server", materialPose.pose.orientation.z);
  }
  else
  {
    materialPose.pose.orientation.z=0.0;
    ROS_WARN("NOT FOUND stack orientation Z on param server");
  }
  // Get w orientation from param server
  if(_nh.getParam( (baseParamString + "orientation/w").c_str(), materialPose.pose.orientation.w))
  {
    ROS_INFO("FOUND stack orientation W= %f on param server", materialPose.pose.orientation.w);
  }
  else
  {
    materialPose.pose.orientation.w=0.0;
    ROS_WARN("NOT FOUND stack orientation W on param server");
  }
  
  // Set the stack's pose as in the map frame
  materialPose.header.frame_id = "map";

  // Remove the .05 for the asphalt plane
  // materialPose.pose.position.z -= .05;

  ROS_INFO("ADD PICK %s STACK: PRE_TRANSFORM POSITION AT XYZ: %f, %f, %f", 
    stackType.c_str(), materialPose.pose.position.x, 
    materialPose.pose.position.y, materialPose.pose.position.z);

  tf::Quaternion q(materialPose.pose.orientation.x, materialPose.pose.orientation.y, 
    materialPose.pose.orientation.z, materialPose.pose.orientation.w);
  double roll=0, pitch=0, yaw=0;
  tf::Matrix3x3(q).getRPY(roll, pitch, yaw);
  ROS_INFO("ADD PICK %s STACK: PRE_TRANSFORM ORIENTATION AT RPY: %f, %f, %f", 
    stackType.c_str(), roll, pitch, yaw);

  // Transform the Stack's pose to the base_link frame for planning.
  TransformPoint(&materialPose, "base_link");

  /* Set the pose of the stack */
  collision_objects[0].primitive_poses.resize(1);
  collision_objects[0].primitive_poses[0].position = materialPose.pose.position;
  collision_objects[0].primitive_poses[0].orientation = materialPose.pose.orientation;

  // Add the stack
  collision_objects[0].operation = collision_objects[0].ADD;
  ROS_INFO("ADD PICK %s STACK: POST_TRANSFORM POSITION AT XYZ: %f, %f, %f", 
    stackType.c_str(), materialPose.pose.position.x, 
    materialPose.pose.position.y, materialPose.pose.position.z);

  q = tf::Quaternion(materialPose.pose.orientation.x, materialPose.pose.orientation.y, 
    materialPose.pose.orientation.z, materialPose.pose.orientation.w);
  roll=0, pitch=0, yaw=0;
  tf::Matrix3x3(q).getRPY(roll, pitch, yaw);
  ROS_INFO("ADD PICK %s STACK: POST_TRANSFORM ORIENTATION AT RPY: %f, %f, %f", 
    stackType.c_str(), roll, pitch, yaw);

  // NOW MATERIAL
  std::string materialName;
  if( stackType == "drywall" )
  {
    // materialName = stackType + "_panel" + std::to_string(materialNum);
    materialName = stackType + std::to_string(materialNum);
  }
  else
  {
    materialName = stackType + std::to_string(materialNum);
  }

  // Get the material pose from the simulation via GetModelState.
  geometry_msgs::Pose materialCurrentPose = getModelPose(materialName);

  if( isnan(materialCurrentPose.position.x) )
  {
    ROS_ERROR("addPickObjects ERROR: Pose not found! NaN!");
    return;
  }
  // Add the material for grasping.
  collision_objects[1].id = materialName;
  _planning_object_ids.push_back(materialName);
  collision_objects[1].header.frame_id = move_group_ptr_->getPlanningFrame();

  /* Define the primitive and its dimensions. */
  collision_objects[1].primitives.resize(1);
  collision_objects[1].primitives[0].type = collision_objects[1].primitives[0].BOX;
  collision_objects[1].primitives[0].dimensions.resize(3);

  // Drywall panel dimensions are: 1.2192 1.2192  0.0217
  baseParamString = "/material/" + stackType + "/";

  // Get material length from param server
  if(_nh.getParam( (baseParamString + "box/x").c_str(), collision_objects[1].primitives[0].dimensions[0]))
  {
    ROS_INFO("FOUND material LENGTH= %f on param server", collision_objects[1].primitives[0].dimensions[0]);
  }
  else
  {
    collision_objects[1].primitives[0].dimensions[0]=0.0;
    ROS_WARN("NOT FOUND material LENGTH on param server");
  }

  // Get material width from param server
  if(_nh.getParam( (baseParamString + "box/y").c_str(), collision_objects[1].primitives[0].dimensions[1]))
  {
    ROS_INFO("FOUND material WIDTH= %f on param server", collision_objects[1].primitives[0].dimensions[1]);
  }
  else
  {
    collision_objects[1].primitives[0].dimensions[1]=0.0;
    ROS_WARN("NOT FOUND material WIDTH on param server");
  }

  // Get material height from param server
  if(_nh.getParam( (baseParamString + "box/z").c_str(), collision_objects[1].primitives[0].dimensions[2]))
  {
    ROS_INFO("FOUND material HEIGHT= %f on param server", collision_objects[1].primitives[0].dimensions[2]);
  }
  else
  {
    collision_objects[1].primitives[0].dimensions[2]=0.0;
    ROS_WARN("NOT FOUND material HEIGHT on param server");
  }

  // Copy the current position and orientation of the object into the point to be transformed.
  materialPose.pose.position = materialCurrentPose.position;

  // Remove the .05 for the asphalt plane
  // materialPose.pose.position.z -= .05;

  materialPose.pose.orientation = materialCurrentPose.orientation;

  ROS_INFO("ADD PICK MATERIAL: PRE_TRANSFORM, %s, POSITION AT XYZ: %f, %f, %f", 
    stackType.c_str(), materialPose.pose.position.x, 
    materialPose.pose.position.y, materialPose.pose.position.z);

  q = tf::Quaternion(materialPose.pose.orientation.x, materialPose.pose.orientation.y, 
    materialPose.pose.orientation.z, materialPose.pose.orientation.w);
  roll=0, pitch=0, yaw=0;
  tf::Matrix3x3(q).getRPY(roll, pitch, yaw);
  ROS_INFO("ADD PICK MATERIAL: PRE_TRANSFORM, %s, ORIENTATION AT RPY: %f, %f, %f", 
    stackType.c_str(), roll, pitch, yaw);

  // The pose is in the map frame
  materialPose.header.frame_id = "map";

  // Transform to Husky's base_link frame
  TransformPoint(&materialPose, "base_link");

  ROS_INFO("ADD PICK MATERIAL: POST_TRANSFORM, %s, POSITION AT XYZ: %f, %f, %f", 
    stackType.c_str(), materialPose.pose.position.x, 
    materialPose.pose.position.y, materialPose.pose.position.z);

  q = tf::Quaternion(materialPose.pose.orientation.x, materialPose.pose.orientation.y, 
    materialPose.pose.orientation.z, materialPose.pose.orientation.w);
  roll=0, pitch=0, yaw=0;
  tf::Matrix3x3(q).getRPY(roll, pitch, yaw);
  ROS_INFO("ADD PICK MATERIAL: POST_TRANSFORM, %s, ORIENTATION AT RPY: %f, %f, %f", 
    stackType.c_str(), roll, pitch, yaw);

  /* Define the pose of the material: -1 -5  0.43815 */
  collision_objects[1].primitive_poses.resize(1);
  collision_objects[1].primitive_poses[0].position = materialPose.pose.position;
  collision_objects[1].primitive_poses[0].orientation = materialPose.pose.orientation;

  // Add the panel
  collision_objects[1].operation = collision_objects[1].ADD;

  // Set the two objects as part of the scene.
  planning_scene_interface_ptr->applyCollisionObjects(collision_objects);
}

/* REMOVE OBJECTS for PLANNING
 * Modified from MoveIt Pick-and-Place Tutorial:
 * http://docs.ros.org/en/melodic/api/moveit_tutorials/html/doc/pick_place/pick_place_tutorial.html
 */
void HuskyArm::removePlanningObjects()
{
  ROS_INFO("removePlanningObjects: Entered.");
  if( _planning_object_ids.size() > 0 ){
    ROS_INFO("removePlanningObjects: Will remove objects:");
    for( std::size_t i=0; i<_planning_object_ids.size(); i++){
      ROS_INFO("%s", _planning_object_ids[i].c_str());
    }

    /*  Documentation for "removeCollisionObjects" revealed that it runs asynchronously.
        It suggests using applyCollisionObjects for an immediate result.
        So let's pass an empy vector to applyCollisionObjects instead.
    */
    // planning_scene_interface_ptr->removeCollisionObjects(_planning_object_ids);
    _planning_object_ids.clear();
    _collision_objects.clear();

    bool success = planning_scene_interface_ptr->applyCollisionObjects(_collision_objects);
    if( success )
    {
      ROS_INFO("removePlanningObjects: Used empty vector to remove collision objects!!!");
    }
    else
    {
      ROS_WARN("removePlanningObjects: Empty vector to remove collision objects did not work...");
    }
  }
  else
  {
    ROS_WARN("removePlanningObjects: No planning objects found!");
  }
}

/* REMOVE OBJECT for PLANNING
 * Modified from MoveIt Pick-and-Place Tutorial:
 * http://docs.ros.org/en/melodic/api/moveit_tutorials/html/doc/pick_place/pick_place_tutorial.html
 */
void HuskyArm::removePlanningObject(std::string objectName)
{
  std::vector<std::string> objectsToRemove;
  objectsToRemove.push_back(objectName);

  ROS_INFO("Removing object, %s, from the world planning", objectName.c_str());
  planning_scene_interface_ptr->removeCollisionObjects(objectsToRemove);

  std::vector<std::string>::iterator it;
  it = find (_planning_object_ids.begin(), _planning_object_ids.end(), objectName);
  if (it != _planning_object_ids.end())
    ROS_INFO_STREAM("Removed element, " << objectName << ", found in _planning_object_ids: " << *it);
  else
    ROS_INFO_STREAM("Removed element, " << objectName << ", not found in _planning_object_ids");

}
/* JOINT STATES CALLBACK
 * Modified from alternative Pick and Place Tutorial:
 * https://erdalpekel.de/?p=178
 * Callback updates frequently as the robot moves. On each update, if "grasping," the callbackk will calculate
 * a point small distance away from the last link in the arm. The grasp point of the drywall is transformed to
 * the point a small distance away...effectively holding the drywall panel at the end of the arm as if it were
 * grasped by a tool in the Gazebo environment.
 */
void HuskyArm::jointStatesCallback(const sensor_msgs::JointState &joint_states_current)
{
  // Get the kinematic state from the move_group's robot model.
  robot_state::RobotStatePtr kinematic_state = robot_state::RobotStatePtr(new robot_state::RobotState(move_group_ptr_->getRobotModel()));
  _joint_states_current = joint_states_current;
  // Only attach if grasping
  if( isGrasping )
  {
    // Copy the state of the joints to a kinematic state variable
    jointStateToRobotState(joint_states_current, *kinematic_state);

    // Set end effector as the end of the arm as there isn't any tool there to perform the grasp
    const Eigen::Affine3d &end_effector_state = kinematic_state->getGlobalLinkTransform("ur_arm_tool0");
    // if( debugCounter%50 == 0 && debugCounter < 1000){
    //   ROS_INFO("JOINT STATE CALLBACK [%d]: EE OFFSET= %f", debugCounter, _endEffectorOffset);
    //   ROS_INFO("JOINT STATE CALLBACK [%d]: PRINTING Affine3d", debugCounter);
    //   std::cout << end_effector_state.matrix() << std::endl;
    // }

    // Temporary transform matrix.
    Eigen::Affine3d tmp_transform;
    Eigen::AngleAxis<double> tmp_rotation;

    // Set an offset from the ur_arm_tool0
    // tmp_transform = Eigen::Affine3d(Eigen::Translation3d(Eigen::Vector3d(0.0, -OBJECT_STANDOFF_TRANS_Y, _endEffectorOffset)));        

    if( _isFrontLoad ){
      // If approaching from the "front", heading is the -y direction, then translate y coordinate
      tmp_transform = Eigen::Affine3d(
                        Eigen::Translation3d(
                          Eigen::Vector3d(0.0, OBJECT_STANDOFF_TRANS_Y, _endEffectorOffset)
                            )
                              );
    }
    else{
      // If approaching from the "side", heading is the +x direction, then translate x coordinate
      tmp_transform = Eigen::Affine3d(
                        Eigen::Translation3d(
                          Eigen::Vector3d(-OBJECT_STANDOFF_TRANS_Y, 0.0, _endEffectorOffset)
                            )
                              );
      // Rotate about z axis for grasp
      tmp_rotation = Eigen::AngleAxis<double>(-M_PI_2, Eigen::Vector3d::UnitZ() );
    }

    // Transform (translation) the XYZ point off the end effector
    Eigen::Affine3d newTranState = end_effector_state * tmp_transform;  

    // Transform (rotation) the RPY of the object from end effector
    Eigen::Affine3d newRotState = end_effector_state * tmp_rotation;

    // The EE is pointed down, whereas the material is face-up, invert the pitch to switch.
    tmp_rotation = Eigen::AngleAxis<double>(-M_PI, Eigen::Vector3d::UnitX() );
    newRotState = newRotState * tmp_rotation;  

    // Create a new geometry message for the pose of this new point.
    geometry_msgs::Pose pose;
    pose.position.x = newTranState.translation().x();
    pose.position.y = newTranState.translation().y();
    pose.position.z = newTranState.translation().z();

    // Set orientation with Eigen quaternion from state rotation.
    Eigen::Quaterniond quat(newRotState.rotation());
    pose.orientation.w = quat.w();
    pose.orientation.x = quat.x();
    pose.orientation.y = quat.y();
    pose.orientation.z = quat.z();

    // Convert to RPY and roll by pi/2
    tf::Quaternion q(pose.orientation.x, pose.orientation.y, pose.orientation.z, pose.orientation.w);
    double roll=0, pitch=0, yaw=0;
    tf::Matrix3x3(q).getRPY(roll, pitch, yaw);

    // // Convert back to quaternion
    // tf2::Quaternion quat_tf;
    // quat_tf.setRPY(roll, pitch, yaw);
    // pose.orientation.x = quat_tf.x();
    // pose.orientation.y = quat_tf.y();
    // pose.orientation.z = quat_tf.z();
    // pose.orientation.w = quat_tf.w();

    // if( debugCounter%50 == 0 && debugCounter < 250 ){
    //   ROS_INFO("JOINT STATE CALLBACK [%d]: x= %f, y= %f, z= %f",debugCounter,pose.position.x,pose.position.y,pose.position.z);
    //   ROS_INFO("JOINT STATE CALLBACK [%d]: roll= %f, pitch= %f, yaw= %f",debugCounter,roll,pitch,yaw);
    // }
    // debugCounter++;

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

void HuskyArm::linkStatesCallback(const gazebo_msgs::LinkStates &linkStates)
{
  if( isGrasping )
  {
    // // ROS_INFO("LINK STATES CB IS GRASPING!");
    // // Store the arrays of the link states message.
    // std::vector<std::string>          linkNames(std::begin(linkStates.name), std::end(linkStates.name));
    // std::vector<geometry_msgs::Pose>  linkPoses(std::begin(linkStates.pose), std::end(linkStates.pose));
    // // std::vector<geometry_msgs::Twist> linkTwists(std::begin(linkStates->twist), std::end(linkStates->twist));

    // int iName = -1;
    // for( size_t i=0; i<linkNames.size(); i++ )
    // {
    //   if( linkNames[i] == "husky::ur_arm_wrist_3_link" )
    //   {
    //     // ROS_INFO("FOUND LINK: %s", linkNames[i].c_str() );
    //     iName = i;
    //     break;
    //   }
    // }

    // if( iName < 0 )
    // {
    //   ROS_WARN("LinkStates Callback: No modelName found!");
    //   return;
    // }

    // // ROS_INFO("LINK STATES CB POINT HOLDER!");
    // // Create holders for XYZ...
    // tf::Vector3 tf_point(
    //   linkPoses.at(iName).position.x,
    //   linkPoses.at(iName).position.y,
    //   linkPoses.at(iName).position.z);

    // // ROS_INFO("LINK STATES CB QUAT HOLDER!");
    // // Create holders for Quaternion...
    // tf::Quaternion tf_quat(
    //   linkPoses.at(iName).orientation.x,
    //   linkPoses.at(iName).orientation.y,
    //   linkPoses.at(iName).orientation.z,
    //   linkPoses.at(iName).orientation.w);
    // // tf::Vector3 tf_point(
    // //   arm_pose.pose.position.x,
    // //   arm_pose.pose.position.y,
    // //   arm_pose.pose.position.z);

    // // // Create holders for Quaternion...
    // // tf::Quaternion tf_quat(
    // //   arm_pose.pose.orientation.x,
    // //   arm_pose.pose.orientation.y,
    // //   arm_pose.pose.orientation.z,
    // //   arm_pose.pose.orientation.w);
    // // ROS_INFO("LINK STATES CB MAKING THE TRANSFORM!");
    // geometry_msgs::Pose newPose;

    // // Perform the transform
    // // ROS_INFO("LINK STATES CALLBACK TRANSFORM DONE!");
    // newPose.position.x = tf_point.x() + _geometryTransform.position.x;
    // newPose.position.y = tf_point.y() + _geometryTransform.position.y;
    // newPose.position.z = tf_point.z() + _geometryTransform.position.z;

    // // Set orientation with initial offsets at setMaterialTransform.
    // newPose.orientation.w = tf_quat.w() + _geometryTransform.orientation.w;
    // newPose.orientation.x = tf_quat.x() + _geometryTransform.orientation.x;
    // newPose.orientation.y = tf_quat.y() + _geometryTransform.orientation.y;
    // newPose.orientation.z = tf_quat.z() + _geometryTransform.orientation.z;
    // // newPose.header.frame_id = "ur_arm_tool0";

    // // // Perform the transform
    // // tf_point = _armMaterialTransform * tf_point;
    // // tf_quat = _armMaterialTransform * tf_quat;
    // // ROS_INFO("LINK STATES CALLBACK TRANSFORM DONE!");

    
    // // newPose.position.x = tf_point.x();
    // // newPose.position.y = tf_point.y();
    // // newPose.position.z = tf_point.z();

    // // // Set orientation with Eigen quaternion from state rotation.
    // // newPose.orientation.w = tf_quat.w();
    // // newPose.orientation.x = tf_quat.x();
    // // newPose.orientation.y = tf_quat.y();
    // // newPose.orientation.z = tf_quat.z();
    // // // newPose.header.frame_id = "ur_arm_tool0";

    // // Publish the model state for the material
    // gazebo_msgs::ModelState model_state;

    // // Provide the name, pose, and reference frame for the material's pose
    // model_state.model_name = graspObj;
    // model_state.pose = newPose;
    // model_state.reference_frame = std::string("map");

    // if( debugCounter < 5 ){
    //   ROS_INFO("LINK STATES CB [%d]: XYZ= %f, %f, %f", debugCounter, newPose.position.x, newPose.position.y, newPose.position.z);

    //   tf::Quaternion q(newPose.orientation.x, newPose.orientation.y, 
    //     newPose.orientation.z, newPose.orientation.w);
    //   double roll=0, pitch=0, yaw=0;
    //   tf::Matrix3x3(q).getRPY(roll, pitch, yaw);
    //   ROS_INFO("LINK STATES CB [%d]: RPY= %f, %f, %f", debugCounter, roll, pitch, yaw);
    //   debugCounter++;
    // }

    // // Publish on state publisher
    // gazebo_model_state_pub.publish(model_state);
  }
}

/* AMCL POSE CALLBACK
 * The amcl_pose variable is set with the pose that is passed in at the callback.
 * This variable is compared in a loop at the init to determine the initial pose of the Husky when it is spawned
 * in Gazebo.
 */
void HuskyArm::amclPoseCallback(const geometry_msgs::PoseWithCovarianceStamped &pose_in)
{
  amcl_pose = pose_in;
}

/*  Arm To Target Pose
  Moves the arm's end effector to the input target pose.
*/
int HuskyArm::armToTargetPose(const geometry_msgs::PoseStamped &target_pose)
{

  bool success = false;
  int tryCounter = 0;

  // Try up to five times to find a grasp plan.
  while( !success && tryCounter < 5 )
  {
    ROS_INFO("Attempting place [%d of 5]", tryCounter+1);

    // Flush the PoseTargets now.
    move_group_ptr_->clearPoseTarget();
    move_group_ptr_->clearPoseTargets();

    // Set new PoseTarget along with other planning parameters
    move_group_ptr_->setGoalOrientationTolerance(0.01);
    move_group_ptr_->setGoalPositionTolerance(0.025);
    move_group_ptr_->setStartStateToCurrentState();
    move_group_ptr_->setPoseTarget(target_pose);
    move_group_ptr_->setNumPlanningAttempts(50);
    move_group_ptr_->setPlanningTime(15.0);
    move_group_ptr_->setPlannerId("RRTstar");
    move_group_ptr_->setWorkspace( -50, -50, -50, 50, 50, 50);
    move_group_ptr_->allowLooking( true );

    // Create a new plan variable
    ROS_INFO("Making plan...");
    moveit::planning_interface::MoveGroupInterface::Plan my_plan_arm;

    // Make a plan for the motion
    moveit::planning_interface::MoveItErrorCode planError = move_group_ptr_->plan(my_plan_arm);
    
    // Check if plan was a success
    success = (planError == moveit::planning_interface::MoveItErrorCode::SUCCESS);

    // If so, execute plan
    if( success ){
      ROS_INFO("Plan Target Pose: SUCCESS");
      ROS_INFO("armToTargetPose(): NEXT LINE IS THE EE POSE BEFORE ARM MOVES!");
      getEEpose();
      move_group_ptr_->execute(my_plan_arm);
    }
    else{
      ROS_INFO("Plan Target Pose: FAILURE");
    }
    tryCounter++;
    // Check if this is the last retry
    if( tryCounter == 4 )
    {
      ROS_INFO("armToTargetPose(): Last Retry, force start state to prop pose.");

      // If the last retry, then perhaps the arm is in an invalid state - reset the joints.
      forceStartState();
    }
  }

  // Time to settle
  ros::WallDuration(1.0).sleep();
  ROS_INFO("armToTargetPose(): NEXT LINE IS THE EE POSE AFTER ARM MOVES!");
  getEEpose();
  if(success) return 0; else return 1;
}

/*  PLACE
  With Husky stationary, place the end effector at the designated input pose.
*/
int HuskyArm::place(geometry_msgs::PoseStamped &materialPose, bool flipApproach)
{
  // Convert destination pose RPY
  tf::Quaternion q(materialPose.pose.orientation.x, materialPose.pose.orientation.y, 
    materialPose.pose.orientation.z, materialPose.pose.orientation.w);
  double roll=0, pitch=0, yaw=0;
  tf::Matrix3x3(q).getRPY(roll, pitch, yaw);

  // The Husky is to orient itself, yaw, for placing the material at the destination.
  double huskyYaw = yaw;

  /*  Notes on orientation.
      The material default yaw=0; for which the Husky must be at PI/2;
      Material = PI/2, Husky=PI; Material=PI, Husky=3PI/2; Material=3PI/2, Husky=0;
  */

  // Set the xy coordinate to include offset distance from the material based on Husky's yaw.
  double x_goal, y_goal;

  // Check if the input argument indicates the planner wants to approach from the other side.
  if( flipApproach )
  {
    // The Husky has to go to the North side of the material.
    huskyYaw += M_PI_2;

    // Rotate the goal pose around the z-axis to account for the reversal.
    yaw += M_PI;

    // Add the offsets to go to the North side.
    x_goal = materialPose.pose.position.x + 
        ( (HUSKY_STANDOFF_DIST + _endEffectorOffset) * cos( huskyYaw ) );
    y_goal = materialPose.pose.position.y + 
        ( (HUSKY_STANDOFF_DIST + _endEffectorOffset) * sin( huskyYaw ) );

    // Now rotate the yaw of the Husky to face the material.
    huskyYaw -= M_PI;
    ROS_INFO("PLACE(): FLIPPED THE HUSKY GOAL POSE, MAP FRAME: XY= %f, %f; YAW= %f",
    x_goal, y_goal, huskyYaw);

    ROS_INFO("PLACE(): FLIPPED THE MATERIAL GOAL POSE, MAP FRAME: XYZ= %f, %f, %f; RPY= %f, %f, %f",
    materialPose.pose.position.x, materialPose.pose.position.y, materialPose.pose.position.z, roll, pitch, yaw);
  }
  else
  {
    // The Husky has to go to the South side of the material.
    huskyYaw -= M_PI_2;

    // Subtract the offsets to go to the South side.
    x_goal = materialPose.pose.position.x + 
        ( (HUSKY_STANDOFF_DIST + _endEffectorOffset) * cos( huskyYaw ) );
    y_goal = materialPose.pose.position.y + 
        ( (HUSKY_STANDOFF_DIST + _endEffectorOffset) * sin( huskyYaw ) );

    // Now rotate the yaw of the Husky to face the material.
    huskyYaw += M_PI;
    ROS_INFO("PLACE(): STRAIGHT HUSKY GOAL POSE, MAP FRAME: XY= %f, %f; YAW= %f",
    x_goal, y_goal, huskyYaw);

    ROS_INFO("PLACE(): STRAIGHT MATERIAL GOAL POSE, MAP FRAME: XYZ= %f, %f, %f; RPY= %f, %f, %f",
    materialPose.pose.position.x, materialPose.pose.position.y, materialPose.pose.position.z, roll, pitch, yaw);
  }

  // Go to the x, y, but face the same heading
  if( goToHuskyPose(x_goal, y_goal, huskyYaw) == 1)
  {
    ROS_WARN("PLACE(): HUSKY FAILED TO ARRIVE AT PLACE POSITION, TRYING AGAIN.");
    // Might be stuck in a wall, try to back up.
    retreat(10);
    ros::WallDuration(2.5).sleep();
    retreat(10);
    ros::WallDuration(2.5).sleep();

    // Try for the goal again.
    if( goToHuskyPose(x_goal, y_goal, huskyYaw) == 1)
    {
      ROS_ERROR("PLACE(): HUSKY FAILED TO ARRIVE AT PLACE POSITION, EXITING.");

      // Return 1 for failure.
      return 1;
    }
  }
  ROS_INFO("PLACE(): HUSKY MOVED TO: XY= %f, %f; Yaw= %f", x_goal, y_goal, huskyYaw );

  // Anchor Husky Immediately.
  anchorHusky();

  // Give ROS a moment to update the Husky's pose
  ros::WallDuration(1.0).sleep();

  // Convert to RPY for ROS_INFO below.
  q = tf::Quaternion(amcl_pose.pose.pose.orientation.x, amcl_pose.pose.pose.orientation.y, 
    amcl_pose.pose.pose.orientation.z, amcl_pose.pose.pose.orientation.w);
  double amclRoll, amclPitch, amclYaw;
  tf::Matrix3x3(q).getRPY(amclRoll, amclPitch, amclYaw);

  ROS_INFO("PLACE(): HUSKY amcl_pose: XY= %f, %f; Yaw= %f", 
    amcl_pose.pose.pose.position.x, amcl_pose.pose.pose.position.y, amclYaw );

  // Set the target pose of the end effector back by the tool offset and some additional backoff, use Husky's orientation.
  materialPose.pose.position.x -= (_endEffectorOffset * cos( amclYaw )) + .05;
  materialPose.pose.position.y -= (_endEffectorOffset * sin( amclYaw )) + .05;

  // Shift for the offset, swapping cos and sin.
  materialPose.pose.position.x += OBJECT_STANDOFF_TRANS_Y * sin( amclYaw );
  materialPose.pose.position.y += OBJECT_STANDOFF_TRANS_Y * cos( amclYaw );

  // Convert to RPY for ROS_INFO below.
  q = tf::Quaternion(materialPose.pose.orientation.x, materialPose.pose.orientation.y, 
    materialPose.pose.orientation.z, materialPose.pose.orientation.w);
  tf::Matrix3x3(q).getRPY(roll, pitch, yaw);

  // Apply the orientation changes between EE and Frame: [ -180, 90, 0 ]
  roll -= M_PI;
  pitch += M_PI_2;
  yaw += 0;

  // Convert back to quaternion for new material pose
  tf2::Quaternion quat_tf;
  quat_tf.setRPY(roll, pitch, yaw);
  materialPose.pose.orientation.x = quat_tf.x();
  materialPose.pose.orientation.y = quat_tf.y();
  materialPose.pose.orientation.z = quat_tf.z();
  materialPose.pose.orientation.w = quat_tf.w();

  ROS_INFO("PLACE(): EE SETTINGS IN MAP FRAME: XYZ= %f, %f, %f; RPY= %f, %f, %f",
      materialPose.pose.position.x, materialPose.pose.position.y, materialPose.pose.position.z, roll, pitch, yaw);

  // Transform this point to the Husky's base_link frame (where all grasps are referenced.)
  TransformPoint(&materialPose, "base_link");
  
  // Convert to RPY for ROS_INFO below.
  q = tf::Quaternion(materialPose.pose.orientation.x, materialPose.pose.orientation.y, 
    materialPose.pose.orientation.z, materialPose.pose.orientation.w);
  tf::Matrix3x3(q).getRPY(roll, pitch, yaw);

  ROS_INFO("PLACE(): EE SETTINGS IN ROBOT FRAME: XYZ= %f, %f, %f; RPY= %f, %f, %f",
      materialPose.pose.position.x, materialPose.pose.position.y, materialPose.pose.position.z, roll, pitch, yaw);

  // Add the objects that Place must navigate, the asphalt plane.
  this->addPlaceObjects();
  
  ROS_INFO("ATTEMPTING TO PLACE AT ROBOT FRAME: XYZ= %f, %f, %f; RPY= %f, %f, %f", materialPose.pose.position.x, 
    materialPose.pose.position.y, materialPose.pose.position.z, roll, pitch, yaw);

  ROS_INFO("PLACE(): NEXT LINE IS THE EE POSE BEFORE armToTargetPose!");
  getEEpose();

  // Attempt to place the arm at the target pose.
  int successInt = armToTargetPose(materialPose);

  if( successInt==0 ){
    ROS_INFO("PLACE(): Reports arm success!");
  }
  else{
    ROS_INFO("PLACE(): Reports arm failed!"); 
  }
  
  // Remove the objects used in planning the place.
  this->removePlanningObjects();

  detachHusky();

  return successInt;
}

/*  GET MODEL POSE
  Return the pose of a model with name as input.
*/
geometry_msgs::Pose HuskyArm::getModelPose(std::string modelName)
{
  // Create a getModelState request
  gazebo_msgs::GetModelState getModelState;

    // Use the name of the model.
  getModelState.request.model_name = modelName.c_str();

  // Call the model state.
  getModelStateClient.call(getModelState);
  if( getModelState.response.success == true )
  {
    ROS_INFO("GET MODEL (%s) POSE: xyz= %f, %f, %f", modelName.c_str(), 
      getModelState.response.pose.position.x, getModelState.response.pose.position.y, getModelState.response.pose.position.z);
  }
  else
  {
    getModelState.response.pose.position.x = std::numeric_limits<double>::quiet_NaN();
    ROS_ERROR("Get model state failed!");
  }
  return getModelState.response.pose;

}

/*  AFFIX DRYWALL
  With Husky stationary, release the drywall from the arm's grasp and set the drywall panel to the input
  pose as a static object. This simulates another tool drilling, or nailing, the drywall to the stud.
*/
void HuskyArm::affixDryWall(geometry_msgs::PoseStamped &materialPose, int materialNum)
{
  // Convert destination pose RPY
  tf::Quaternion q(materialPose.pose.orientation.x, materialPose.pose.orientation.y, 
    materialPose.pose.orientation.z, materialPose.pose.orientation.w);
  double roll=0, pitch=0, yaw=0;
  tf::Matrix3x3(q).getRPY(roll, pitch, yaw);

  ROS_INFO("AFFIX: ATTEMPTING AT MAP: XYZ= %f, %f, %f; RPY= %f, %f, %f", materialPose.pose.position.x, 
    materialPose.pose.position.y, materialPose.pose.position.z, roll, pitch, yaw);

  // Generate messsages to interact with model (get + set state)
  gazebo_msgs::SetModelState setModelState;
  gazebo_msgs::GetModelState getModelState;
  gazebo_msgs::DeleteModel deleteModel;
  gazebo_msgs::SpawnModel spawnModel;
  gazebo_ros_link_attacher::Attach attachMsg;

  std::string materialName;

  // Determine new material to grasp.
  if( _stackType == "drywall" )
  {
    // materialName= "drywall_panel" + std::to_string(materialNum);
    materialName= "drywall" + std::to_string(materialNum);
  }
  else
  {
    materialName= "frame" + std::to_string(materialNum);
  }

  // Get the state of the model before letting go.
  getModelState.request.model_name = materialName.c_str();

  // Call the model state to determine if the drywall panel already exists.
  getModelStateClient.call(getModelState);

  q = tf::Quaternion(getModelState.response.pose.orientation.x, getModelState.response.pose.orientation.y, 
    getModelState.response.pose.orientation.z, getModelState.response.pose.orientation.w);
  tf::Matrix3x3(q).getRPY(roll, pitch, yaw);
  
  ROS_INFO("AFFIX: DRYWALL LET GO AT MAP: XYZ= %f, %f, %f; RPY= %f, %f, %f", getModelState.response.pose.position.x, 
    getModelState.response.pose.position.y, getModelState.response.pose.position.z, roll, pitch, yaw);

  // Use the set model state service to "prop" up the material at the last grasp pose
  setModelState.request.model_state.model_name = materialName.c_str();

  // Set the model state to the desired state.
  setModelState.request.model_state.pose = materialPose.pose;

  // No twist
  geometry_msgs::Twist zeroTwist;
  zeroTwist.linear.x = 0;
  zeroTwist.linear.y = 0;
  zeroTwist.linear.z = 0;
  zeroTwist.angular.x = 0;
  zeroTwist.angular.y = 0;
  zeroTwist.angular.z = 0;
  setModelState.request.model_state.twist = zeroTwist;
  setModelState.request.model_state.reference_frame = "world";

  // These settings attach, or anchor, the material to the ground plane.
  attachMsg.request.model_name_1 = materialName.c_str();
  attachMsg.request.link_name_1 = "link";
  attachMsg.request.model_name_2 = "ground_plane";
  attachMsg.request.link_name_2 = "link";

  // Call attach service to anchor the model in place.
  attachMaterialClient.call(attachMsg);

  // Let go of the current drywall panel
  unsetGrasp(materialName);

  // Reverse the Husky to get away from the material.
  retreat(4);
  ros::WallDuration(.5).sleep();
  retreat(4);
  ros::WallDuration(1.0).sleep();

  // Call detach service to de-anchor the model from the placed() pose.
  detachMaterialClient.call(attachMsg);

  // Call set_model_state service with final pose
  setModelStateClient.call(setModelState);

  // Re-anchor the model in final pose.
  attachMaterialClient.call(attachMsg);  

  // The attached object is likely still in the planner, remove it now that it is detached.
  this->removePlanningObject(materialName);

  ROS_INFO("AFFIX(): DONE!");
}

/*  RETREAT
  Husky briefly runs in reverse.
*/
void HuskyArm::retreat(int magnitude)
{
  // Retreat velocity message of -1*magnitude to reverse the Husky for one instantaneous time step of velocity
  geometry_msgs::Twist retreatVel;
  retreatVel.linear.x = -1.0*magnitude;
  retreatVel.linear.y = 0.0;
  retreatVel.linear.z = 0.0;
  retreatVel.angular.x = 0.0;
  retreatVel.angular.y = 0.0;
  retreatVel.angular.z = 0.0;

  // Publish message
  huskyVelController_pub.publish(retreatVel);
}

void HuskyArm::setFrontLoadFlag( bool isFrontLoad )
{
  _isFrontLoad = isFrontLoad;
}

void HuskyArm::setEndEffectorOffset( double endEffectorOffset )
{
  _endEffectorOffset = endEffectorOffset;

  // Set z-coordinate standoff distance from input
  _zOffset = _endEffectorOffset;

  // Add offset for thickness of material from pose center.
  if( _stackType == "drywall" )
  {
    // Drywall thickness
    _zOffset += (0.0127/2);
  }
  else
  {
    // Frame thickness
    _zOffset += (0.075/2);
  }
  ROS_INFO("SET EE OFFSET: %s, %f", _stackType.c_str(), _zOffset);
}

void HuskyArm::anchorHusky()
{
  ROS_INFO("ANCHOR HUSKY!");
  gazebo_ros_link_attacher::Attach attachMsg;

  attachMsg.request.model_name_1 = "husky";
  attachMsg.request.link_name_1 = "base_link";
  attachMsg.request.model_name_2 = "ground_plane";
  attachMsg.request.link_name_2 = "link";

  // Set the models for attachment.
  attachMaterialClient.call(attachMsg);
}

void HuskyArm::detachHusky()
{
  ROS_INFO("RELEASE HUSKY!");
  gazebo_ros_link_attacher::Attach attachMsg;

  attachMsg.request.model_name_1 = "husky";
  attachMsg.request.link_name_1 = "base_link";
  attachMsg.request.model_name_2 = "ground_plane";
  attachMsg.request.link_name_2 = "link";

  // Set the models for detachment.
  detachMaterialClient.call(attachMsg);
}

void HuskyArm::setStackTarget(std::string stackType, int stackId)
{
  _stackType = stackType;
  _stackId = stackId;
}

/*  ATTACH MATERIAL
    Function to call the gazebo_ros_link_attacher service to attach the material to the ground_plane with a fixed joint.
*/
void HuskyArm::attachMaterial(std::string modelName)
{
  ROS_INFO("ATTACH MATERIAL: %s!", modelName.c_str());
  gazebo_ros_link_attacher::Attach attachMsg;

  attachMsg.request.model_name_1 = "husky";
  attachMsg.request.link_name_1 = "ur_arm_wrist_3_link";
  attachMsg.request.model_name_2 = modelName;
  attachMsg.request.link_name_2 = "link";

  // Set the models for attachment.
  attachMaterialClient.call(attachMsg);
}

/*  SET ARM-MATERIAL TRANSFORM
    Save the transform between the arm and the material.
*/
void HuskyArm::setArmMaterialTransform(std::string materialName)
{
  ROS_INFO("setArmMaterialTransform: TRANFORM BETWEEN ARM AND MATERIAL, %s!", materialName.c_str());
  // Get material's Pose
  gazebo_msgs::GetModelState getModelState;
  getModelState.request.model_name = materialName.c_str();

  gazebo_msgs::GetLinkState getLinkState;
  geometry_msgs::Pose materialPose;

  if (getModelStateClient.call(getModelState))
  {
    materialPose.position.x = getModelState.response.pose.position.x;
    materialPose.position.y = getModelState.response.pose.position.y;
    materialPose.position.z = getModelState.response.pose.position.z;
    materialPose.orientation.x = getModelState.response.pose.orientation.x;
    materialPose.orientation.y = getModelState.response.pose.orientation.y;
    materialPose.orientation.z = getModelState.response.pose.orientation.z;
    materialPose.orientation.w = getModelState.response.pose.orientation.w;

    ROS_INFO("ARM-TO-MATERIAL: materialPose, XYZ= %f, %f, %f", materialPose.position.x, materialPose.position.y, materialPose.position.z);
    tf::Quaternion q(materialPose.orientation.x, materialPose.orientation.y, 
      materialPose.orientation.z, materialPose.orientation.w);
    double roll=0, pitch=0, yaw=0;
    tf::Matrix3x3(q).getRPY(roll, pitch, yaw);

    ROS_INFO("ARM-TO-MATERIAL: materialPose, RPY= %f, %f, %f", roll, pitch, yaw);

    getLinkState.request.link_name = "ur_arm_wrist_3_link";

    if (getLinkStateClient.call(getLinkState))
    {
      ROS_INFO("ARM-TO-MATERIAL: XYZ= %f, %f, %f", getLinkState.response.link_state.pose.position.x,
       getLinkState.response.link_state.pose.position.y, getLinkState.response.link_state.pose.position.z);
      q = tf::Quaternion(getLinkState.response.link_state.pose.orientation.x, getLinkState.response.link_state.pose.orientation.y, 
        getLinkState.response.link_state.pose.orientation.z, getLinkState.response.link_state.pose.orientation.w);
      roll=0, pitch=0, yaw=0;
      tf::Matrix3x3(q).getRPY(roll, pitch, yaw);

      _geometryTransform.position.x = materialPose.position.x - getLinkState.response.link_state.pose.position.x;
      _geometryTransform.position.y = materialPose.position.y - getLinkState.response.link_state.pose.position.y;
      _geometryTransform.position.z = materialPose.position.z - getLinkState.response.link_state.pose.position.z;
      _geometryTransform.orientation.x = materialPose.orientation.x - getLinkState.response.link_state.pose.orientation.x;
      _geometryTransform.orientation.y = materialPose.orientation.y - getLinkState.response.link_state.pose.orientation.y;
      _geometryTransform.orientation.z = materialPose.orientation.z - getLinkState.response.link_state.pose.orientation.z;
      _geometryTransform.orientation.w = materialPose.orientation.w - getLinkState.response.link_state.pose.orientation.w;
      ROS_INFO("setArmMaterialTransform, _geometryTransform IS SET!");
      ROS_INFO("ARM-TO-MATERIAL: XYZ= %f, %f, %f", _geometryTransform.position.x, _geometryTransform.position.y, _geometryTransform.position.z);
      q = tf::Quaternion(_geometryTransform.orientation.x, _geometryTransform.orientation.y, 
        _geometryTransform.orientation.z, _geometryTransform.orientation.w);
      roll=0, pitch=0, yaw=0;
      tf::Matrix3x3(q).getRPY(roll, pitch, yaw);
      ROS_INFO("ARM-TO-MATERIAL: RPY= %f, %f, %f", roll, pitch, yaw);
    }
    else
    {
      ROS_ERROR("setArmMaterialTransform, FAILED TO GET ur_arm_wrist_3_link pose!");
    }
  }
  else
  {
    ROS_ERROR("setArmMaterialTransform, FAILED TO GET %s pose!", materialName.c_str());
  }

  // // Step 2: Get end effector's Pose
  // robot_state::RobotStatePtr kinematic_state = robot_state::RobotStatePtr(new robot_state::RobotState(move_group_ptr_->getRobotModel()));

  // // Copy the state of the joints to a kinematic state variable
  // jointStateToRobotState(joint_states_current, *kinematic_state);

  // // Set end effector from the model's kinematic as the end of the arm as there isn't any tool there to perform the grasp
  // const Eigen::Affine3d &end_effector_state = kinematic_state->getGlobalLinkTransform("ur_arm_tool0");

  // // Step 3: Get Difference = MaterialPose - EEPose

  // // Step 4: Create translation, then multiply by quaternion:
  // // https://stackoverflow.com/questions/50507665/eigen-rotate-a-vector3d-with-a-quaternion

  // // Translation
  // Eigen::Vector3d trans = Eigen::Vector3d(0.0, -OBJECT_STANDOFF_TRANS_Y, _endEffectorOffset);

  // // Quaternion (const Scalar &w, const Scalar &x, const Scalar &y, const Scalar &z)
  // Eigen::Quaterniond quat = Eigen::Quaterniond();  // quat to rotate by

  // // Eigen::Affine3d tmp_transform;
  // // tmp_transform = Eigen::Affine3d(Eigen::Translation3d());        

  // Look up transform from ur_arm_wrist_3_link to map
  try
  {
    // Wait for transform to become available.
    transform_listener.waitForTransform("map", "ur_arm_wrist_3_link", ros::Time(0), ros::Duration(10.0) );

    // Get trainsform as it should be available.
    transform_listener.lookupTransform("map", "ur_arm_wrist_3_link", ros::Time(0), _armMaterialTransform);
    ROS_INFO("TRANSFORM ARM-TO-MATERIAL IS SET!");
  }
  catch (tf::TransformException ex)
  {
    // Report error and exit
    ROS_ERROR("Transform Error: %s", ex.what());
    return;
  }
}

/*  TRANSFORM TO HUSKY
    Transform the input PoseStamped to the Husky reference frame.
    This can be used to calculate the pose to the point for either pick() or place().
*/
geometry_msgs::PoseStamped HuskyArm::transformToHusky(geometry_msgs::PoseStamped &poseStampedIn)
{
  geometry_msgs::PoseStamped poseStampedOut;

  // Look up the transform...
  try
  {
    // Wait for transform to become available.
    transform_listener.waitForTransform("ur_arm_wrist_3_link", poseStampedIn.header.frame_id, ros::Time(0), ros::Duration(10.0) );

    // Get trainsform as it should be available.
    transform_listener.lookupTransform("ur_arm_wrist_3_link", poseStampedIn.header.frame_id, ros::Time(0), _armMaterialTransform);
  }
  catch (tf::TransformException ex)
  {
    // Report error and exit
    ROS_ERROR("Transform Error: %s", ex.what());
    return poseStampedOut;
  }


  ROS_INFO("GET TRANSFORM TO HUSKY FRAME!");
  transform_listener.transformPose("husky", poseStampedIn, poseStampedOut);

  return poseStampedOut;
}

bool HuskyArm::configureFootprint(double length, double width)
{
  /*
      The ROS wiki notes that a C++ API is not available for the dynamic reconfigure package:
      http://wiki.ros.org/hokuyo_node/Tutorials/UsingDynparamToChangeHokuyoLaserParameters#Using_dynparam_from_C.2B-.2B-_code

      This may have changed since that wiki, but the method to use the std::system() call is implemented here.
  */
  std::stringstream ssLocal, ssGlobal;
  std::string strLocal, strGlobal;

  // The command line call that nearly doubled the footprint of the Husky was this:
  // rosrun dynamic_reconfigure dynparam set /move_base/global_costmap footprint '[[-1.0,-0.5],[-1.0,0.5],[1.0,0.5],[1.0,-0.5]]'
  ssLocal << "rosrun dynamic_reconfigure dynparam set /move_base/local_costmap footprint";
  ssGlobal << "rosrun dynamic_reconfigure dynparam set /move_base/global_costmap footprint";

  ssLocal
      << " '[["
      << (-length/2) << "," << (-width/2)
      << "],["
      << (-length/2) << "," << (width/2)
      << "],["
      << (length/2) << "," << (width/2)
      << "],["
      << (length/2) << "," << (-width/2)
      << "]]'";

  ssGlobal
      << " '[["
      << (-length/2) << "," << (-width/2)
      << "],["
      << (-length/2) << "," << (width/2)
      << "],["
      << (length/2) << "," << (width/2)
      << "],["
      << (length/2) << "," << (-width/2)
      << "]]'";

  // ssLocal >> strLocal;
  // ssGlobal >> strGlobal;

  strLocal = ssLocal.str();
  strGlobal = ssGlobal.str();

  // ROS_INFO("configureFootprint: ssLocal sent to system(): %s", strLocal.c_str() );
  // ROS_INFO("configureFootprint: ssGlobal sent to system(): %s", strGlobal.c_str() );

  // DEBUG: Do not modify the footprint right now.
  return true;

  // if( std::system(strLocal.c_str()) == 0)
  // {
  //   if( std::system(strGlobal.c_str()) == 0)
  //   {
  //     // If both work correctly, return true
  //     return true;
  //   }
  // }

  // // Something went wrong, return false.
  // return false;

}

geometry_msgs::Pose HuskyArm::getEEpose()
{
  // Get the kinematic state from the move_group's robot model.
  robot_state::RobotStatePtr kinematic_state = robot_state::RobotStatePtr(new robot_state::RobotState(move_group_ptr_->getRobotModel()));
  
  // Copy the state of the joints to a kinematic state variable
  jointStateToRobotState(_joint_states_current, *kinematic_state);

  const Eigen::Affine3d &end_effector_state = kinematic_state->getGlobalLinkTransform("ur_arm_tool0");

  // Temporary transform matrix.
  Eigen::Affine3d tmp_transform;
  Eigen::AngleAxis<double> tmp_rotation;

  if( _isFrontLoad ){
    // If approaching from the "front", heading is the -y direction, then translate y coordinate
    tmp_transform = Eigen::Affine3d(
                      Eigen::Translation3d(
                        Eigen::Vector3d(0.0, OBJECT_STANDOFF_TRANS_Y, _endEffectorOffset)
                          )
                            );
  }
  else{
    // If approaching from the side, heading is the +x direction, then translate x coordinate
    tmp_transform = Eigen::Affine3d(
                      Eigen::Translation3d(
                        Eigen::Vector3d(-OBJECT_STANDOFF_TRANS_Y, 0.0, _endEffectorOffset)
                          )
                            );
    // Rotate about z axis for grasp
    tmp_rotation = Eigen::AngleAxis<double>(-M_PI_2, Eigen::Vector3d::UnitZ() );
  }

  /* DO NOT TRANSFORM THE POINT YET
  // Transform (translation) the XYZ point off the end effector
  Eigen::Affine3d newTranState = end_effector_state * tmp_transform;  

  // Transform (rotation) the RPY of the object from end effector
  Eigen::Affine3d newRotState = end_effector_state * tmp_rotation;

  // The EE is pointed down, whereas the material is face-up, invert the pitch to switch.
  tmp_rotation = Eigen::AngleAxis<double>(-M_PI, Eigen::Vector3d::UnitX() );
  // tmp_rotation = Eigen::AngleAxis<double>(-M_PI, Eigen::Vector3d::UnitY() );
  newRotState = newRotState * tmp_rotation;  

  // Create a new geometry message for the pose of this new point.
  geometry_msgs::Pose pose;
  pose.position.x = newTranState.translation().x();
  pose.position.y = newTranState.translation().y();
  pose.position.z = newTranState.translation().z();

  // Set orientation with Eigen quaternion from state rotation.
  Eigen::Quaterniond quat(newRotState.rotation());
  pose.orientation.w = quat.w();
  pose.orientation.x = quat.x();
  pose.orientation.y = quat.y();
  pose.orientation.z = quat.z();

  */
  // Create a new geometry message for the pose of this new point.
  geometry_msgs::Pose pose;
  pose.position.x = end_effector_state.translation().x();
  pose.position.y = end_effector_state.translation().y();
  pose.position.z = end_effector_state.translation().z();

  // Set orientation with Eigen quaternion from state rotation.
  Eigen::Quaterniond quat(end_effector_state.rotation());
  pose.orientation.w = quat.w();
  pose.orientation.x = quat.x();
  pose.orientation.y = quat.y();
  pose.orientation.z = quat.z();

  printPoseMsgRPY("getEEpose() reports", pose);
  return pose;
}

void HuskyArm::printPoseMsgRPY(std::string msg, geometry_msgs::Pose pose)
{
  tf::Quaternion q(pose.orientation.x, pose.orientation.y, pose.orientation.z, pose.orientation.w);
  double roll=0, pitch=0, yaw=0;
  tf::Matrix3x3(q).getRPY(roll, pitch, yaw);

  ROS_INFO("%s---XYZ= %f, %f, %f, RPY= %f, %f, %f", msg.c_str(), pose.position.x, pose.position.y, pose.position.z, roll, pitch, yaw);
}

bool HuskyArm::isLoaded()
{
  return isGrasping;
}

void HuskyArm::initializeAmclFromGazebo()
{
  gazebo_msgs::GetModelState getModelState;
  getModelState.request.model_name = "husky";

  if(getModelStateClient.call(getModelState))
  {
    // Create a message for initialpose with initialized header
    geometry_msgs::PoseWithCovarianceStamped initialpose_amcl;

    // Set the graspPoint pose to the response from Get Model State
    initialpose_amcl.pose.pose = getModelState.response.pose;

    initialpose_amcl.header.frame_id="map";
    initialpose_amcl.header.stamp = ros::Time::now();

    // Set AMCL to current Gazebo location
    initialpose_pub.publish(initialpose_amcl);
    ROS_INFO("initializeAmclFromGazebo: Reinitialized AMCL!");
  }
  else
  {
    ROS_ERROR("initializeAmclFromGazebo: FAILED TO GET HUSKY POSE FROM GAZEBO.");
  }
}

void HuskyArm::forceStartState()
{
  // robot_state::RobotStatePtr kinematic_state = robot_state::RobotStatePtr(new robot_state::RobotState(move_group_ptr_->getRobotModel()))

  // moveit::planning_interface::MoveGroupInterface m_moveGroup("arm_group");
  // moveit::planning_interface::PlanningSceneInterface m_planningSceneInterface;
  // moveit::planning_interface::MoveGroupInterface::Plan m_plan;
  // PlanInterface planInterface(&m_moveGroup, &m_planningSceneInterface, &m_plan);
  // planInterface.setJointConstraints();

  // robot_model_loader::RobotModelLoader robot_model_loader("robot_description");
  // robot_model::RobotModelPtr kinematic_model = robot_model_loader.getModel();
  // planning_scene::PlanningScene planning_scene(kinematic_model);

  robot_state::RobotState current_state = robot_state::RobotState(move_group_ptr_->getRobotModel());
  // Values for side carry are:
  //   <group_state name="side_carry" group="ur5_arm">
  //     <joint name="ur_arm_elbow_joint" value="1.4059" />
  //     <joint name="ur_arm_shoulder_lift_joint" value="-1.8224" />
  //     <joint name="ur_arm_shoulder_pan_joint" value="-1.5707" />
  //     <joint name="ur_arm_wrist_1_joint" value="-2.8638" />
  //     <joint name="ur_arm_wrist_2_joint" value="-1.5707" />
  //     <joint name="ur_arm_wrist_3_joint" value="1.5707" />
  // </group_state> 
  //   <group_state name="prop" group="ur5_arm">
  //     <joint name="ur_arm_elbow_joint" value="0" />
  //     <joint name="ur_arm_shoulder_lift_joint" value="-0.75" />
  //     <joint name="ur_arm_shoulder_pan_joint" value="0" />
  //     <joint name="ur_arm_wrist_1_joint" value="-1.25" />
  //     <joint name="ur_arm_wrist_2_joint" value="1.5707" />
  //     <joint name="ur_arm_wrist_3_joint" value="0" />
  // </group_state>
  // std::vector<double> joint_values = { 1.4059, -1.8224, -1.5707, -2.8638, -1.5707, 1.5707 };
  std::vector<double> joint_values = { 0, -0.75, 0, -1.25, 1.5707, 0 };

  const robot_model::JointModelGroup* joint_model_group = current_state.getJointModelGroup("ur5_arm");
  current_state.setJointGroupPositions(joint_model_group, joint_values);
  move_group_ptr_->setStartState(current_state);

  // trajectory_msgs::JointTrajectory traj;
  // trajectory_msgs::JointTrajectoryPoint points_n;

  // traj.header.frame_id = "base_link";
  // traj.joint_names.resize(6);
  // traj.points.resize(1);

  // traj.points[0].positions.resize(1);
  // traj.points[0].velocities.resize(1);
  // traj.points[0].accelerations.resize(1);
  // traj.points[0].effort.resize(1);

  // traj.joint_names[0] ="ur_arm_elbow_joint";
  // traj.joint_names[1] ="ur_arm_shoulder_lift_joint";
  // traj.joint_names[2] ="ur_arm_shoulder_pan_joint";
  // traj.joint_names[3] ="ur_arm_wrist_1_joint";
  // traj.joint_names[4] ="ur_arm_wrist_2_joint";
  // traj.joint_names[5] ="ur_arm_wrist_3_joint";

  // for(int i=0; i<6; i++)
  // {
  //   // Set the position to the joint_value
  //   traj.points[i].positions[0]=joint_values[i];
  //   // Set the velocity and acceleration to zero, the desired value.
  //   traj.points[i].velocities[0]=0;
  //   traj.points[i].accelerations[0]=0;
  // }
  // arm_pub.publish(traj);
}
