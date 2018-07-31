pragma solidity ^0.4.24;

contract KYCSubmission{
    bytes32 public facialHash;
    string public facialURL;
    constructor(bytes32 face, string faceURL) public {
        facialHash = face;
        facialURL = faceURL;
    }
    
}