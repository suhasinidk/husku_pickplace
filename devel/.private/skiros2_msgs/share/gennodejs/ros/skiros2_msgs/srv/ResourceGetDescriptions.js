// Auto-generated. Do not edit!

// (in-package skiros2_msgs.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

let ResourceDescription = require('../msg/ResourceDescription.js');

//-----------------------------------------------------------

class ResourceGetDescriptionsRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ResourceGetDescriptionsRequest
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ResourceGetDescriptionsRequest
    let len;
    let data = new ResourceGetDescriptionsRequest(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a service object
    return 'skiros2_msgs/ResourceGetDescriptionsRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd41d8cd98f00b204e9800998ecf8427e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ResourceGetDescriptionsRequest(null);
    return resolved;
    }
};

class ResourceGetDescriptionsResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.list = null;
    }
    else {
      if (initObj.hasOwnProperty('list')) {
        this.list = initObj.list
      }
      else {
        this.list = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ResourceGetDescriptionsResponse
    // Serialize message field [list]
    // Serialize the length for message field [list]
    bufferOffset = _serializer.uint32(obj.list.length, buffer, bufferOffset);
    obj.list.forEach((val) => {
      bufferOffset = ResourceDescription.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ResourceGetDescriptionsResponse
    let len;
    let data = new ResourceGetDescriptionsResponse(null);
    // Deserialize message field [list]
    // Deserialize array length for message field [list]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.list = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.list[i] = ResourceDescription.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.list.forEach((val) => {
      length += ResourceDescription.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'skiros2_msgs/ResourceGetDescriptionsResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '689dba5a19baf7321e2b246602dfca10';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    ResourceDescription[] list
    
    
    
    
    
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
    const resolved = new ResourceGetDescriptionsResponse(null);
    if (msg.list !== undefined) {
      resolved.list = new Array(msg.list.length);
      for (let i = 0; i < resolved.list.length; ++i) {
        resolved.list[i] = ResourceDescription.Resolve(msg.list[i]);
      }
    }
    else {
      resolved.list = []
    }

    return resolved;
    }
};

module.exports = {
  Request: ResourceGetDescriptionsRequest,
  Response: ResourceGetDescriptionsResponse,
  md5sum() { return '689dba5a19baf7321e2b246602dfca10'; },
  datatype() { return 'skiros2_msgs/ResourceGetDescriptions'; }
};
