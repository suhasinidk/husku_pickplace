// Auto-generated. Do not edit!

// (in-package skiros2_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Param = require('./Param.js');

//-----------------------------------------------------------

class SkillProgress {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.robot = null;
      this.task_id = null;
      this.id = null;
      this.parent_label = null;
      this.parent_id = null;
      this.type = null;
      this.label = null;
      this.params = null;
      this.processor = null;
      this.state = null;
      this.progress_code = null;
      this.progress_period = null;
      this.progress_time = null;
      this.progress_message = null;
    }
    else {
      if (initObj.hasOwnProperty('robot')) {
        this.robot = initObj.robot
      }
      else {
        this.robot = '';
      }
      if (initObj.hasOwnProperty('task_id')) {
        this.task_id = initObj.task_id
      }
      else {
        this.task_id = 0;
      }
      if (initObj.hasOwnProperty('id')) {
        this.id = initObj.id
      }
      else {
        this.id = 0;
      }
      if (initObj.hasOwnProperty('parent_label')) {
        this.parent_label = initObj.parent_label
      }
      else {
        this.parent_label = '';
      }
      if (initObj.hasOwnProperty('parent_id')) {
        this.parent_id = initObj.parent_id
      }
      else {
        this.parent_id = 0;
      }
      if (initObj.hasOwnProperty('type')) {
        this.type = initObj.type
      }
      else {
        this.type = '';
      }
      if (initObj.hasOwnProperty('label')) {
        this.label = initObj.label
      }
      else {
        this.label = '';
      }
      if (initObj.hasOwnProperty('params')) {
        this.params = initObj.params
      }
      else {
        this.params = [];
      }
      if (initObj.hasOwnProperty('processor')) {
        this.processor = initObj.processor
      }
      else {
        this.processor = '';
      }
      if (initObj.hasOwnProperty('state')) {
        this.state = initObj.state
      }
      else {
        this.state = 0;
      }
      if (initObj.hasOwnProperty('progress_code')) {
        this.progress_code = initObj.progress_code
      }
      else {
        this.progress_code = 0;
      }
      if (initObj.hasOwnProperty('progress_period')) {
        this.progress_period = initObj.progress_period
      }
      else {
        this.progress_period = 0.0;
      }
      if (initObj.hasOwnProperty('progress_time')) {
        this.progress_time = initObj.progress_time
      }
      else {
        this.progress_time = 0.0;
      }
      if (initObj.hasOwnProperty('progress_message')) {
        this.progress_message = initObj.progress_message
      }
      else {
        this.progress_message = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SkillProgress
    // Serialize message field [robot]
    bufferOffset = _serializer.string(obj.robot, buffer, bufferOffset);
    // Serialize message field [task_id]
    bufferOffset = _serializer.int16(obj.task_id, buffer, bufferOffset);
    // Serialize message field [id]
    bufferOffset = _serializer.int16(obj.id, buffer, bufferOffset);
    // Serialize message field [parent_label]
    bufferOffset = _serializer.string(obj.parent_label, buffer, bufferOffset);
    // Serialize message field [parent_id]
    bufferOffset = _serializer.int16(obj.parent_id, buffer, bufferOffset);
    // Serialize message field [type]
    bufferOffset = _serializer.string(obj.type, buffer, bufferOffset);
    // Serialize message field [label]
    bufferOffset = _serializer.string(obj.label, buffer, bufferOffset);
    // Serialize message field [params]
    // Serialize the length for message field [params]
    bufferOffset = _serializer.uint32(obj.params.length, buffer, bufferOffset);
    obj.params.forEach((val) => {
      bufferOffset = Param.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [processor]
    bufferOffset = _serializer.string(obj.processor, buffer, bufferOffset);
    // Serialize message field [state]
    bufferOffset = _serializer.int16(obj.state, buffer, bufferOffset);
    // Serialize message field [progress_code]
    bufferOffset = _serializer.int16(obj.progress_code, buffer, bufferOffset);
    // Serialize message field [progress_period]
    bufferOffset = _serializer.float32(obj.progress_period, buffer, bufferOffset);
    // Serialize message field [progress_time]
    bufferOffset = _serializer.float32(obj.progress_time, buffer, bufferOffset);
    // Serialize message field [progress_message]
    bufferOffset = _serializer.string(obj.progress_message, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SkillProgress
    let len;
    let data = new SkillProgress(null);
    // Deserialize message field [robot]
    data.robot = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [task_id]
    data.task_id = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [id]
    data.id = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [parent_label]
    data.parent_label = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [parent_id]
    data.parent_id = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [type]
    data.type = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [label]
    data.label = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [params]
    // Deserialize array length for message field [params]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.params = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.params[i] = Param.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [processor]
    data.processor = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [state]
    data.state = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [progress_code]
    data.progress_code = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [progress_period]
    data.progress_period = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [progress_time]
    data.progress_time = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [progress_message]
    data.progress_message = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.robot.length;
    length += object.parent_label.length;
    length += object.type.length;
    length += object.label.length;
    object.params.forEach((val) => {
      length += Param.getMessageSize(val);
    });
    length += object.processor.length;
    length += object.progress_message.length;
    return length + 46;
  }

  static datatype() {
    // Returns string type for a message object
    return 'skiros2_msgs/SkillProgress';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '14c02d9b9938298cf43e256d5d334a4c';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    #Possible states
    int16 SUCCESS=1
    int16 FAILURE=2
    int16 RUNNING=3
    int16 IDLE=4
    
    string robot
    int16 task_id
    int16 id
    string parent_label
    int16 parent_id
    string type
    string label
    Param[] params
    string processor
    int16 state
    int16 progress_code
    float32 progress_period
    float32 progress_time
    string progress_message
    
    ================================================================================
    MSG: skiros2_msgs/Param
    string param
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SkillProgress(null);
    if (msg.robot !== undefined) {
      resolved.robot = msg.robot;
    }
    else {
      resolved.robot = ''
    }

    if (msg.task_id !== undefined) {
      resolved.task_id = msg.task_id;
    }
    else {
      resolved.task_id = 0
    }

    if (msg.id !== undefined) {
      resolved.id = msg.id;
    }
    else {
      resolved.id = 0
    }

    if (msg.parent_label !== undefined) {
      resolved.parent_label = msg.parent_label;
    }
    else {
      resolved.parent_label = ''
    }

    if (msg.parent_id !== undefined) {
      resolved.parent_id = msg.parent_id;
    }
    else {
      resolved.parent_id = 0
    }

    if (msg.type !== undefined) {
      resolved.type = msg.type;
    }
    else {
      resolved.type = ''
    }

    if (msg.label !== undefined) {
      resolved.label = msg.label;
    }
    else {
      resolved.label = ''
    }

    if (msg.params !== undefined) {
      resolved.params = new Array(msg.params.length);
      for (let i = 0; i < resolved.params.length; ++i) {
        resolved.params[i] = Param.Resolve(msg.params[i]);
      }
    }
    else {
      resolved.params = []
    }

    if (msg.processor !== undefined) {
      resolved.processor = msg.processor;
    }
    else {
      resolved.processor = ''
    }

    if (msg.state !== undefined) {
      resolved.state = msg.state;
    }
    else {
      resolved.state = 0
    }

    if (msg.progress_code !== undefined) {
      resolved.progress_code = msg.progress_code;
    }
    else {
      resolved.progress_code = 0
    }

    if (msg.progress_period !== undefined) {
      resolved.progress_period = msg.progress_period;
    }
    else {
      resolved.progress_period = 0.0
    }

    if (msg.progress_time !== undefined) {
      resolved.progress_time = msg.progress_time;
    }
    else {
      resolved.progress_time = 0.0
    }

    if (msg.progress_message !== undefined) {
      resolved.progress_message = msg.progress_message;
    }
    else {
      resolved.progress_message = ''
    }

    return resolved;
    }
};

// Constants for message
SkillProgress.Constants = {
  SUCCESS: 1,
  FAILURE: 2,
  RUNNING: 3,
  IDLE: 4,
}

module.exports = SkillProgress;
