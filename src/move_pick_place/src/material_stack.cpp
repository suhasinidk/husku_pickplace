/*********************************************************************
* Name:         drywall_stack.cpp
* Description:  Class definition for a simulated material stack. The
*               material stack is responsible for spawning new materials
*               for robots to pick up. It is also responsible for
*               lowering its own height whenever a material is taken.
* Author:       William Turner
*********************************************************************/
#include <move_pick_place/move_pick_place.h>
#include <move_pick_place/material_stack.h>

// Generic constructor for Material Stack (default settings to 1/4 drywall panel)
MaterialStack::MaterialStack( ros::NodeHandle nh, geometry_msgs::Pose initPose, int stackNum )
{
  _nh = nh;

  // Stack dimensions
  _stack_length = 1.2192; // x-dim, Drywall panel is 4' long
  _stack_width = 1.2192;  // y-dim, Drywall panel is 4' wide
  _stack_height = 0.22862; // z-dim, Drywall stack is 9" high

  // Drywall panel is 1/2" thick.
  _material_thick = 0.0127;

  // Set the material's spawn z (x and y match stack), add offset for lowered stack, material thickness, .05 asphalt plane.
  _material_z = _stack_height - _material_thick + _material_thick/2 + .05;

  // At 9", and 1/2" thick, there are 18 sheets of drywall on the stack.
  _numMaterials = 18;

  // Initialize to input.
  _pose = initPose;

  // Overwrite the input z so that it is just about the asphalt plane.
  _pose.position.z = _stack_height/2 + .05;

  // Set the tf2 quaternion message with RPY.
  tf2::Quaternion quat_tf;
  quat_tf.setRPY(0.000, 0.000, 0.000);

  // Create the quaternion message from the tf2 msg.
  geometry_msgs::Quaternion quat_msg = tf2::toMsg(quat_tf);

  // Set the orientation of the goal pose.
  _pose.orientation = quat_msg;

  _stackNum = stackNum;
  _stackType = "drywall_panel";

  // Local package path for the SDF file name
  std::string pkg_path = ros::package::getPath("move_pick_place");
  _stackNameBase = _stackType + "_stack_static";
  // _stackNameBase = _stackType + "_stack";
  _sdf_file_name = pkg_path + "/models/" + _stackNameBase + "/model.sdf";

  _stackName = _stackNameBase + std::to_string(_stackNum);
  ROS_INFO("_stackType= %s", _stackType.c_str() );
  ROS_INFO("_stackNameBase= %s", _stackNameBase.c_str() );
  ROS_INFO("_stackName= %s", _stackName.c_str() );

  ROS_INFO("Material Stack object created with 1/2 panel drywall settings!");
}

// Custom constructor for any Material Stack
MaterialStack::MaterialStack( ros::NodeHandle nh, geometry_msgs::Pose initPose, int stackNum,
  double stack_length, double stack_width, double stack_height, double materialThick,
  int numMaterials, std::string stackType )
{
  _nh = nh;

  // Stack dimensions
  _stack_length = stack_length; // x-dim, length
  _stack_width = stack_width;  // y-dim, width
  _stack_height = stack_height; // z-dim, height

  // Store the material thickness.
  _material_thick = materialThick;

  // Set the number of materials in the stack.
  _numMaterials = numMaterials;

  // Initialize to input.
  _pose = initPose;

  // Overwrite the input z so that it is centered above the asphalt plane.
  _pose.position.z = (_stack_height/2 ) + .05;

    // Set the material's spawn z (x and y match stack), add offset for stack height, material thickness, .05 asphalt plane.
  // _material_z = initPose.position.z + (_material_thick/2);
  _material_z = _stack_height + (_material_thick/2) + .05;

  ROS_INFO("MATERIAL STACK: INITIAL POSE Z= %f", _pose.position.z);
  // Identification for this stack.
  _stackNum = stackNum;
  _stackType = stackType;

  // Local package path for the SDF file name
  std::string pkg_path = ros::package::getPath("move_pick_place");
  _stackNameBase = _stackType + "_stack_static";
  // _stackNameBase = _stackType + "_stack";
  _sdf_file_name = pkg_path + "/models/" + _stackNameBase + "/model.sdf";

  _stackName = _stackNameBase + std::to_string(_stackNum);
  ROS_INFO("_stackType= %s", _stackType.c_str() );
  ROS_INFO("_stackNameBase= %s", _stackNameBase.c_str() );
  ROS_INFO("_stackName= %s", _stackName.c_str() );
}

