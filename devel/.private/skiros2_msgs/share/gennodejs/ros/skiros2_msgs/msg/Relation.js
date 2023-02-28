// Auto-generated. Do not edit!

// (in-package skiros2_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class Relation {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.subjectId = null;
      this.predicate = null;
      this.objectId = null;
    }
    else {
      if (initObj.hasOwnProperty('subjectId')) {
        this.subjectId = initObj.subjectId
      }
      else {
        this.subjectId = '';
      }
      if (initObj.hasOwnProperty('predicate')) {
        this.predicate = initObj.predicate
      }
      else {
        this.predicate = '';
      }
      if (initObj.hasOwnProperty('objectId')) {
        this.objectId = initObj.objectId
      }
      else {
        this.objectId = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Relation
    // Serialize message field [subjectId]
    bufferOffset = _serializer.string(obj.subjectId, buffer, bufferOffset);
    // Serialize message field [predicate]
    bufferOffset = _serializer.string(obj.predicate, buffer, bufferOffset);
    // Serialize message field [objectId]
    bufferOffset = _serializer.string(obj.objectId, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Relation
    let len;
    let data = new Relation(null);
    // Deserialize message field [subjectId]
    data.subjectId = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [predicate]
    data.predicate = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [objectId]
    data.objectId = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.subjectId.length;
    length += object.predicate.length;
    length += object.objectId.length;
    return length + 12;
  }

  static datatype() {
    // Returns string type for a message object
    return 'skiros2_msgs/Relation';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '6596e75cd61663ae5bcc18bf41e43915';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new Relation(null);
    if (msg.subjectId !== undefined) {
      resolved.subjectId = msg.subjectId;
    }
    else {
      resolved.subjectId = ''
    }

    if (msg.predicate !== undefined) {
      resolved.predicate = msg.predicate;
    }
    else {
      resolved.predicate = ''
    }

    if (msg.objectId !== undefined) {
      resolved.objectId = msg.objectId;
    }
    else {
      resolved.objectId = ''
    }

    return resolved;
    }
};

module.exports = Relation;
