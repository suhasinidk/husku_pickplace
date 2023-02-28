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

class WmSetRelationRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.author = null;
      this.relation = null;
      this.value = null;
    }
    else {
      if (initObj.hasOwnProperty('author')) {
        this.author = initObj.author
      }
      else {
        this.author = '';
      }
      if (initObj.hasOwnProperty('relation')) {
        this.relation = initObj.relation
      }
      else {
        this.relation = new Relation();
      }
      if (initObj.hasOwnProperty('value')) {
        this.value = initObj.value
      }
      else {
        this.value = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type WmSetRelationRequest
    // Serialize message field [author]
    bufferOffset = _serializer.string(obj.author, buffer, bufferOffset);
    // Serialize message field [relation]
    bufferOffset = Relation.serialize(obj.relation, buffer, bufferOffset);
    // Serialize message field [value]
    bufferOffset = _serializer.bool(obj.value, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type WmSetRelationRequest
    let len;
    let data = new WmSetRelationRequest(null);
    // Deserialize message field [author]
    data.author = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [relation]
    data.relation = Relation.deserialize(buffer, bufferOffset);
    // Deserialize message field [value]
    data.value = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.author.length;
    length += Relation.getMessageSize(object.relation);
    return length + 5;
  }

  static datatype() {
    // Returns string type for a service object
    return 'skiros2_msgs/WmSetRelationRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '44689b3467290480eb7cf5a420ca4d7c';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string author
    Relation relation
    bool value
    
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
    const resolved = new WmSetRelationRequest(null);
    if (msg.author !== undefined) {
      resolved.author = msg.author;
    }
    else {
      resolved.author = ''
    }

    if (msg.relation !== undefined) {
      resolved.relation = Relation.Resolve(msg.relation)
    }
    else {
      resolved.relation = new Relation()
    }

    if (msg.value !== undefined) {
      resolved.value = msg.value;
    }
    else {
      resolved.value = false
    }

    return resolved;
    }
};

class WmSetRelationResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.ok = null;
    }
    else {
      if (initObj.hasOwnProperty('ok')) {
        this.ok = initObj.ok
      }
      else {
        this.ok = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type WmSetRelationResponse
    // Serialize message field [ok]
    bufferOffset = _serializer.bool(obj.ok, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type WmSetRelationResponse
    let len;
    let data = new WmSetRelationResponse(null);
    // Deserialize message field [ok]
    data.ok = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'skiros2_msgs/WmSetRelationResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '6f6da3883749771fac40d6deb24a8c02';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool ok
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new WmSetRelationResponse(null);
    if (msg.ok !== undefined) {
      resolved.ok = msg.ok;
    }
    else {
      resolved.ok = false
    }

    return resolved;
    }
};

module.exports = {
  Request: WmSetRelationRequest,
  Response: WmSetRelationResponse,
  md5sum() { return '77bf924d023af391d9b60bf1607be75e'; },
  datatype() { return 'skiros2_msgs/WmSetRelation'; }
};
