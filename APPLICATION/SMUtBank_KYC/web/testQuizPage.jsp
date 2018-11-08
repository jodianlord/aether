<%-- 
    Document   : testQuizPage
    Created on : 2 Oct, 2018, 3:52:54 PM
    Author     : Yuefeng
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://unpkg.com/jquery"></script>
        <script src="https://surveyjs.azureedge.net/1.0.46/survey.jquery.js"></script>
        <link href="https://surveyjs.azureedge.net/1.0.46/survey.css" type="text/css" rel="stylesheet"/>
        <link rel="stylesheet" href="./index.css">

    </head>
    <body onload="myFunction()">
        
        <div id="timeInfo">
    <p>
      <span>The time spent on this page: </span><span id="timeEl"></span>
    </p>
  </div>
        <div id="surveyElement"></div>
        <div id ="surveyResult"></div>
       
        <script type="text/javascript" src="js/gameIntro.js"></script>
        <!--<script type="text/javascript" src="js/quiztesting.js"></script>-->
        

    </body>
    
</html>