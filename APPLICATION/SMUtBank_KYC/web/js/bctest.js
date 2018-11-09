/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
//$(window).on('load', function () {
//    $('#myModal').modal('show');
//});
//


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
    async: false,
    type: "POST",
    data: JSON.stringify(createJson),
    contentType: "application/json",
    success: function (data) {
        var arr = data.setB;
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
                            html: "You are about to start the blockchain quiz for Aether. <br/>You have 60 seconds for every page and 3 minutes for the whole survey of 3 questions.<br/>Please click on <b>'Start Quiz'</b> button when you are ready."
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
            completedHtml: "<h4>You have completed the quiz! Press 'Close' to carry on!</h4>"
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
                url: "./ScoringServletB",
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




