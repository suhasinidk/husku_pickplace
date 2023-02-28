// Auto-generated. Do not edit!

// (in-package skiros2_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let WmElement = require('./WmElement.js');
let Relation = require('./Relation.js');

//-----------------------------------------------------------

class WmMonitor {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.prev_snapshot_id = null;
      this.snapshot_id = null;
      this.stamp = null;
      this.author = null;
      this.action = null;
      this.elements = null;
      this.relation = null;
    }
    else {
      if (initObj.hasOwnProperty('prev_snapshot_id')) {
        this.prev_snapshot_id = initObj.prev_snapshot_id
      }
      else {
        this.prev_snapshot_id = '';
      }
      if (initObj.hasOwnProperty('snapshot_id')) {
        this.snapshot_id = initObj.snapshot_id
      }
      else {
        this.snapshot_id = '';
      }
      if (initObj.hasOwnProperty('stamp')) {
        this.stamp = initObj.stamp
      }
      else {
        this.stamp = {secs: 0, nsecs: 0};
      }
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
      if (initObj.hasOwnProperty('elements')) {
        this.elements = initObj.elements
      }
      else {
        this.elements = [];
      }
      if (initObj.hasOwnProperty('relation')) {
        this.relation = initObj.relation
      }
      else {
        this.relation = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type WmMonitor
    // Serialize message field [prev_snapshot_id]
    bufferOffset = _serializer.string(obj.prev_snapshot_id, buffer, bufferOffset);
    // Serialize message field [snapshot_id]
    bufferOffset = _serializer.string(obj.snapshot_id, buffer, bufferOffset);
    // Serialize message field [stamp]
    bufferOffset = _serializer.time(obj.stamp, buffer, bufferOffset);
    // Serialize message field [author]
    bufferOffset = _serializer.string(obj.author, buffer, bufferOffset);
    // Serialize message field [action]
    bufferOffset = _serializer.string(obj.action, buffer, bufferOffset);
    // Serialize message field [elements]
    // Serialize the length for message field [elements]
    bufferOffset = _serializer.uint32(obj.elements.length, buffer, bufferOffset);
    obj.elements.forEach((val) => {
      bufferOffset = WmElement.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [relation]
    // Serialize the length for message field [relation]
    bufferOffset = _serializer.uint32(obj.relation.length, buffer, bufferOffset);
    obj.relation.forEach((val) => {
      bufferOffset = Relation.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type WmMonitor
    let len;
    let data = new WmMonitor(null);
    // Deserialize message field [prev_snapshot_id]
    data.prev_snapshot_id = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [snapshot_id]
    data.snapshot_id = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [stamp]
    data.stamp = _deserializer.time(buffer, bufferOffset);
    // Deserialize message field [author]
    data.author = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [action]
    data.action = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [elements]
    // Deserialize array length for message field [elements]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.elements = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.elements[i] = WmElement.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [relation]
    // Deserialize array length for message field [relation]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.relation = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.relation[i] = Relation.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.prev_snapshot_id.length;
    length += object.snapshot_id.length;
    length += object.author.length;
    length += object.action.length;
    object.elements.forEach((val) => {
      length += WmElement.getMessageSize(val);
    });
    object.relation.forEach((val) => {
      length += Relation.getMessageSize(val);
    });
    return length + 32;
  }

  static datatype() {
    // Returns string type for a message object
    return 'skiros2_msgs/WmMonitor';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'ecc40ec88cb57baaf7cf8c07fd40a3c7';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    #Possible actions
    string ADD=add
    string UPDATE=update
    string REMOVE=remove
    string RESET=reset
    
    #Metadata
    string prev_snapshot_id
    string snapshot_id
    time stamp
    #Change
    string author
    string action
    WmElement[] elements
    Relation[] relation
    
    ================================================================================
    MSG: skiros2_msgs/WmElement
    string id
    string type
    string label
    Property[] properties
    Relation[] relations
    
    ================================================================================
    MSG: skiros2_msgs/Property
    string key
    string dataValue
    string dataType
    
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
    const resolved = new WmMonitor(null);
    if (msg.prev_snapshot_id !== undefined) {
      resolved.prev_snapshot_id = msg.prev_snapshot_id;
    }
    else {
      resolved.prev_snapshot_id = ''
    }

    if (msg.snapshot_id !== undefined) {
      resolved.snapshot_id = msg.snapshot_id;
    }
    else {
      resolved.snapshot_id = ''
    }

    if (msg.stamp !== undefined) {
      resolved.stamp = msg.stamp;
    }
    else {
      resolved.stamp = {secs: 0, nsecs: 0}
    }

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

    if (msg.elements !== undefined) {
      resolved.elements = new Array(msg.elements.length);
      for (let i = 0; i < resolved.elements.length; ++i) {
        resolved.elements[i] = WmElement.Resolve(msg.elements[i]);
      }
    }
    else {
      resolved.elements = []
    }

    if (msg.relation !== undefined) {
      resolved.relation = new Array(msg.relation.length);
      for (let i = 0; i < resolved.relation.length; ++i) {
        resolved.relation[i] = Relation.Resolve(msg.relation[i]);
      }
    }
    else {
      resolved.relation = []
    }

    return resolved;
    }
};

// Constants for message
WmMonitor.Constants = {
  ADD: 'add',
  UPDATE: 'update',
  REMOVE: 'remove',
  RESET: 'reset',
}

module.exports = WmMonitor;
