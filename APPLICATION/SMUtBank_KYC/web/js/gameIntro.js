/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(window).on('load',function(){
    $('#myModal').modal('show');
});

var json = {
    
    showProgressBar: "bottom",
    cookieName: "myuniquesurveyid",
    maxTimeToFinishPage: 0,
    maxTimeToFinish: 0,
    firstPageIsStarted: true,
    startSurveyText: "Start",
    pages: [
        {
            questions: [
                {
                    type: "html",
                    html: "You are about to start Aether's Learning Module. <br/><br/>Please click on <b>'Start'</b> button when you are ready."
                }
            ]
        }, {
            questions: [
                {
                    type: "html",
                    html : "<b>What is a Know-Your-Customer (KYC) process?</b></br></br>KYC is a process by which banks obtain information about the identity and address of customers. This process helps to ensure that banks' services are not misused, hence when you open a new bank account, you will be asked to provide a proof of identity and/or address.</br></br>By first verifying customers' identities and then understanding their transaction patterns,banks are more able to pinpoint suspicious activities.",
                    
                }
            ]
        }, {
            questions: [
                    {
                    type: "html",
                    html : "<b>What is a 'KYC agent'?</b></br></br>A KYC agent is a 3rd party personnel authorised by a central authority to collect personal particulars of potential banking customers so as create digital identity for them.</br></br><b>As a KYC Agent, your role is to:</b></br><ul></br><li>>Key in the customer particulars</li><li>>Upload the scan of the customer personal identification document</li><li>>Take a facial photograph of the customer</li></ui></br></br>",
                    
                }
            ]
        }, {
            questions: [
               {
                    type: "html",
                    html : "<b>Why capture all this information?</b></br></br><b>Personal Particulars: </b> All the basic information of the customer. This would streamline the application process when the customer applies to set up a bank account. </br></br><b>Scan of identification document:</b> Physical proof that the customer is who he/she claim to be. Can also be used for banking compliance.</br></br><b>Facial Photograph of customer: </b> Physical proof that customer was there to create digital identity. Also provides a reference image for facial recognition as part of 2 factor authentication when creating a bank account.",
                    
                }
            ]
        },
        {
            questions: [
                {
                    type: "radiogroup",
                    name: "Aether",
                    title: "How does Aether store the consumer initial data inputted by the KYC Agent (7-11 Staff)",
                    isRequired: true,
                    choices: [
                        "By attaching the information to a blockchain", "By storing it in a MySQL database", "By using HTML Session", "It doesn't store the information"
                    ],
                    correctAnswer: "By attaching the information to a blockchain"
                }
                
            ]
        
        },
        {
            questions: [
                {
                    type: "radiogroup",
                    name: "binFile",
                    title: "Which information is not stored in the bin file that is send out to the consumer email.",
                    isRequired: true,
                    choicesOrder: "random",
                    choices: [
                        "Marital Status", "NRIC", "Username", "Gender"
                    ],
                    correctAnswer: "Username"
                }
                
            ]
        }
        ,
        {
            questions: [
                {
                    type: "radiogroup",
                    name: "FR",
                    title: "What are the 2FA Methods that Aether has implemented?",
                    isRequired: true,
                    choicesOrder: "random",
                    choices: [
                        "OTP and QR Code Scan", "OTP and Facial Recognition", "TouchID and Facial Recognition", "Touch ID and QR Code Scan"
                    ],
                    correctAnswer: "OTP and Facial Recognition"
                }
                
            ]
        }
    ],
    completedHtml: "<h4>Lets begin to create your first digital identity!</h4></br><h4>You have answered correctly <b>{correctedAnswers}</b> questions from <b>{questionCount}</b>.</h4>"
};

window.survey = new Survey.Model(json);

survey
    .onComplete
    .add(function (result) {
        document
            .querySelector('#surveyResult')
            .innerHTML = "result: " + JSON.stringify(result.data);
    });

$("#surveyElement").Survey({model: survey});
 

