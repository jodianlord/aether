pragma solidity ^0.4.24;

contract KYCSubmission{
    bytes32 public facialHash;
    string public facialURL;
    bytes32 public documentHash;
    string public documentURL;
    string public name;
    string public email;

    constructor(bytes32 face, string faceURL) public {
        facialHash = face;
        facialURL = faceURL;
    }
    
}