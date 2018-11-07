/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

//set qns using ajax
var questionOne = "";
var questionTwo = "";
var questionThree = "";

var questionOneID = "";
var questionTwoID = "";
var questionThreeID = "";

var choicesOne = "";
var choicesTwo = "";
var choicesThree = "";

var answerOne = "";
var answerTwo = "";
var answerThree = "";



var createJson = {};

$.ajax({
    url: "./QuizServlet",
    type: "POST",
    data: JSON.stringify(createJson),
    contentType: "application/json",
    success: function (data) {
        var arr = data.setA;
        console.log(arr);
        var qOne = arr[0];
        
        questionOneID = qOne.questionID;
        questionOne = qOne.question;
        choicesOne = qOne.choices;
        answerOne = "'"+qOne.answer+"'";
        
        //console.log(questionOneID+">>"+questionOne+">>"+choicesOne+">>"+answerOne);
        /*
         populateQns.put("questionID", qnsIDString);
         populateQns.put("question", questionQ1);
         populateQns.put("choices", choicesQ1);
         populateQns.put("answer", questionAnsQ1);
         */
        var qTwo = arr[1];
        var qThree = arr[2]
        //console.log(objOne.question);
    },
    error: function (xhr) {
        console.log(xhr);
        $.alert({
            title: 'Failure!',
            content: 'Quiz Error!',
        });
    }
});


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
        },
        {
            questions: [
                {
                    type: "html",
                    html: "<b>What is a Know-Your-Customer (KYC) process?</b></br></br>KYC is a process by which banks obtain information about the identity and address of customers. This process helps to ensure that banks' services are not misused, hence when you open a new bank account, you will be asked to provide a proof of identity and/or address.</br></br>By first verifying customers' identities and then understanding their transaction patterns,banks are more able to pinpoint suspicious activities.",

                }

            ]},

        {
            questions: [
                {
                    type: "radiogroup",
                    name: "Aether",
                    title: answerOne,//"How does Aether store the consumer initial data inputted by the KYC Agent (7-11 Staff)",
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
var timeEl = document.getElementById("timeEl");
var timerId = null;

function renderTime(val) {
    if (!timeEl)
        return;
    var hours = Math.floor(val / 3600);
    var minutes = Math.floor((val - (hours * 3600)) / 60);
    var seconds = Math.floor(val % 60);
    var timeText = hours + ":" + minutes + ":" + seconds;
    timeEl.innerHTML = timeText;
}

function timerCallback() {
    var page = window.survey.currentPage;
    if (!page)
        return;
    var valueName = "pageNo" + window.survey.pages.indexOf(page);
    var seconds = window.survey.getValue(valueName);
    if (seconds == null)
        seconds = 0;
    else
        seconds++;
    //outcome += '{ "pageNo":'+ window.survey.pages.indexOf(page)+',"seconds"+'+ seconds+'}';
    window.survey.setValue(valueName, seconds);
    renderTime(seconds)
}

window.survey.onCurrentPageChanged.add(function () {
    timerCallback();
});
window.survey.onComplete.add(function (result) {
    document.querySelector('#surveyResult')
            .innerHTML = "result: " + JSON.stringify(result.data);


    document.getElementById("timeInfo").style.display = "none";
    clearInterval(timerId);
    //document.querySelector('#surveyResult').innerHTML = "result: " + JSON.stringify(result.data);
});


$("#surveyElement").Survey({
    model: window.survey
});

timerCallback();
timerId = window.setInterval(function () {
    timerCallback();
}, 1000);