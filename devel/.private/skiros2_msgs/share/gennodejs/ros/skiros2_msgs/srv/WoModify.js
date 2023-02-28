// Auto-generated. Do not edit!

// (in-package skiros2_msgs.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Statement = require('../msg/Statement.js');

//-----------------------------------------------------------


//-----------------------------------------------------------

class WoModifyRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.author = null;
      this.context = null;
      this.statements = null;
    }
    else {
      if (initObj.hasOwnProperty('author')) {
        this.author = initObj.author
      }
      else {
        this.author = '';
      }
      if (initObj.hasOwnProperty('context')) {
        this.context = initObj.context
      }
      else {
        this.context = '';
      }
      if (initObj.hasOwnProperty('statements')) {
        this.statements = initObj.statements
      }
      else {
        this.statements = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type WoModifyRequest
    // Serialize message field [author]
    bufferOffset = _serializer.string(obj.author, buffer, bufferOffset);
    // Serialize message field [context]
    bufferOffset = _serializer.string(obj.context, buffer, bufferOffset);
    // Serialize message field [statements]
    // Serialize the length for message field [statements]
    bufferOffset = _serializer.uint32(obj.statements.length, buffer, bufferOffset);
    obj.statements.forEach((val) => {
      bufferOffset = Statement.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type WoModifyRequest
    let len;
    let data = new WoModifyRequest(null);
    // Deserialize message field [author]
    data.author = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [context]
    data.context = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [statements]
    // Deserialize array length for message field [statements]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.statements = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.statements[i] = Statement.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.author.length;
    length += object.context.length;
    object.statements.forEach((val) => {
      length += Statement.getMessageSize(val);
    });
    return length + 12;
  }

  static datatype() {
    // Returns string type for a service object
    return 'skiros2_msgs/WoModifyRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'ae5ca50ece4044e5cd8d6e80e9e08383';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string author
    string context
    Statement[] statements
    
    ================================================================================
    MSG: skiros2_msgs/Statement
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
    const resolved = new WoModifyRequest(null);
    if (msg.author !== undefined) {
      resolved.author = msg.author;
    }
    else {
      resolved.author = ''
    }

    if (msg.context !== undefined) {
      resolved.context = msg.context;
    }
    else {
      resolved.context = ''
    }

    if (msg.statements !== undefined) {
      resolved.statements = new Array(msg.statements.length);
      for (let i = 0; i < resolved.statements.length; ++i) {
        resolved.statements[i] = Statement.Resolve(msg.statements[i]);
      }
    }
    else {
      resolved.statements = []
    }

    return resolved;
    }
};

class WoModifyResponse {
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
    // Serializes a message object of type WoModifyResponse
    // Serialize message field [ok]
    bufferOffset = _serializer.bool(obj.ok, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type WoModifyResponse
    let len;
    let data = new WoModifyResponse(null);
    // Deserialize message field [ok]
    data.ok = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'skiros2_msgs/WoModifyResponse';
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
    const resolved = new WoModifyResponse(null);
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
  Request: WoModifyRequest,
  Response: WoModifyResponse,
  md5sum() { return 'dd76bb6e56a5980cc554cb4a6047bd97'; },
  datatype() { return 'skiros2_msgs/WoModify'; }
};
