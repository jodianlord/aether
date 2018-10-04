/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var json = {
    title: "Aether Gamification Quiz",
    showProgressBar: "bottom",
    showTimerPanel: "top",
    maxTimeToFinishPage: 60,
    maxTimeToFinish: 360,
    firstPageIsStarted: true,
    startSurveyText: "Start Quiz",
    pages: [
        {
            questions: [
                {
                    type: "html",
                    html: "You are about to start quiz for Aether. <br/>You have 10 seconds for every page and 25 seconds for the whole survey of 3 questions.<br/>Please click on <b>'Start Quiz'</b> button when you are ready."
                }
            ]
        }, {
            questions: [
                {
                    type: "radiogroup",
                    name: "Aether",
                    title: "How does Aether store the consumer initial data inputted by the KYC Agent (7-11 Staff)",
                    choices: [
                        "By attaching the information to a blockchain", "By storing it in a MySQL database", "By using HTML Session", "It doesn't store the information"
                    ],
                    correctAnswer: "By attaching the information to a blockchain"
                }
            ]
        }, {
            questions: [
                {
                    type: "radiogroup",
                    name: "binFile",
                    title: "Which information is not stored in the bin file that is send out to the consumer email.",
                    choicesOrder: "random",
                    choices: [
                        "Marital Status", "NRIC", "Username", "Gender"
                    ],
                    correctAnswer: "Username"
                }
            ]
        }, {
            maxTimeToFinish: 360,
            questions: [
                {
                    type: "radiogroup",
                    name: "FR",
                    title: "What are the 2FA Methods that Aether has implemented?",
                    choicesOrder: "random",
                    choices: [
                        "OTP and QR Code Scan", "OTP and Facial Recognition", "TouchID and Facial Recognition", "Touch ID and QR Code Scan"
                    ],
                    correctAnswer: "OTP and Facial Recognition"
                }
            ]
        }
    ],
    completedHtml: "<h4>You have answered correctly <b>{correctedAnswers}</b> questions from <b>{questionCount}</b>.</h4>"
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
