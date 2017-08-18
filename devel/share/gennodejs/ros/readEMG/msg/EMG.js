// Auto-generated. Do not edit!

// (in-package readEMG.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class EMG {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.EMG1 = null;
      this.EMG2 = null;
    }
    else {
      if (initObj.hasOwnProperty('EMG1')) {
        this.EMG1 = initObj.EMG1
      }
      else {
        this.EMG1 = 0;
      }
      if (initObj.hasOwnProperty('EMG2')) {
        this.EMG2 = initObj.EMG2
      }
      else {
        this.EMG2 = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type EMG
    // Serialize message field [EMG1]
    bufferOffset = _serializer.int64(obj.EMG1, buffer, bufferOffset);
    // Serialize message field [EMG2]
    bufferOffset = _serializer.int64(obj.EMG2, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type EMG
    let len;
    let data = new EMG(null);
    // Deserialize message field [EMG1]
    data.EMG1 = _deserializer.int64(buffer, bufferOffset);
    // Deserialize message field [EMG2]
    data.EMG2 = _deserializer.int64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 16;
  }

  static datatype() {
    // Returns string type for a message object
    return 'readEMG/EMG';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '6de4f5ec7394cd197be042ac9d31b8b5';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int64 EMG1
    int64 EMG2
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new EMG(null);
    if (msg.EMG1 !== undefined) {
      resolved.EMG1 = msg.EMG1;
    }
    else {
      resolved.EMG1 = 0
    }

    if (msg.EMG2 !== undefined) {
      resolved.EMG2 = msg.EMG2;
    }
    else {
      resolved.EMG2 = 0
    }

    return resolved;
    }
};

module.exports = EMG;
