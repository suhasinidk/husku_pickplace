#ifndef _MATERIALSTACK_H
#define _MATERIALSTACK_H

// MACROS

// ROS
// #include <move_pick_place/move_pick_place.h>
#include <std_srvs/Empty.h>
#include "gazebo_ros_link_attacher/Attach.h"

class MaterialStack
{
  private:
    // Stack's Pose
    geometry_msgs::Pose _pose;
    double _stack_height;
    double _material_thick;
    double _material_z;
    std::string _stackName;
    int _stackNum;
    int _numMaterials;
    double _stack_length;
    double _stack_width;
    std::string _stackType;
    std::string _stackNameBase;
    std::string _sdf_file_name;
    static int _materialCount;
    std::vector<std::string> _materialVec;

    // Node handle for ROS manager.
    ros::NodeHandle _nh;

    // ROS Publishers

    // ROS service clients for interacting with Gazebo objects.
    ros::ServiceClient getModelStateClient;
    ros::ServiceClient setModelStateClient;
    ros::ServiceClient spawnModelClient;
    ros::ServiceClient deleteModelClient;
    ros::ServiceClient _pauseGazeboClient;
    ros::ServiceClient _unpauseGazeboClient;
    ros::ServiceClient _attachMaterialClient;
    ros::ServiceClient _detachMaterialClient;

  public:
    MaterialStack( ros::NodeHandle nh,                                  // Default constructor creates a stack of 1/2 panel drywall at the initial pose.
      geometry_msgs::Pose initPose, int stackNum );
    MaterialStack( ros::NodeHandle nh,                                  // Alternative constructor used in derived classes.
      geometry_msgs::Pose initPose, int stackNum,
      double stack_length, double stack_width, 
      double stack_height, double materialThick,
      int numMaterials, std::string stackType );
    int spawnMaterial( int materialNum );                               // Create a material on top of the stack.
    int 
    SpawnModelFromFile(std::string sdf_file_name,                       // Load sdf from a file, used by spawnMaterial
      std::string model_name, geometry_msgs::Pose initial_pose);
    std::string getName();                                              // Returns name of the stack.
    void init();                                                        // Initializes services and spawns the stack in gazebo. 
                                                                        // All settings are set in the constructor.
    void anchorStack();                                                 // Uses the gazebo_ros_link_attacher to anchor a non-static stack in place.
    void releaseStack();                                                // Uses the gazebo_ros_link_attacher to release an anchored non-static material stack.
    void initWithMaterials();                                           // Creates a stack as in init(), but with multiple SDF models instead of geom box.
    int SpawnDropModelFromFile( std::string sdf_file_name,              // Load sdf from a file, drops from initial_pose, used by initWithMaterials
      std::string model_name, 
      geometry_msgs::Pose initial_pose);
    void anchorMaterial(std::string modelName);                         // Uses the gazebo_ros_link_attacher to anchor a non-static material in place.
    void releaseMaterial(std::string modelName);                        // Uses the gazebo_ros_link_attacher to release a non-static material in place.
    std::string popNextMaterial();                                      // Releases the top material, pops from internal vector, and returns the model's name.

};

// Derive a class for creating a stack of full-panel drywall
class DrywallStack: public MaterialStack
{
  public:
    DrywallStack( ros::NodeHandle nh,                                   // Create a Drywall stack at the initial pose.
      geometry_msgs::Pose initPose, int stackNum );
};

// Derive a class for creating a stack of full-panel frame
class FrameStack: public MaterialStack
{
  public:
    FrameStack( ros::NodeHandle nh,                                     // Create a Frame stack at the initial pose.
      geometry_msgs::Pose initPose, int stackNum );
};
#endif