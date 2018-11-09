/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(window).on('load', function () {
    $('#myModal').modal('show');
});



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

var groupID1 = groupID;
console.log("groupID = " + groupID1)

var createJson = {};

$.ajax({
    url: "./QuizServlet",
    async :false,
    type: "POST",
    data: JSON.stringify(createJson),
    contentType: "application/json",
    success: function (data) {
        var arr = data.setA;
        //console.log(arr);
        var qOne = arr[0];
        //console.log("ffffff>>>>" + qOne);
        questionOneID = qOne.questionID;
        questionOne = qOne.question;
        choicesOne = qOne.choices;
        var choicesArr = choicesOne.split("&&");
        answerOne = qOne.answer;

        var qTwo = arr[1];
        questionTwoID = qTwo.questionID;
        questionTwo = qTwo.question;
        choicesTwo = qTwo.choices;
        var choicesArrTwo = choicesTwo.split("&&");
        answerTwo = qTwo.answer;


        var qThree = arr[2];
        questionThreeID = qThree.questionID;
        questionThree = qThree.question;
        choicesThree = qThree.choices;
        var choicesArrThree = choicesThree.split("&&");
        answerTwo = qThree.answer;
        //console.log(objOne.question);
        var json = {

            title: "Aether Gamification Quiz",
            showProgressBar: "bottom",
            showTimerPanel: "top",
            maxTimeToFinishPage: 60,
            maxTimeToFinish: 360,
            firstPageIsStarted: true, //true
            startSurveyText: "Start Quiz",
            pages: [
                {
                    questions: [
                        {
                            type: "html",
                            html: "You are about to start quiz for Aether. <br/>You have 60 seconds for every page and 6 minutes for the whole module including 3 questions.<br/>Please click on <b>'Start Quiz'</b> button when you are ready."
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
                            type: "html",
                            html: "<b>What is a 'KYC agent'?</b></br></br>A KYC agent is a 3rd party personnel authorised by a central authority to collect personal particulars of potential banking customers so as create digital identity for them.</br></br><b>As a KYC Agent, your role is to:</b></br><ul></br><li>>Key in the customer particulars</li><li>>Upload the scan of the customer personal identification document</li><li>>Take a facial photograph of the customer</li></ui></br></br>",

                        }
                    ]
                }, {
                    questions: [
                        {
                            type: "html",
                            html: "<b>Why capture all this information?</b></br></br><b>Personal Particulars: </b> All the basic information of the customer. This would streamline the application process when the customer applies to set up a bank account. </br></br><b>Scan of identification document:</b> Physical proof that the customer is who he/she claim to be. Can also be used for banking compliance.</br></br><b>Facial Photograph of customer: </b> Physical proof that customer was there to create digital identity. Also provides a reference image for facial recognition as part of 2 factor authentication when creating a bank account.",

                        }
                    ]
                },

                {
                    questions: [
                        {
                            type: "radiogroup",
                            name: "questionID-" + questionOneID,
                            title: questionOne, //"How does Aether store the consumer initial data inputted by the KYC Agent (7-11 Staff)",
                            choices: choicesArr,
                            correctAnswer: answerOne
                        }
                    ]
                }, {
                    questions: [
                        {
                            type: "radiogroup",
                            name: "questionID-" + questionTwoID,
                            title: questionTwo,
                            choicesOrder: "random",
                            choices: choicesArrTwo,
                            correctAnswer: answerTwo
                        }
                    ]
                }, {

                    questions: [
                        {
                            type: "radiogroup",
                            name: "questionID-" + questionThreeID,
                            title: questionThree,
                            choicesOrder: "random",
                            choices: choicesArrThree,
                            correctAnswer: answerThree
                        }
                    ]
                }
            ],
            completedHtml: "<h4>You have completed the quiz! Press 'Close' to carry on creating your unique digital identity!.</h4>"
        };

        window.survey = new Survey.Model(json);
        var timeEl = document.getElementById("timeEl");
        var timerId = null;

        function renderTime(val) {
            if (!timeEl) {
                return;
            }
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
            window.survey.setValue("qnsA", questionOneID);
            window.survey.setValue("qnsB", questionTwoID);
            window.survey.setValue("qnsC", questionThreeID);
            window.survey.setValue("userID", userID);
            window.survey.setValue("groupID", groupID);

            renderTime(seconds);
        }

        window.survey.onCurrentPageChanged.add(function () {
            timerCallback();
        });
        window.survey.onComplete.add(function (result) {
            $('#surveyResult').innerHTML = "result: " + JSON.stringify(result.data);


            document.getElementById("timeInfo").style.display = "none";
            clearInterval(timerId);
            $.ajax({
                method: "POST",
                url: "./ScoringServlet",
                type: "POST",
                data: JSON.stringify(result.data),
                contentType: "application/json",
                success: function (output) {
                    //console.log(output);
                }
            });
            //document.querySelector('#surveyResult').innerHTML = "result: " + JSON.stringify(result.data);
        });
        $("#surveyElement").Survey({model: survey});

       

        timerCallback();
        timerId = window.setInterval(function () {
            timerCallback();
        }, 1000);
    },
    error: function (xhr) {
        //console.log(xhr);
        $.alert({
            title: 'Failure!',
            content: 'Quiz Error!'
        });
    }
});
        