/*  INITIALIZE
    This function initializes services and spawns the stack in gazebo.
    All settings are set in the constructor.
*/
void MaterialStack::init()
{  
  // These services are for the programatic creation of drywall panels
  getModelStateClient = _nh.serviceClient<gazebo_msgs::GetModelState>("/gazebo/get_model_state");
  setModelStateClient = _nh.serviceClient<gazebo_msgs::SetModelState>("/gazebo/set_model_state");
  spawnModelClient = _nh.serviceClient<gazebo_msgs::SpawnModel>("/gazebo/spawn_sdf_model");
  deleteModelClient = _nh.serviceClient<gazebo_msgs::DeleteModel>("/gazebo/delete_model");
  _attachMaterialClient = _nh.serviceClient<gazebo_ros_link_attacher::Attach>("/link_attacher_node/attach");
  _detachMaterialClient = _nh.serviceClient<gazebo_ros_link_attacher::Attach>("/link_attacher_node/detach");
  // _gazebo_model_state_pub = _nh.advertise<gazebo_msgs::ModelState>("/gazebo/set_model_state", 1);

  // Pause/Unpause service code found here: https://answers.ros.org/question/319774/ros-c-pause-unpause-gazebo/
  _pauseGazeboClient = _nh.serviceClient<std_srvs::Empty>("/gazebo/pause_physics");
  _unpauseGazeboClient = _nh.serviceClient<std_srvs::Empty>("/gazebo/unpause_physics");

  if( SpawnModelFromFile(_sdf_file_name, _stackName, _pose) == 0 ){
    ROS_INFO("STACK: %s, NUMBER: %d, CREATION SUCCESS!", _stackName.c_str(), _stackNum);
    
    tf::Quaternion q(_pose.orientation.x, _pose.orientation.y, _pose.orientation.z, _pose.orientation.w);
    double roll=0, pitch=0, yaw=0;
    tf::Matrix3x3(q).getRPY(roll, pitch, yaw);

    // Put the dimensions and pose on the param server
    std::string baseParamString = "/material/stack/" + _stackType + "/" + std::to_string(_stackNum) + "/";
    _nh.setParam( (baseParamString + "box/x").c_str(), _stack_length);
    _nh.setParam( (baseParamString + "box/y").c_str(), _stack_width);
    _nh.setParam( (baseParamString + "box/z").c_str(), _stack_height);
    _nh.setParam( (baseParamString + "position/x").c_str(), _pose.position.x);
    _nh.setParam( (baseParamString + "position/y").c_str(), _pose.position.y);
    _nh.setParam( (baseParamString + "position/z").c_str(), _pose.position.z);
    _nh.setParam( (baseParamString + "orientation/x").c_str(), _pose.orientation.x);
    _nh.setParam( (baseParamString + "orientation/y").c_str(), _pose.orientation.y);
    _nh.setParam( (baseParamString + "orientation/z").c_str(), _pose.orientation.z);
    _nh.setParam( (baseParamString + "orientation/w").c_str(), _pose.orientation.w);
    _nh.setParam( (baseParamString + "orientation/R").c_str(), roll);
    _nh.setParam( (baseParamString + "orientation/P").c_str(), pitch);
    _nh.setParam( (baseParamString + "orientation/Y").c_str(), yaw);

    // Place the material's dimensions on the param server
    baseParamString = "/material/" + _stackType + "/"; 
    _nh.setParam( (baseParamString + "box/x").c_str(), _stack_length);
    _nh.setParam( (baseParamString + "box/y").c_str(), _stack_width);
    _nh.setParam( (baseParamString + "box/z").c_str(), _material_thick);
  }
  else
  {
    ROS_ERROR("MATERIAL STACK %d CREATION FAILURE!", _stackNum);
  }
}

