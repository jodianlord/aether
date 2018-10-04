/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var json = {
    
    showProgressBar: "bottom",
   
    maxTimeToFinishPage: 0,
    maxTimeToFinish: 0,
    firstPageIsStarted: true,
    startSurveyText: "Close",
    pages: [
        {
            questions: [
                {
                    type: "html",
                    html: "<h5>At this stage, your customer digital identity has been created and stored as a smart contract in the blockchain. Head over to Blockchain Visualisation to find out more about blockchain and smart contracts! </h5> <br/>Please click on <b>'Close'</b> button when you are ready to exit."
                }
            ]
        }]
    
};

window.survey = new Survey.Model(json);

survey
    .onComplete
    .add(function (result) {
        document
            .querySelector('#surveyResult')
            .innerHTML = "result: " + JSON.stringify(result.data);
    });

$("#surveyElementAfer").Survey({model: survey});
 

