// Auto-generated. Do not edit!

// (in-package skiros2_msgs.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class WoQueryRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.query_string = null;
      this.context = null;
      this.cut_prefix = null;
    }
    else {
      if (initObj.hasOwnProperty('query_string')) {
        this.query_string = initObj.query_string
      }
      else {
        this.query_string = '';
      }
      if (initObj.hasOwnProperty('context')) {
        this.context = initObj.context
      }
      else {
        this.context = '';
      }
      if (initObj.hasOwnProperty('cut_prefix')) {
        this.cut_prefix = initObj.cut_prefix
      }
      else {
        this.cut_prefix = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type WoQueryRequest
    // Serialize message field [query_string]
    bufferOffset = _serializer.string(obj.query_string, buffer, bufferOffset);
    // Serialize message field [context]
    bufferOffset = _serializer.string(obj.context, buffer, bufferOffset);
    // Serialize message field [cut_prefix]
    bufferOffset = _serializer.bool(obj.cut_prefix, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type WoQueryRequest
    let len;
    let data = new WoQueryRequest(null);
    // Deserialize message field [query_string]
    data.query_string = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [context]
    data.context = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [cut_prefix]
    data.cut_prefix = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.query_string.length;
    length += object.context.length;
    return length + 9;
  }

  static datatype() {
    // Returns string type for a service object
    return 'skiros2_msgs/WoQueryRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'c6bf0050b43eab21fbaf5842a4df0749';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    #World Ontology query message
    #Std Owl query (use SPARQL syntax, e.g. "SELECT ?x WHERE { ?x rdf:type stmn:GraspingPose. }")
    string query_string
    string context
    bool cut_prefix
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new WoQueryRequest(null);
    if (msg.query_string !== undefined) {
      resolved.query_string = msg.query_string;
    }
    else {
      resolved.query_string = ''
    }

    if (msg.context !== undefined) {
      resolved.context = msg.context;
    }
    else {
      resolved.context = ''
    }

    if (msg.cut_prefix !== undefined) {
      resolved.cut_prefix = msg.cut_prefix;
    }
    else {
      resolved.cut_prefix = false
    }

    return resolved;
    }
};

class WoQueryResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.answer = null;
    }
    else {
      if (initObj.hasOwnProperty('answer')) {
        this.answer = initObj.answer
      }
      else {
        this.answer = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type WoQueryResponse
    // Serialize message field [answer]
    bufferOffset = _arraySerializer.string(obj.answer, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type WoQueryResponse
    let len;
    let data = new WoQueryResponse(null);
    // Deserialize message field [answer]
    data.answer = _arrayDeserializer.string(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.answer.forEach((val) => {
      length += 4 + val.length;
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'skiros2_msgs/WoQueryResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b064fb0dbfe4fa28872303bf43abb2c5';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    #Owl answer (with matches separated by endline)
    string[] answer
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new WoQueryResponse(null);
    if (msg.answer !== undefined) {
      resolved.answer = msg.answer;
    }
    else {
      resolved.answer = []
    }

    return resolved;
    }
};

module.exports = {
  Request: WoQueryRequest,
  Response: WoQueryResponse,
  md5sum() { return 'c279e11806ad32f0e36af84c5a02aba8'; },
  datatype() { return 'skiros2_msgs/WoQuery'; }
};
