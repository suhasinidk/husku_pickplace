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

class WmGetRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.action = null;
      this.context = null;
      this.element = null;
      this.relation_filter = null;
      this.type_filter = null;
    }
    else {
      if (initObj.hasOwnProperty('action')) {
        this.action = initObj.action
      }
      else {
        this.action = '';
      }
      if (initObj.hasOwnProperty('context')) {
        this.context = initObj.context
      }
      else {
        this.context = '';
      }
      if (initObj.hasOwnProperty('element')) {
        this.element = initObj.element
      }
      else {
        this.element = new WmElement();
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
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type WmGetRequest
    // Serialize message field [action]
    bufferOffset = _serializer.string(obj.action, buffer, bufferOffset);
    // Serialize message field [context]
    bufferOffset = _serializer.string(obj.context, buffer, bufferOffset);
    // Serialize message field [element]
    bufferOffset = WmElement.serialize(obj.element, buffer, bufferOffset);
    // Serialize message field [relation_filter]
    bufferOffset = _serializer.string(obj.relation_filter, buffer, bufferOffset);
    // Serialize message field [type_filter]
    bufferOffset = _serializer.string(obj.type_filter, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type WmGetRequest
    let len;
    let data = new WmGetRequest(null);
    // Deserialize message field [action]
    data.action = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [context]
    data.context = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [element]
    data.element = WmElement.deserialize(buffer, bufferOffset);
    // Deserialize message field [relation_filter]
    data.relation_filter = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [type_filter]
    data.type_filter = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.action.length;
    length += object.context.length;
    length += WmElement.getMessageSize(object.element);
    length += object.relation_filter.length;
    length += object.type_filter.length;
    return length + 16;
  }

  static datatype() {
    // Returns string type for a service object
    return 'skiros2_msgs/WmGetRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '9c9b805060dd287fc93adef8c3d20d63';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    #Possible actions
    string GET=get
    string GET_TEMPLATE=get_template
    string RESOLVE=resolve
    string GET_RECURSIVE=get_recursive
    
    string action
    string context
    WmElement element
    string relation_filter
    string type_filter
    
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
    const resolved = new WmGetRequest(null);
    if (msg.action !== undefined) {
      resolved.action = msg.action;
    }
    else {
      resolved.action = ''
    }

    if (msg.context !== undefined) {
      resolved.context = msg.context;
    }
    else {
      resolved.context = ''
    }

    if (msg.element !== undefined) {
      resolved.element = WmElement.Resolve(msg.element)
    }
    else {
      resolved.element = new WmElement()
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

    return resolved;
    }
};

// Constants for message
WmGetRequest.Constants = {
  GET: 'get',
  GET_TEMPLATE: 'get_template',
  RESOLVE: 'resolve',
  GET_RECURSIVE: 'get_recursive',
}

class WmGetResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.snapshot_id = null;
      this.elements = null;
    }
    else {
      if (initObj.hasOwnProperty('snapshot_id')) {
        this.snapshot_id = initObj.snapshot_id
      }
      else {
        this.snapshot_id = '';
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
    // Serializes a message object of type WmGetResponse
    // Serialize message field [snapshot_id]
    bufferOffset = _serializer.string(obj.snapshot_id, buffer, bufferOffset);
    // Serialize message field [elements]
    // Serialize the length for message field [elements]
    bufferOffset = _serializer.uint32(obj.elements.length, buffer, bufferOffset);
    obj.elements.forEach((val) => {
      bufferOffset = WmElement.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type WmGetResponse
    let len;
    let data = new WmGetResponse(null);
    // Deserialize message field [snapshot_id]
    data.snapshot_id = _deserializer.string(buffer, bufferOffset);
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
    length += object.snapshot_id.length;
    object.elements.forEach((val) => {
      length += WmElement.getMessageSize(val);
    });
    return length + 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'skiros2_msgs/WmGetResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '003bbf6f7591f47275b870fefed73403';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string snapshot_id
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
    const resolved = new WmGetResponse(null);
    if (msg.snapshot_id !== undefined) {
      resolved.snapshot_id = msg.snapshot_id;
    }
    else {
      resolved.snapshot_id = ''
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

module.exports = {
  Request: WmGetRequest,
  Response: WmGetResponse,
  md5sum() { return 'a03c7fe28a0cdf8073d54434e678721d'; },
  datatype() { return 'skiros2_msgs/WmGet'; }
};
