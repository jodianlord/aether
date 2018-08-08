pragma solidity ^0.4.24;

contract KYCSubmission{
    string public facialHash;
    string public facialURL;
    string public documentHash;
    string public documentURL;
    string public name;
    string public email;
    string public mobile;
    string public identitytype;
    string public nationality;
    string public industry;
    string public occupation;
    string public salutation;
    string public name;
    string public nric;
    string public dob;
    string public gender;
    string public marital;
    string public race;
    string public residence;
    string public add_ress;


    constructor(string facialHash, string facialURL, string documentHash, string documentURL, 
    string name, string email, string mobile, string identitytype, string nationality, string industry,
    string occupation, string salutation, string name, string nric, string dob, string gender, string marital, string race, string residence, string add_ress) public {
        facialHash = face;
        facialURL = faceURL;
    }
    
}