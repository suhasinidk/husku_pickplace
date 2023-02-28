// Auto-generated. Do not edit!

// (in-package skiros2_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Relation = require('./Relation.js');

//-----------------------------------------------------------

class Statement {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.relation = null;
      this.value = null;
    }
    else {
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
    // Serializes a message object of type Statement
    // Serialize message field [relation]
    bufferOffset = Relation.serialize(obj.relation, buffer, bufferOffset);
    // Serialize message field [value]
    bufferOffset = _serializer.bool(obj.value, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Statement
    let len;
    let data = new Statement(null);
    // Deserialize message field [relation]
    data.relation = Relation.deserialize(buffer, bufferOffset);
    // Deserialize message field [value]
    data.value = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += Relation.getMessageSize(object.relation);
    return length + 1;
  }

  static datatype() {
    // Returns string type for a message object
    return 'skiros2_msgs/Statement';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '052db037d902fbb67131a3c41b93b371';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new Statement(null);
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

module.exports = Statement;