// DrywallStack::~DrywallStack()
// {

// }

/*  spawnMaterial: 
    A helper function to spawn the material model on top of the material stack.
*/
int MaterialStack::spawnMaterial(int materialNum)
{
  ROS_INFO("Previous material count: %d", _materialCount );
  _materialCount++;
  ROS_INFO("New material count: %d", _materialCount );

  ROS_INFO("OLD Stack Point XYZ= %f, %f, %f", _pose.position.x, _pose.position.y, _pose.position.z);

  if( _numMaterials == 0 ){
    ROS_ERROR("%s has no more materials!", _stackName.c_str());
    return 1;
  }

  // Generate messsages to interact with models to get and set state.
  gazebo_msgs::GetModelState getModelState;
  gazebo_msgs::SetModelState setModelState;

  // Give the material a name with input number.
  std::string materialName;
  if( _stackType == "drywall" )
  {
    // materialName = _stackType + "_panel" + std::to_string(materialNum);
    materialName = _stackType + std::to_string(materialNum);
  }
  else
  {
    materialName = _stackType + std::to_string(materialNum);
  }

  // Set the material model name.
  getModelState.request.model_name = materialName.c_str();

  // Call the model state to determine if the material already exists.
  if ( !getModelStateClient.call(getModelState))
  {
      // Already exists, return 0.
      ROS_WARN("Material: %s already exists!", materialName.c_str() );
      return 0;
  }

  // Material not found, create on top of stack
  geometry_msgs::Pose stackSetPoint;
  geometry_msgs::Pose materialSpawnPoint;

  // Set the xy coordinates to match the stack
  stackSetPoint.position.x = _pose.position.x;
  stackSetPoint.position.y = _pose.position.y;

  // Set height so material is on top of stack
  ROS_INFO("Setting the stack point to z= %f", _pose.position.z - _material_thick);
  stackSetPoint.position.z = _pose.position.z - _material_thick ;

  // Set the orientation of the material to match the stack
  stackSetPoint.orientation = _pose.orientation;

  // Configure the materialSpawnPoint for the same xy as the stack, change the z.
  materialSpawnPoint = stackSetPoint;
  materialSpawnPoint.position.z = _material_z + .1;

  // Open the SDF file of the material at the local path of the package
  std::string pkg_path = ros::package::getPath("move_pick_place");
  std::string sdf_file_name;
  if( _stackType == "drywall" )
  {
    // sdf_file_name = pkg_path + "/models/" + _stackType + "_panel/model.sdf";
    sdf_file_name = pkg_path + "/models/" + _stackType + "/model.sdf";
  }
  else
  {
    sdf_file_name = pkg_path + "/models/" + _stackType + "/model.sdf";
  }
  
  // Use original Model State as baseline for new Model State
  setModelState.request.model_state.model_name = _stackName.c_str();
  setModelState.request.model_state.pose = stackSetPoint;
  setModelState.request.model_state.twist.linear.x = 0;
  setModelState.request.model_state.twist.linear.y = 0;
  setModelState.request.model_state.twist.linear.z = 0;
  setModelState.request.model_state.twist.angular.x = 0;
  setModelState.request.model_state.twist.angular.y = 0;
  setModelState.request.model_state.twist.angular.z = 0;  
  setModelState.request.model_state.reference_frame = "world";

  /*  Publishing the model state failed to work, use service instead...
  // // Publish the model state for this model, the drywall panel
  // gazebo_msgs::ModelState model_state;

  // // Provide the name, pose, and reference frame for the drywall panel
  // model_state.model_name = _stackName.c_str();
  // model_state.pose = stackSetPoint;
  // model_state.reference_frame = std::string("world");

  // // Publish on state publisher
  // _gazebo_model_state_pub.publish(model_state);
  */
  if( !setModelStateClient.call(setModelState) )
  {
    ROS_ERROR("SpawnModel: FAILED to call Set Model State!");
  }

  // Lower the stack in sequence of steps...
  std_srvs::Empty pauseSrv;

  ROS_INFO("NEW Stack Point XYZ= %f, %f, %f", stackSetPoint.position.x, stackSetPoint.position.y, stackSetPoint.position.z);

  bool serviceSuccess = false;
  getModelState.request.model_name = _stackName.c_str();

  for( int i=0; i<5 && !serviceSuccess; i++)
  {
    // Call the model state to set it's position at the lower z-value.
    // setModelStateClient.call(setModelState);
    getModelStateClient.call(getModelState);

    if ( stackSetPoint.position.z ==  getModelState.response.pose.position.z)
    {
      ROS_INFO("Successfully lowered stack to z= %f!", getModelState.response.pose.position.z);
      serviceSuccess = true;
      std::string baseParamString = "/material/stack/" + _stackType + "/" + std::to_string(_stackNum) + "/";
      _nh.setParam( (baseParamString + "position/z").c_str(), stackSetPoint.position.z);
    }
    else
    {
      ROS_WARN("Failed to lower materials stack! Try %d of 5", i);
      ROS_INFO("Service call for: %s", _stackName.c_str() );
    }
  }

  // Update number of materials and dimensions for spawned material.
  _numMaterials--;

  // Decrement the stack's z pose, height, and the material's spawn z value.
  _pose.position.z -= _material_thick;
  _stack_height -= _material_thick;
  _material_z -= _material_thick;
  ROS_INFO("Spawn Point XYZ= %f, %f, %f", materialSpawnPoint.position.x, materialSpawnPoint.position.y, materialSpawnPoint.position.z);
  return this->SpawnModelFromFile(sdf_file_name, materialName, materialSpawnPoint);
}

