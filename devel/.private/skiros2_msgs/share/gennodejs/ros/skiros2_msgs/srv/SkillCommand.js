// Auto-generated. Do not edit!

// (in-package skiros2_msgs.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let ResourceDescription = require('../msg/ResourceDescription.js');

//-----------------------------------------------------------


//-----------------------------------------------------------

class SkillCommandRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.author = null;
      this.action = null;
      this.execution_id = null;
      this.skills = null;
    }
    else {
      if (initObj.hasOwnProperty('author')) {
        this.author = initObj.author
      }
      else {
        this.author = '';
      }
      if (initObj.hasOwnProperty('action')) {
        this.action = initObj.action
      }
      else {
        this.action = '';
      }
      if (initObj.hasOwnProperty('execution_id')) {
        this.execution_id = initObj.execution_id
      }
      else {
        this.execution_id = 0;
      }
      if (initObj.hasOwnProperty('skills')) {
        this.skills = initObj.skills
      }
      else {
        this.skills = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SkillCommandRequest
    // Serialize message field [author]
    bufferOffset = _serializer.string(obj.author, buffer, bufferOffset);
    // Serialize message field [action]
    bufferOffset = _serializer.string(obj.action, buffer, bufferOffset);
    // Serialize message field [execution_id]
    bufferOffset = _serializer.int16(obj.execution_id, buffer, bufferOffset);
    // Serialize message field [skills]
    // Serialize the length for message field [skills]
    bufferOffset = _serializer.uint32(obj.skills.length, buffer, bufferOffset);
    obj.skills.forEach((val) => {
      bufferOffset = ResourceDescription.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SkillCommandRequest
    let len;
    let data = new SkillCommandRequest(null);
    // Deserialize message field [author]
    data.author = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [action]
    data.action = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [execution_id]
    data.execution_id = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [skills]
    // Deserialize array length for message field [skills]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.skills = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.skills[i] = ResourceDescription.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.author.length;
    length += object.action.length;
    object.skills.forEach((val) => {
      length += ResourceDescription.getMessageSize(val);
    });
    return length + 14;
  }

  static datatype() {
    // Returns string type for a service object
    return 'skiros2_msgs/SkillCommandRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '9107465980fa919ff27238186f101996';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    #Possible actions
    string START=start
    string PAUSE=pause
    string PREEMPT=preempt
    string TICK_ONCE=tick_once
    
    string author 			            #Author of the action
    string action				            #Action to perform
    int16 execution_id
    ResourceDescription[] skills
    
    ================================================================================
    MSG: skiros2_msgs/ResourceDescription
    string type
    string name
    Param[] params
    
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
    const resolved = new SkillCommandRequest(null);
    if (msg.author !== undefined) {
      resolved.author = msg.author;
    }
    else {
      resolved.author = ''
    }

    if (msg.action !== undefined) {
      resolved.action = msg.action;
    }
    else {
      resolved.action = ''
    }

    if (msg.execution_id !== undefined) {
      resolved.execution_id = msg.execution_id;
    }
    else {
      resolved.execution_id = 0
    }

    if (msg.skills !== undefined) {
      resolved.skills = new Array(msg.skills.length);
      for (let i = 0; i < resolved.skills.length; ++i) {
        resolved.skills[i] = ResourceDescription.Resolve(msg.skills[i]);
      }
    }
    else {
      resolved.skills = []
    }

    return resolved;
    }
};

// Constants for message
SkillCommandRequest.Constants = {
  START: 'start',
  PAUSE: 'pause',
  PREEMPT: 'preempt',
  TICK_ONCE: 'tick_once',
}

class SkillCommandResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.ok = null;
      this.execution_id = null;
    }
    else {
      if (initObj.hasOwnProperty('ok')) {
        this.ok = initObj.ok
      }
      else {
        this.ok = false;
      }
      if (initObj.hasOwnProperty('execution_id')) {
        this.execution_id = initObj.execution_id
      }
      else {
        this.execution_id = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SkillCommandResponse
    // Serialize message field [ok]
    bufferOffset = _serializer.bool(obj.ok, buffer, bufferOffset);
    // Serialize message field [execution_id]
    bufferOffset = _serializer.int16(obj.execution_id, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SkillCommandResponse
    let len;
    let data = new SkillCommandResponse(null);
    // Deserialize message field [ok]
    data.ok = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [execution_id]
    data.execution_id = _deserializer.int16(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 3;
  }

  static datatype() {
    // Returns string type for a service object
    return 'skiros2_msgs/SkillCommandResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '39fa93da1f696211b1743331912b2e48';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool ok
    int16 execution_id
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SkillCommandResponse(null);
    if (msg.ok !== undefined) {
      resolved.ok = msg.ok;
    }
    else {
      resolved.ok = false
    }

    if (msg.execution_id !== undefined) {
      resolved.execution_id = msg.execution_id;
    }
    else {
      resolved.execution_id = 0
    }

    return resolved;
    }
};

module.exports = {
  Request: SkillCommandRequest,
  Response: SkillCommandResponse,
  md5sum() { return '1150e5b3a081e2e52deee5d82d9efb98'; },
  datatype() { return 'skiros2_msgs/SkillCommand'; }
};
