#ifndef _HUSKYARM_H
#define _HUSKYARM_H

// MACROS
#define OBJECT_STANDOFF_TRANS_X 0.0
// Drywall panel has dimension: <size>1.2192 0.0127 1.2192</size>
// Lower the y-coordinate to the lower quarter, 1.2192/2/2 =  0.3048
// graspPoint->pose.position.y += .3048;
// Alternative: set to 0.0 to grab at center.
// #define OBJECT_STANDOFF_TRANS_Y .3048
// #define OBJECT_STANDOFF_TRANS_Y .1524
#define OBJECT_STANDOFF_TRANS_Y .175
// #define OBJECT_STANDOFF_TRANS_Y .4048

#define OBJECT_STANDOFF_TRANS_Z 0.06
#define HUSKY_STANDOFF_DIST 0.6           //Note the Husky itself is almost 1m long, so .5 minimum for its length.

// #include <move_pick_place/move_pick_place.h>

// ROS Controller
#include <trajectory_msgs/JointTrajectory.h>

// MoveIt
#include <moveit/planning_scene_interface/planning_scene_interface.h>
#include <moveit/move_group_interface/move_group_interface.h>

#include <moveit_msgs/DisplayRobotState.h>
#include <moveit_msgs/DisplayTrajectory.h>

#include <moveit_msgs/AttachedCollisionObject.h>
#include <moveit_msgs/CollisionObject.h>
#include <moveit/robot_state/conversions.h>
#include <moveit_visual_tools/moveit_visual_tools.h>

// Move Base
#include <move_base_msgs/MoveBaseAction.h>
#include <actionlib/client/simple_action_client.h>

// Link Attacher
// #include "gazebo_ros_link_attacher/gazebo_ros_link_attacher.h"
#include "gazebo_ros_link_attacher/Attach.h"

class HuskyArm
{
  private:
    // Actionlib client for moving the base.
    typedef actionlib::SimpleActionClient<move_base_msgs::MoveBaseAction> MoveBaseClient;

    // ROS service clients for interacting with Gazebo objects.
    ros::ServiceClient getModelStateClient;
    ros::ServiceClient setModelStateClient;
    ros::ServiceClient spawnModelClient;
    ros::ServiceClient deleteModelClient;
    ros::ServiceClient attachMaterialClient;
    ros::ServiceClient detachMaterialClient;
    ros::ServiceClient getLinkStateClient;

    // Create a publisher to intialize the initial pose of AMCL.
    ros::Publisher initialpose_pub;
    ros::Subscriber amclpose_sub;
    ros::Subscriber linkStatesSub;

    // Velocity controller publisher to move Husky by velocity (if needed)
    ros::Publisher huskyVelController_pub;

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
    ros::Publisher armControllerPub;

    // Variable to flag whether the demo is currently grasping the drywall panel.
    bool isGrasping;

    // Name of the grasped object.
    std::string graspObj;

    // Objects for the planner to work around
    std::vector<std::string> _planning_object_ids;

    // Variable to store the NodeHandle created in the main() loop.
    ros::NodeHandle _nh;

    // TF Listener Variables
    tf::TransformListener transform_listener;

    // The amcl_pose used to calculate startin location.
    geometry_msgs::PoseWithCovarianceStamped amcl_pose;

    // Flag for whether or not the Husky is to load material from the front, or the side.
    bool _isFrontLoad;

    // Offset from end effector to material.
    double _endEffectorOffset;
    double _zOffset;

    int debugCounter;

    std::string _stackType;
    int _stackId;

    tf::StampedTransform _armMaterialTransform;
    
    geometry_msgs::Pose _geometryTransform;
    std::vector<moveit_msgs::CollisionObject> _collision_objects;
    sensor_msgs::JointState _joint_states_current;