/*  SpawnModelFromFile: 
    A helper function to spawn a model from an SDF file.
*/
int MaterialStack::SpawnModelFromFile(std::string sdf_file_name, std::string model_name, geometry_msgs::Pose initial_pose)
{
  gazebo_msgs::SpawnModel spawnModel;

  // Generate messsages to interact with models to get and set state.
  gazebo_msgs::GetModelState getModelState;
  gazebo_msgs::SetModelState setModelState;

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

  // Configure spawn model settings.
  spawnModel.request.model_name = model_name.c_str();
  spawnModel.request.model_xml = sdf_xml.str().c_str();
  spawnModel.request.robot_namespace = "";
  spawnModel.request.initial_pose = initial_pose;
  spawnModel.request.reference_frame = "world";

  if (spawnModelClient.call(spawnModel))
  {
      // Success, return 0
      ROS_INFO("SUCCESS: spawn model, %s, from sdf file: %s", model_name.c_str(), sdf_file_name.c_str());

      // Give ROS a second to update the pose of the model before returning to caller.
      ros::WallDuration(1.0).sleep();
  }
  else{
      // Report error.
      ROS_ERROR("FAILURE: spawn model, %s, from sdf file: %s", model_name.c_str(), sdf_file_name.c_str());
      return 1;
  }

  bool serviceSuccess = false;
  getModelState.request.model_name = model_name.c_str();

  setModelState.request.model_state.model_name = model_name.c_str();
  setModelState.request.model_state.pose = initial_pose;
  setModelState.request.model_state.reference_frame = "world";

  for( int i=0; i<5 && !serviceSuccess; i++)
  {
    getModelStateClient.call(getModelState);

    if ( IsInBounds(getModelState.response.pose.position.x, initial_pose.position.x-.01, initial_pose.position.x+.01) &&
          IsInBounds(getModelState.response.pose.position.y, initial_pose.position.y-.01, initial_pose.position.y+.01) &&
          IsInBounds(getModelState.response.pose.position.z, initial_pose.position.z-.01, initial_pose.position.z+.01) )
    {
      ROS_INFO("Spawn model from file pose is in bounds! XYZ= %f, %f, %f!", 
        getModelState.response.pose.position.x, 
        getModelState.response.pose.position.y, 
        getModelState.response.pose.position.z);

      serviceSuccess = true;
    }
    else
    {
      ROS_WARN("Spawn model from file pose mismatch! Try %d of 5.\nSet Point: XYZ= %f, %f, %f!\nGet Point: XYZ= %f, %f, %f!\nWill attempt manual set.",
        i,
        setModelState.request.model_state.pose.position.x, 
        setModelState.request.model_state.pose.position.y, 
        setModelState.request.model_state.pose.position.z,
        getModelState.response.pose.position.x, 
        getModelState.response.pose.position.y, 
        getModelState.response.pose.position.z);
      setModelStateClient.call(setModelState);
    }
  }
  if( serviceSuccess == true )
  {
    // Give ROS a second to update the pose of the model before returning to caller.
    ros::WallDuration(1.0).sleep();
    return 0;
  }
  else
  {
    return 1;
  }
}

