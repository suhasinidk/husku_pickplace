// Auto-generated. Do not edit!

// (in-package skiros2_msgs.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Relation = require('../msg/Relation.js');

//-----------------------------------------------------------


//-----------------------------------------------------------

class WmQueryRelationsRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.relation = null;
    }
    else {
      if (initObj.hasOwnProperty('relation')) {
        this.relation = initObj.relation
      }
      else {
        this.relation = new Relation();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type WmQueryRelationsRequest
    // Serialize message field [relation]
    bufferOffset = Relation.serialize(obj.relation, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type WmQueryRelationsRequest
    let len;
    let data = new WmQueryRelationsRequest(null);
    // Deserialize message field [relation]
    data.relation = Relation.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += Relation.getMessageSize(object.relation);
    return length;
  }

  static datatype() {
    // Returns string type for a service object
    return 'skiros2_msgs/WmQueryRelationsRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '1d5c24fa09f95142cb536e02896dc748';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Relation relation
    
    ================================================================================
    MSG: skiros2_msgs/Relation
    string subjectId
    string predicate
    string objectId
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new WmQueryRelationsRequest(null);
    if (msg.relation !== undefined) {
      resolved.relation = Relation.Resolve(msg.relation)
    }
    else {
      resolved.relation = new Relation()
    }

    return resolved;
    }
};

class WmQueryRelationsResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.matches = null;
    }
    else {
      if (initObj.hasOwnProperty('matches')) {
        this.matches = initObj.matches
      }
      else {
        this.matches = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type WmQueryRelationsResponse
    // Serialize message field [matches]
    // Serialize the length for message field [matches]
    bufferOffset = _serializer.uint32(obj.matches.length, buffer, bufferOffset);
    obj.matches.forEach((val) => {
      bufferOffset = Relation.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type WmQueryRelationsResponse
    let len;
    let data = new WmQueryRelationsResponse(null);
    // Deserialize message field [matches]
    // Deserialize array length for message field [matches]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.matches = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.matches[i] = Relation.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.matches.forEach((val) => {
      length += Relation.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'skiros2_msgs/WmQueryRelationsResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '0e325e0b48cc510fd9bcd6b7e064ef48';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Relation[] matches
    
    
    ================================================================================
    MSG: skiros2_msgs/Relation
    string subjectId
    string predicate
    string objectId
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new WmQueryRelationsResponse(null);
    if (msg.matches !== undefined) {
      resolved.matches = new Array(msg.matches.length);
      for (let i = 0; i < resolved.matches.length; ++i) {
        resolved.matches[i] = Relation.Resolve(msg.matches[i]);
      }
    }
    else {
      resolved.matches = []
    }

    return resolved;
    }
};

module.exports = {
  Request: WmQueryRelationsRequest,
  Response: WmQueryRelationsResponse,
  md5sum() { return '5c95783a21284fc96a095a71049fa510'; },
  datatype() { return 'skiros2_msgs/WmQueryRelations'; }
};
