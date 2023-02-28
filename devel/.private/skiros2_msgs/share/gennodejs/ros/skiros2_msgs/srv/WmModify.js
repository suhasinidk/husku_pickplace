// Auto-generated. Do not edit!

// (in-package skiros2_msgs.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let WmElement = require('../msg/WmElement.js');

//-----------------------------------------------------------


//-----------------------------------------------------------

class WmModifyRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.author = null;
      this.action = null;
      this.relation_filter = null;
      this.type_filter = null;
      this.context = null;
      this.elements = null;
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
      if (initObj.hasOwnProperty('relation_filter')) {
        this.relation_filter = initObj.relation_filter
      }
      else {
        this.relation_filter = '';
      }
      if (initObj.hasOwnProperty('type_filter')) {
        this.type_filter = initObj.type_filter
      }
      else {
        this.type_filter = '';
      }
      if (initObj.hasOwnProperty('context')) {
        this.context = initObj.context
      }
      else {
        this.context = '';
      }
      if (initObj.hasOwnProperty('elements')) {
        this.elements = initObj.elements
      }
      else {
        this.elements = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type WmModifyRequest
    // Serialize message field [author]
    bufferOffset = _serializer.string(obj.author, buffer, bufferOffset);
    // Serialize message field [action]
    bufferOffset = _serializer.string(obj.action, buffer, bufferOffset);
    // Serialize message field [relation_filter]
    bufferOffset = _serializer.string(obj.relation_filter, buffer, bufferOffset);
    // Serialize message field [type_filter]
    bufferOffset = _serializer.string(obj.type_filter, buffer, bufferOffset);
    // Serialize message field [context]
    bufferOffset = _serializer.string(obj.context, buffer, bufferOffset);
    // Serialize message field [elements]
    // Serialize the length for message field [elements]
    bufferOffset = _serializer.uint32(obj.elements.length, buffer, bufferOffset);
    obj.elements.forEach((val) => {
      bufferOffset = WmElement.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type WmModifyRequest
    let len;
    let data = new WmModifyRequest(null);
    // Deserialize message field [author]
    data.author = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [action]
    data.action = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [relation_filter]
    data.relation_filter = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [type_filter]
    data.type_filter = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [context]
    data.context = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [elements]
    // Deserialize array length for message field [elements]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.elements = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.elements[i] = WmElement.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.author.length;
    length += object.action.length;
    length += object.relation_filter.length;
    length += object.type_filter.length;
    length += object.context.length;
    object.elements.forEach((val) => {
      length += WmElement.getMessageSize(val);
    });
    return length + 24;
  }

  static datatype() {
    // Returns string type for a service object
    return 'skiros2_msgs/WmModifyRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '1b72f32988161c8ca4acc2b375fb1954';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    #Possible actions
    string ADD=add
    string UPDATE=update
    string UPDATE_PROPERTIES=update_properties
    string REMOVE=remove
    string REMOVE_RECURSIVE=remove_recursive
    
    string author
    string action
    string relation_filter
    string type_filter
    string context
    WmElement[] elements
    
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
    const resolved = new WmModifyRequest(null);
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

    if (msg.relation_filter !== undefined) {
      resolved.relation_filter = msg.relation_filter;
    }
    else {
      resolved.relation_filter = ''
    }

    if (msg.type_filter !== undefined) {
      resolved.type_filter = msg.type_filter;
    }
    else {
      resolved.type_filter = ''
    }

    if (msg.context !== undefined) {
      resolved.context = msg.context;
    }
    else {
      resolved.context = ''
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

    return resolved;
    }
};

// Constants for message
WmModifyRequest.Constants = {
  ADD: 'add',
  UPDATE: 'update',
  UPDATE_PROPERTIES: 'update_properties',
  REMOVE: 'remove',
  REMOVE_RECURSIVE: 'remove_recursive',
}

class WmModifyResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.elements = null;
    }
    else {
      if (initObj.hasOwnProperty('elements')) {
        this.elements = initObj.elements
      }
      else {
        this.elements = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type WmModifyResponse
    // Serialize message field [elements]
    // Serialize the length for message field [elements]
    bufferOffset = _serializer.uint32(obj.elements.length, buffer, bufferOffset);
    obj.elements.forEach((val) => {
      bufferOffset = WmElement.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type WmModifyResponse
    let len;
    let data = new WmModifyResponse(null);
    // Deserialize message field [elements]
    // Deserialize array length for message field [elements]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.elements = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.elements[i] = WmElement.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.elements.forEach((val) => {
      length += WmElement.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'skiros2_msgs/WmModifyResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'c9ea1fc652bb3fd8cd1a82d7eaa8b40a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    #ADD/UPDATE/UPDATE_PROPERTIES: return updated elements REMOVE/REMOVE_RECURSIVE: return nothing
    WmElement[] elements
    
    
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
    const resolved = new WmModifyResponse(null);
    if (msg.elements !== undefined) {
      resolved.elements = new Array(msg.elements.length);
      for (let i = 0; i < resolved.elements.length; ++i) {
        resolved.elements[i] = WmElement.Resolve(msg.elements[i]);
      }
    }
    else {
      resolved.elements = []
    }

    return resolved;
    }
};

module.exports = {
  Request: WmModifyRequest,
  Response: WmModifyResponse,
  md5sum() { return '3777804bb09a7d142574f0ae4bc21501'; },
  datatype() { return 'skiros2_msgs/WmModify'; }
};