/*  GET NAME
    Function to return the name of this stack.
*/
std::string MaterialStack::getName()
{
  return _stackName;
}

/*  DERIVED CLASS: DRYWALL
    Class definition for drywall stack with full-panel drywall.
*/
DrywallStack::DrywallStack( ros::NodeHandle nh, geometry_msgs::Pose initPose, int stackNum ):
    MaterialStack{nh, initPose, stackNum, 2.4384, 1.2192, 0.22862, 0.0127, 18, "drywall"}
{
  ROS_INFO("Drywall Stack created with full panel drywall settings!");
}

/*  DERIVED CLASS: FRAME
    Class definition for frame stack with full-panel frame.
*/
FrameStack::FrameStack( ros::NodeHandle nh, geometry_msgs::Pose initPose, int stackNum ):
    MaterialStack{nh, initPose, stackNum, 2.4, 1.21, 0.3048, 0.1016, 3, "frame"}
    // OLD PRE-FITTED COLLISION MaterialStack{nh, initPose, stackNum, 2.4384, 1.2192, 0.3048, 0.1016, 3, "frame"}
{
  ROS_INFO("Frame Stack created with full panel frame settings!");
}

/*  ANCHOR STACK
    Function to call the gazebo_ros_link_attacher service to attach the stack to the ground_plane with a fixed joint.
*/
void MaterialStack::anchorStack()
{
  ROS_INFO("ANCHOR STACK!");
  gazebo_ros_link_attacher::Attach attachMsg;

  attachMsg.request.model_name_1 = _stackName;
  attachMsg.request.link_name_1 = "link";
  attachMsg.request.model_name_2 = "ground_plane";
  attachMsg.request.link_name_2 = "link";

  // Set the models for attachment.
  _attachMaterialClient.call(attachMsg);
}

/*  RELEASE STACK
    Function to call the gazebo_ros_link_attacher service to detach the stack from the ground_plane's fixed joint.
*/
void MaterialStack::releaseStack()
{
  ROS_INFO("RELEASE STACK!");
  gazebo_ros_link_attacher::Attach detachMsg;

  detachMsg.request.model_name_1 = _stackName;
  detachMsg.request.link_name_1 = "link";
  detachMsg.request.model_name_2 = "ground_plane";
  detachMsg.request.link_name_2 = "link";

  // Set the models for detachment.
  _detachMaterialClient.call(detachMsg);
}