  public:
    HuskyArm(ros::NodeHandle node_handle);                      // Initialize the robot arm and stow it.
    ~HuskyArm();                                                // Delete the pointers for both Navigation and Manipulation.
    void TransformPoint(                                        // Transform the input point to its coordinates in the new target frame.
      geometry_msgs::PoseStamped *in_point,
      std::string target_frame);
    void getMaterialGraspPoint(                                  // Return a point near the base of the drywall panel to perform the grasp.
      geometry_msgs::PoseStamped *graspPoint,
      std::string materialName);
    void stow();                                                // Initialize the robot arm to a stowed configuration.
    void setGrasp(std::string objectName);                      // Sets internal flags to have object follow arm end effector
    void unsetGrasp(std::string objectName);                    // Unsets internal flags to allow object to drop with Gazebo physics.
    void removeStack(std::string stackType);                    // Removes the drywall stack from the planner's view of the world.
    void goToLoadZone();                                        // Husky moves to the loading zone.
    int goToHuskyPose(                                         // Husky moves to the goal point.
      double x_in, double y_in, double yaw_in);
    void goToArmPose(std::string poseName,                      // Helper function sets the arm to preconfigured pose based on input poseName.
      bool isGrasp, std::string materialName, 
      std::string stackType, int stackNum, int materialNum);                     
    bool pickFromStack(int drywallNum,                          // Sets arm to target pose of drywall panel on top of stack and attaches panel.
      std::string stackType, int stackNum );
    void addPlaceObjects();                                     // Add Objects for Planning the Place
    void addPickObjects(std::string stackType,                  // Add Objects for Planning the Pick
      int stackNum, int materialNum);     
    void addPoseObjects(std::string stackType,                  // Add Objects for Planning the Pick
      int stackNum, int materialNum);                 
    void removePlanningObjects();                               // Remote objects for planning the pick
    void jointStatesCallback(                                   // Simulates grasp by setting model state of the drywall panel to follow end effector.
      const sensor_msgs::JointState &joint_states_current);
    void amclPoseCallback(                                      // Callback to latch initial pose of Husky when spawned.
      const geometry_msgs::PoseWithCovarianceStamped &pose_in);
    int armToTargetPose(                                        // Moves the arm's end effector to the input target pose.
      const geometry_msgs::PoseStamped &target_pose);
    int place(geometry_msgs::PoseStamped &drywallPose,          // Place the end effector at the designated input pose.
      bool flipApproach);         
    void affixDryWall(                                          // Simulates another tool drilling, or nailing, the drywall to the stud.
      geometry_msgs::PoseStamped &drywallPose, int drywallNum);
    void retreat(int magnitude);                                //  Husky briefly runs in reverse.
    geometry_msgs::Pose getModelPose(std::string modelName);    //  Return the pose of a model with name as input.
    void setFrontLoadFlag( bool isFrontLoad );                  //  Sets flag for making a grasp at the front of the Husky, or the side.
    void setEndEffectorOffset( double endEffectorOffset );      //  Sets distance beyond end effector at which material is "grasped."
    void anchorHusky();                                         //  Attaches the Husky's base_link to the world frame, holding it in place.
    void detachHusky();                                         //  Releases the Husky's base_link from the attach() to the world frame.
    void setStackTarget(std::string stackType, int stackId);    //  Sets the private variable for the stack the Husky is to drive to.
    void removePlanningObject(std::string objectName);          //  Remove a single planning object from the planning scene by name.
    void attachMaterial(std::string modelName);                 //  Attach a material to the wrist of the arm. [Not used]
    void releaseMaterial(std::string modelName);                //  Release the material attached to the wrist. Not implemented. [Not used]
    void setArmMaterialTransform(std::string materialFrame);    //  Set a private member with the transform between the arm EE and material. [Not used.]
    geometry_msgs::PoseStamped transformToHusky(                //  Transform the input PoseStamped to the Husky reference frame. [Not used]
      geometry_msgs::PoseStamped &poseStampedIn);
    void linkStatesCallback(                                    //  Alternative to jointStatesCallback for maintaining a grasp.
      const gazebo_msgs::LinkStates &linkStates);               //  Did not work better, not used, code is commented.
    bool findCollisionObject(std::string objectName);           //  Checks names of internal vector; returns TRUE if object is in the array
    bool configureFootprint(double length, double width);       //  Modifies the robot's footprint used by navigation planners with dynamic reconfigure. [Commented out]
    geometry_msgs::Pose getEEpose();                            //  Gets the pose of EE using same logic as in jointStatesCallback.
    void printPoseMsgRPY(std::string msg,                       //  Prints the XYZ position and RPY from the input pose.
      geometry_msgs::Pose pose);
    bool isLoaded();                                            //  Returns if the isGrasping variable is true - meaning that a material is loaded on Husky.
    void initializeAmclFromGazebo();                            //  Calls service for current pose from Gazebo's model state and sends it to AMCL initalpose/ topic.
    void forceStartState();                                     //  Resets the start state of the joints in the arm [not tested if effective]
};
#endif