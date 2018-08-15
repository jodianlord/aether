pragma solidity ^0.4.2;

contract KYC{
    string public uuid;
    string public hash;
    bool public verified = false;
    
    constructor(string id, string ha) public{
        uuid = id;
        hash = ha;
    }
    
    function setVerified() public{
        verified = true;
    }
}