/*  INITIALIZE WITH MATERIALS
    This function initializes services and spawns the stack in gazebo.
    All settings are set in the constructor.
    The stack is not a basic gazebo geometry, but is instead individually spawned SDF model files.
*/
void MaterialStack::initWithMaterials()
{  
  // These services are for the programatic creation of drywall panels
  getModelStateClient = _nh.serviceClient<gazebo_msgs::GetModelState>("/gazebo/get_model_state");
  setModelStateClient = _nh.serviceClient<gazebo_msgs::SetModelState>("/gazebo/set_model_state");
  spawnModelClient = _nh.serviceClient<gazebo_msgs::SpawnModel>("/gazebo/spawn_sdf_model");
  deleteModelClient = _nh.serviceClient<gazebo_msgs::DeleteModel>("/gazebo/delete_model");
  _attachMaterialClient = _nh.serviceClient<gazebo_ros_link_attacher::Attach>("/link_attacher_node/attach");
  _detachMaterialClient = _nh.serviceClient<gazebo_ros_link_attacher::Attach>("/link_attacher_node/detach");

  // Pause/Unpause service code found here: https://answers.ros.org/question/319774/ros-c-pause-unpause-gazebo/
  _pauseGazeboClient = _nh.serviceClient<std_srvs::Empty>("/gazebo/pause_physics");
  _unpauseGazeboClient = _nh.serviceClient<std_srvs::Empty>("/gazebo/unpause_physics");

  int TEST_SPAWN_NUM = 100;
  // std::string materialName = _stackType + std::to_string(TEST_SPAWN_NUM);
  geometry_msgs::Pose spawnPose = _pose;

  // Set the spawn point at an offset greater than the height of the stack and floor and material thickness.
  spawnPose.position.z = _stack_height + _material_thick + .05;

  // Give the material a name with input number.
  std::string materialName = _stackType + std::to_string(TEST_SPAWN_NUM);

  // Open the SDF file of the material at the local path of the package
  std::string pkg_path = ros::package::getPath("move_pick_place");
  std::string sdf_file_name;

  sdf_file_name = pkg_path + "/models/" + _stackType + "/model.sdf";

  if( SpawnDropModelFromFile(sdf_file_name, materialName, spawnPose) == 0 ){
    ROS_INFO("STACK TYPE: %s, NUMBER: %d, NAME: %s, CREATION SUCCESS!", _stackType.c_str(), TEST_SPAWN_NUM, materialName.c_str());
    // _materialVec.push_back(materialName);

    tf::Quaternion q(_pose.orientation.x, _pose.orientation.y, _pose.orientation.z, _pose.orientation.w);
    double roll=0, pitch=0, yaw=0;
    tf::Matrix3x3(q).getRPY(roll, pitch, yaw);

    // Put the dimensions and pose on the param server
    std::string baseParamString = "/material/stack/" + _stackType + "/" + std::to_string(_stackNum) + "/";
    _nh.setParam( (baseParamString + "box/x").c_str(), _stack_length);
    _nh.setParam( (baseParamString + "box/y").c_str(), _stack_width);
    _nh.setParam( (baseParamString + "box/z").c_str(), _stack_height);
    _nh.setParam( (baseParamString + "position/x").c_str(), _pose.position.x);
    _nh.setParam( (baseParamString + "position/y").c_str(), _pose.position.y);
    _nh.setParam( (baseParamString + "position/z").c_str(), _pose.position.z);
    _nh.setParam( (baseParamString + "orientation/x").c_str(), _pose.orientation.x);
    _nh.setParam( (baseParamString + "orientation/y").c_str(), _pose.orientation.y);
    _nh.setParam( (baseParamString + "orientation/z").c_str(), _pose.orientation.z);
    _nh.setParam( (baseParamString + "orientation/w").c_str(), _pose.orientation.w);
    _nh.setParam( (baseParamString + "orientation/R").c_str(), roll);
    _nh.setParam( (baseParamString + "orientation/P").c_str(), pitch);
    _nh.setParam( (baseParamString + "orientation/Y").c_str(), yaw);

    // Place the material's dimensions on the param server
    baseParamString = "/material/" + _stackType + "/"; 
    _nh.setParam( (baseParamString + "box/x").c_str(), _stack_length);
    _nh.setParam( (baseParamString + "box/y").c_str(), _stack_width);
    _nh.setParam( (baseParamString + "box/z").c_str(), _material_thick);

    // Start counting at 1, because the first material, 0, was already spawned above.
    for( int i=1; i<_numMaterials-1; i++ )
    {
      materialName = _stackType + std::to_string(TEST_SPAWN_NUM - i);
      ROS_INFO("Experimental Spawn: i = %d, TEST_SPAWN_NUM= %d, materialName= %s", i, TEST_SPAWN_NUM, materialName.c_str());
      SpawnDropModelFromFile(sdf_file_name, materialName, spawnPose);
      _materialVec.push_back(materialName);
      ROS_INFO("Experimental Spawn: pushed back the materialName...");
    }
  }
  else
  {
    ROS_ERROR("MATERIAL STACK %d CREATION FAILURE!", _stackNum);
  }
  ROS_INFO("MATERIAL STACK: DONE WITH initWithMaterials()!");
}

