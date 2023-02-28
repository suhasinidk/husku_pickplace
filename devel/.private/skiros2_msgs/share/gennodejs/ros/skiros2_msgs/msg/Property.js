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

class Property {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.key = null;
      this.dataValue = null;
      this.dataType = null;
    }
    else {
      if (initObj.hasOwnProperty('key')) {
        this.key = initObj.key
      }
      else {
        this.key = '';
      }
      if (initObj.hasOwnProperty('dataValue')) {
        this.dataValue = initObj.dataValue
      }
      else {
        this.dataValue = '';
      }
      if (initObj.hasOwnProperty('dataType')) {
        this.dataType = initObj.dataType
      }
      else {
        this.dataType = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Property
    // Serialize message field [key]
    bufferOffset = _serializer.string(obj.key, buffer, bufferOffset);
    // Serialize message field [dataValue]
    bufferOffset = _serializer.string(obj.dataValue, buffer, bufferOffset);
    // Serialize message field [dataType]
    bufferOffset = _serializer.string(obj.dataType, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Property
    let len;
    let data = new Property(null);
    // Deserialize message field [key]
    data.key = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [dataValue]
    data.dataValue = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [dataType]
    data.dataType = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.key.length;
    length += object.dataValue.length;
    length += object.dataType.length;
    return length + 12;
  }

  static datatype() {
    // Returns string type for a message object
    return 'skiros2_msgs/Property';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '5b6c0ddf599766e37ee213fe87f04771';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string key
    string dataValue
    string dataType
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Property(null);
    if (msg.key !== undefined) {
      resolved.key = msg.key;
    }
    else {
      resolved.key = ''
    }

    if (msg.dataValue !== undefined) {
      resolved.dataValue = msg.dataValue;
    }
    else {
      resolved.dataValue = ''
    }

    if (msg.dataType !== undefined) {
      resolved.dataType = msg.dataType;
    }
    else {
      resolved.dataType = ''
    }

    return resolved;
    }
};

module.exports = Property;
