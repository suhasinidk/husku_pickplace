// Auto-generated. Do not edit!

// (in-package skiros2_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Property = require('./Property.js');
let Relation = require('./Relation.js');

//-----------------------------------------------------------

class WmElement {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.id = null;
      this.type = null;
      this.label = null;
      this.properties = null;
      this.relations = null;
    }
    else {
      if (initObj.hasOwnProperty('id')) {
        this.id = initObj.id
      }
      else {
        this.id = '';
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
      if (initObj.hasOwnProperty('properties')) {
        this.properties = initObj.properties
      }
      else {
        this.properties = [];
      }
      if (initObj.hasOwnProperty('relations')) {
        this.relations = initObj.relations
      }
      else {
        this.relations = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type WmElement
    // Serialize message field [id]
    bufferOffset = _serializer.string(obj.id, buffer, bufferOffset);
    // Serialize message field [type]
    bufferOffset = _serializer.string(obj.type, buffer, bufferOffset);
    // Serialize message field [label]
    bufferOffset = _serializer.string(obj.label, buffer, bufferOffset);
    // Serialize message field [properties]
    // Serialize the length for message field [properties]
    bufferOffset = _serializer.uint32(obj.properties.length, buffer, bufferOffset);
    obj.properties.forEach((val) => {
      bufferOffset = Property.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [relations]
    // Serialize the length for message field [relations]
    bufferOffset = _serializer.uint32(obj.relations.length, buffer, bufferOffset);
    obj.relations.forEach((val) => {
      bufferOffset = Relation.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type WmElement
    let len;
    let data = new WmElement(null);
    // Deserialize message field [id]
    data.id = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [type]
    data.type = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [label]
    data.label = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [properties]
    // Deserialize array length for message field [properties]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.properties = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.properties[i] = Property.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [relations]
    // Deserialize array length for message field [relations]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.relations = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.relations[i] = Relation.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.id.length;
    length += object.type.length;
    length += object.label.length;
    object.properties.forEach((val) => {
      length += Property.getMessageSize(val);
    });
    object.relations.forEach((val) => {
      length += Relation.getMessageSize(val);
    });
    return length + 20;
  }

  static datatype() {
    // Returns string type for a message object
    return 'skiros2_msgs/WmElement';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '0fefbd22eac0424cfa1c8871ee3990af';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new WmElement(null);
    if (msg.id !== undefined) {
      resolved.id = msg.id;
    }
    else {
      resolved.id = ''
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

    if (msg.properties !== undefined) {
      resolved.properties = new Array(msg.properties.length);
      for (let i = 0; i < resolved.properties.length; ++i) {
        resolved.properties[i] = Property.Resolve(msg.properties[i]);
      }
    }
    else {
      resolved.properties = []
    }

    if (msg.relations !== undefined) {
      resolved.relations = new Array(msg.relations.length);
      for (let i = 0; i < resolved.relations.length; ++i) {
        resolved.relations[i] = Relation.Resolve(msg.relations[i]);
      }
    }
    else {
      resolved.relations = []
    }

    return resolved;
    }
};

module.exports = WmElement;