/*  SpawnDropModelFromFile: 
    A helper function to spawn a model from an SDF file. Does not validate the spawned position. Assumes
    that the initial_pose is above the stack's base sufficient to fall (drop) to its proper starting position.
*/
int MaterialStack::SpawnDropModelFromFile(std::string sdf_file_name, std::string model_name, geometry_msgs::Pose initial_pose)
{
  gazebo_msgs::SpawnModel spawnModel;

  // Generate messsages to interact with models to get and set state.
  gazebo_msgs::GetModelState getModelState;
  gazebo_msgs::SetModelState setModelState;

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

  // Configure spawn model settings.
  spawnModel.request.model_name = model_name.c_str();
  spawnModel.request.model_xml = sdf_xml.str().c_str();
  spawnModel.request.robot_namespace = "";
  spawnModel.request.initial_pose = initial_pose;
  spawnModel.request.reference_frame = "world";

  if (spawnModelClient.call(spawnModel))
  {
      // Success, return 0
      ROS_INFO("SUCCESS: spawn model, %s, from sdf file: %s", model_name.c_str(), sdf_file_name.c_str());

      // Give ROS a second to update the pose of the model (and drop) before returning to caller.
      ros::WallDuration(1.0).sleep();

      anchorMaterial(model_name);
      return 0;
  }
  else{
      // Report error.
      ROS_ERROR("FAILURE: spawn model, %s, from sdf file: %s", model_name.c_str(), sdf_file_name.c_str());
      return 1;
  }
}

/*  ANCHOR Material
    Function to call the gazebo_ros_link_attacher service to attach the material to the ground_plane with a fixed joint.
*/
void MaterialStack::anchorMaterial(std::string modelName)
{
  ROS_INFO("ANCHOR MATERIAL: %s!", modelName.c_str());
  gazebo_ros_link_attacher::Attach attachMsg;

  attachMsg.request.model_name_1 = modelName;
  attachMsg.request.link_name_1 = "link";
  attachMsg.request.model_name_2 = "ground_plane";
  attachMsg.request.link_name_2 = "link";

  // Set the models for attachment.
  if( _attachMaterialClient.call(attachMsg) )
  {
    ROS_INFO("MATERIAL_STACK: SUCCESS to anchor material!");
  }
  else
  {
    ROS_WARN("MATERIAL_STACK: FAILED to anchor material!");
  }
}

/*  RELEASE Material
    Function to call the gazebo_ros_link_attacher service to detach the material from the ground_plane with a fixed joint.
*/
void MaterialStack::releaseMaterial(std::string modelName)
{
  ROS_INFO("RELEASE MATERIAL: %s!", modelName.c_str());
  gazebo_ros_link_attacher::Attach detachMsg;

  detachMsg.request.model_name_1 = modelName;
  detachMsg.request.link_name_1 = "link";
  detachMsg.request.model_name_2 = "ground_plane";
  detachMsg.request.link_name_2 = "link";

  // Set the models for attachment.
  _detachMaterialClient.call(detachMsg);
}

/*  POP NEXT MATERIAL
    Releases the next material panel from the back of the material vector, which is on top of the current stack.
    Removes the material name from the material vector, so it is not tracked in the stack anymore.
    Returns the material name for the next function to take over.
*/
std::string MaterialStack::popNextMaterial()
{
  std::string materialName = "NOTFOUND";
  if( _materialVec.size() > 0 )
  {
    materialName = _materialVec[_materialVec.size() - 1];
    _materialVec.pop_back();
    releaseMaterial(materialName);    
  }
  else
  {
    ROS_WARN("ATTEMPTED TO POP NEXT MATERIAL NAME FROM EMPTY VECTOR, _materialVec");
  }

  return materialName;
}