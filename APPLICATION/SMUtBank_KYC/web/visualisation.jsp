<%-- 
    Document   : dashboard
    Created on : 19-Jul-2018, 12:55:31
    Author     : jodia
--%>

<%@page import="java.nio.charset.Charset"%>
<%@page import="java.util.Random"%>
<%@page import="java.math.BigInteger"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.aether.dao.UserDAO, com.aether.blockchain.BlockchainHandler" %>
<%@page import="java.math.BigInteger"%>
<%@page import="java.util.UUID"%>
<!DOCTYPE html>
<%
    String publickey = UserDAO.getUser((String) session.getAttribute("userid")).getPublicKey();
    publickey = publickey.replace("\u0000", "");
    BigInteger balance = new BigInteger("0");
    BigInteger eth = new BigInteger("0");
    try {
        balance = BlockchainHandler.getBalance(publickey);
        eth = BlockchainHandler.convertToEth(balance);
    } catch (NumberFormatException e) {
    }

    byte[] array = new byte[7]; // length is bounded by 7
    new Random().nextBytes(array);
    String generatedString = new String(array, Charset.forName("UTF-8"));
    String randomHash = BlockchainHandler.keccak256hash(generatedString);
    String randomUUID = UUID.randomUUID().toString();
%>
<html lang="en">
    <%@include  file="Components/head.html" %>
    <script src="https://unpkg.com/jquery"></script>
    <script src="js/surveyJQuery.js"></script>
    <link href="https://surveyjs.azureedge.net/1.0.46/survey.css" type="text/css" rel="stylesheet"/>
    <body>
        <div class="se-pre-con">                        
        </div>
        <style>
            .row:after {
                content: "";
                display: table;
                clear: both;
            }
            .hiddenrow{
                opacity: 0;
                display: none;
                background-color: lightgray;
                border-radius: 25px;
            }
            .hiddeninner{
                margin-top: auto;
                margin-bottom: auto;
            }
            
            
            
            
            
            
            /*BLOCKCHAIN*/ 
            .blockchainoverviewmain {
                background: url(img/bc_visualisation/Blockchain/bc-mainn.jpeg) no-repeat center top;
                text-align: center;
                background-position: center center;
            }
            
            .blockchainoverview1 {
                background: url(img/bc_visualisation/Blockchain/bc1n.jpg) no-repeat center top;
                text-align: center;
                background-position: center center;
                /*background-size: 100%;*/
                /*height: 100%;*/
            }
            .blockchainoverview2 {
                background: url(img/bc_visualisation/Blockchain/bc2n.png) no-repeat center top;
                text-align: center;
                background-position: center center;
                /*background-size: 100%;*/
                /*height: 100%;*/
            }
            .blockchainoverview3 {
                background: url(img/bc_visualisation/Blockchain/bc3n.jpg) no-repeat center top;
                text-align: center;
                background-position: center center;
                /*background-size: 100%;*/
                /*height: 100%;*/
            }
            
            
            /* Data Handling */
            .datahandlingmain {
                background: url(img/bc_visualisation/Encryption/en-mainn.jpg) no-repeat center top;
                text-align: center;
                background-position: center center;
            }
            .datahandling1 {
                background: url(img/bc_visualisation/Encryption/en1n.jpg) no-repeat center top;
                text-align: center;
                background-position: center center;
            }
            .datahandling2 {
                background: url(img/bc_visualisation/Encryption/en2n.jpg) no-repeat center top;
                text-align: center;
                background-position: center center;
            }
            
            
            /* Test Quiz */
            .testmain {
                background: url(img/bc_visualisation/TestBC/test-mainn.jpg) no-repeat center top;
                text-align: center;
                background-position: center center;
            }
            .test1 {
                background: url(img/bc_visualisation/TestBC/t1n.jpg) no-repeat center top;
                text-align: center;
                background-position: center center;
            }
            .test2 {
                background: url(img/bc_visualisation/TestBC/t2n.jpg) no-repeat center top;
                text-align: center;
                background-position: center center;
            }
            .test3 {
                background: url(img/bc_visualisation/TestBC/t3n.jpg) no-repeat center top;
                text-align: center;
                background-position: center center;
            }
            
            
            
            
            
            
            
            
            
            

            .vispanel i {
                color: white;
                margin-top: 45px;
            }
            .vispanel h2 {
                color: white;
                font-weight: 900;
            }
            .vispanel h4 {
                color: white;
                font-weight: 900;
                letter-spacing: 1px;
            }


        </style>
        <section id="container" >
            <%@include  file="Components/topbar.html" %>
            <%@include  file="Components/sidebar.jsp" %>

            <!-- **********************************************************************************************************************************************************
            MAIN CONTENT
            *********************************************************************************************************************************************************** -->
            <!--main content start-->
            <section id="main-content">
                <section class="wrapper site-min-height">
                    <h3><i class="fa fa-angle-right"></i>Blockchain: Visualisation</h3>
                    <div class="row mt">
                        <div class ="col-lg-12">
                            <div class="row">

                                <!-- OVERVIEW PANEL -->
                                <div class="col-md-4 col-sm-4 mb" id="box1">
                                    <div id="blockover" class="blockchainoverviewmain vispanel pn">
                                        <i class="fa fa-th-large fa-4x"></i>
                                        <h2>Blockchain</h2>
                                        <h4>What Is It?</h4>
                                    </div>
                                </div><!-- /col-md-4-->

                                <!-- WHATIS PANEL -->
                                <div class="col-md-4 col-sm-4 mb" id="box2">
                                    <div id="secure" class="datahandlingmain vispanel pn">
                                        <i class="fa fa-user-secret fa-4x"></i>
                                        <h2>Data Handling & Encryption</h2>
                                        <h4>Keeping things safe</h4>
                                    </div>
                                </div><!-- /col-md-4-->

                                <!-- WHATIS PANEL -->
                                <div class="col-md-4 col-sm-4 mb" id="box3">
                                    <div id="tryout" class="testmain vispanel pn">
                                        <i class="fa fas fa-flask fa-4x"></i>
                                        <h2>Test out our blockchain!</h2>
                                        <h4>Hands On</h4>
                                    </div>
                                </div><!-- /col-md-4-->
                            </div>

                            <div class="row hiddenrow" id="hidden1">

                                <!-- OVERVIEW PANEL -->
                                <div class="col-md-4 col-sm-4 mb">
                                    <div id="whatis" class="blockchainoverview1 vispanel pn">
                                        <i class="fa fa-lock fa-4x"></i>
                                        <h2>The Basics: What's A Blockchain?</h2>
                                        <h4>Click to start</h4>
                                    </div>
                                </div><!-- /col-md-4-->

                                <!-- OVERVIEW PANEL -->
                                <div class="col-md-4 col-sm-4 mb">
                                    <div id="smartcon" class="blockchainoverview2 vispanel pn">
                                        <i class="fa fa-file-contract fa-4x"></i>
                                        <h2>Smart Contracts</h2>
                                        <h4>Click to start</h4>
                                    </div>
                                </div><!-- /col-md-4-->

                                <!-- OVERVIEW PANEL -->
                                <div class="col-md-4 col-sm-4 mb">
                                    <div id="overblck" class="blockchainoverview3 vispanel pn">
                                        <i class="fa fa-link fa-4x"></i>
                                        <h2>Linking It Together</h2>
                                        <h4>Click to start</h4>
                                    </div>
                                </div><!-- /col-md-4-->

                            </div>
                            <div class="row hiddenrow" id="hidden2">
                                <!-- OVERVIEW PANEL -->
                                <div class="col-md-4 col-sm-4 mb">
                                    <div id="encrypt" class="datahandling1 vispanel pn">
                                        <i class="fa fa-fingerprint fa-4x"></i>
                                        <h2>The Basics of Hashing</h2>
                                        <h4>Click to start</h4>
                                    </div>
                                </div><!-- /col-md-4--> 

                                <!-- OVERVIEW PANEL -->
                                <div class="col-md-4 col-sm-4 mb">
                                    <div id="hashtest" class="datahandling2 vispanel pn">
                                        <i class="fa fa-hashtag fa-4x"></i>
                                        <h2>Hashing</h2>
                                        <h4>Let's Test Hashing!</h4>
                                    </div>
                                </div><!-- /col-md-4--> 
                            </div>
                            <div class="row hiddenrow" id="hidden3">
                                <!-- OVERVIEW PANEL -->
                                <div class="col-md-4 col-sm-4 mb">
                                    <div id="account" class="test1 vispanel pn">
                                        <i class="fa fa-dollar-sign fa-4x"></i>
                                        <h2>Accounts and Balance</h2>
                                        <h4>View your ether!</h4>
                                    </div>
                                </div><!-- /col-md-4--> 
                                <!-- OVERVIEW PANEL -->
                                <div class="col-md-4 col-sm-4 mb">
                                    <div id="contracts" class="test2 vispanel pn">
                                        <i class="fa fa-file-signature fa-4x"></i>
                                        <h2>Contracts And Deployment</h2>
                                        <h4>Deploy a contract!</h4>
                                    </div>
                                </div>
                                <!-- /col-md-4--> 
                            
                    <!-- Modal -->
                    <%
                        String val = session.getAttribute("groupid").toString();
                        //String learningIDVal = "4";
                        if (!val.equals("0")) {
                    %>
                    <!--<button class="btn btn-lg btn-info open-modal">Time for the final quiz!</button> -->
                            <div class="col-md-4 col-sm-4 mb">
                                <div id="FINAL_QUIZ" class="test3 vispanel pn">
                                    <i class="fa fa-file-contract fa-4x"></i>
                                    <h2>QUIZ TIME!</h2>
                                    <h4>Test your Knowledge!</h4>
                                </div>
                            </div>
                    <%
                        }
                    %>
                    </div>
                        </div>
                    </div>
                    <div class="modal fade" id="myModal" role="dialog" data-keyboard="false" data-backdrop="static">
                        <div class="modal-dialog" style="width:1200px;">

                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title">Aether Quiz Questions</h4>
                                    <div id="timeInfo" style="display: none;">                                        <p>
                                            <span>The time spent on this page: </span><span id="timeEl"></span>
                                        </p>
                                    </div>
                                </div>
                                <div class="modal-body">
                                    <div id="surveyElement"></div>
                                    <%
                                        String userID = session.getAttribute("userid").toString();
                                        String learningIDVal = session.getAttribute("groupid").toString();
                                        //String learningIDVal = "4";
                                        if (!learningIDVal.equals("0")) {
                                    %>
                                    <script type="text/javascript">
                                        var userID = '<%=userID%>'
                                        var groupID = '<%=learningIDVal%>';
                                    </script>
                                    <script src ="js/bctest.js"></script>
                                    <%
                                        }
                                    %>
                                    <div id="surveyResult"></div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                </div>
                            </div>

                        </div>
                    </div>
                    <!--end of Modal -->
                    <div id="leaderboardModal" class="modal fade" role="dialog">
                        <div class="modal-dialog">

                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title">Leaderboard Ranking</h4>
                                </div>
                                <div class="modal-body-grpleaderboard" id="modal-body-grpleaderboard">





                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                </div>
                            </div>

                        </div>

                    </div>    
                </section>
            </section>

            <%@include file="Components/script.html" %>
            <%@include file="Components/style.html" %>

            <script type ='text/javascript'>
                                        function leaderboard() {

                                            $.ajax({
                                                url: "./LeaderboardServlet", //edit address accordingly
                                                type: "POST",
                                                contentType: "application/json",
                                                success: function (data) {
                                                    var length = data.Leader.length;
                                                    console.log("arary length: " + length);
                                                    console.log("json: " + JSON.stringify(data));
                                                    var text = "";
                                                    text += '<table class="table table-striped"><tr><td><b> GROUP </b></td><td><b> SCORE </b></td></tr>';

                                                    for (i = 0; i < data.Leader.length; i++) {

                                                        text += '<tr><td>' + data.Leader[i].user_Id + '</td><td>' + data.Leader[i].score + '</td></tr>';
                                                    }
                                                    text += '</table>';
                                                    //alert(text);

                                                    var result = document.getElementById("modal-body-grpleaderboard").innerHTML = text;
                                                    //                                                    result.innerHTML(text);
                                                    //                                                    result.appendChild(text);
                                                    /*for (i = 0; i < data.Leader.length5; i++) {
                                                     data.Leader[i].score;
                                                     data.Leader[i].user_Id;
                                                     }*/
                                                    console.log(text);
                                                    console.log("score: " + data.Leader[0].score) //score
                                                    console.log("user_Id: " + data.Leader[0].user_Id) //group

                                                }, error: function (xhr) {

                                                }
                                            });

                                            /*$.post('./LeaderboardServlet', function (data) {
                                             
                                             alert(data);
                                             alert(data[1]);
                                             
                                             for (var i = 0; i < data.length; i++) {
                                             var id = i + 1;
                                             var name = data[i].key;
                                             var relevance = data[i].value;
                                             }
                                             
                                             });*/
                                        }



            </script>

    </body>
    <script>
        document.getElementById("visualisationside").className = "active";
    </script>
    
    
    <script type="text/javascript">
        var toHash;
        var ethBalance = "<%=eth%>";
        var publickey = "<%=publickey%>";
        $('#blockover').click(function () {
            console.log("hi");
            document.getElementById("hidden1").style.display = "block";
            document.getElementById("hidden2").style.display = "none";
            document.getElementById("hidden3").style.display = "none";
            //document.getElementById("box2").style.opacity = 0.5;
            $("#hidden1").delay(100).animate({opacity: 1}, 700);
            $('#box1').delay(100).animate({opacity: 1}, 700);
            $('#box2').delay(100).animate({opacity: 0.2}, 700);
            $('#box3').delay(100).animate({opacity: 0.2}, 700);
        });
        $('#secure').click(function () {
            console.log("hi again");
            document.getElementById("hidden1").style.display = "none";
            document.getElementById("hidden2").style.display = "block";
            document.getElementById("hidden3").style.display = "none";
            $("#hidden2").delay(100).animate({opacity: 1}, 700);
            $('#box1').delay(100).animate({opacity: 0.2}, 700);
            $('#box2').delay(100).animate({opacity: 1}, 700);
            $('#box3').delay(100).animate({opacity: 0.2}, 700);
        });
        $('#tryout').click(function () {
            console.log("nice seeing you again");
            document.getElementById("hidden1").style.display = "none";
            document.getElementById("hidden2").style.display = "none";
            document.getElementById("hidden3").style.display = "block";
            $("#hidden3").delay(100).animate({opacity: 1}, 700);
            $('#box1').delay(100).animate({opacity: 0.2}, 700);
            $('#box2').delay(100).animate({opacity: 0.2}, 700);
            $('#box3').delay(100).animate({opacity: 1}, 700);
        });

        $('#contracts').click(function () {
            $.confirm({
                theme: 'material',
                title: 'Time to deploy a contract!',
                columnClass: 'large',
                content: '<h4>Now that you\'ve transferred some funds, it\'s time to deploy a contract.<br>' +
                        'On the next page, you\'ll generate some values to be deployed! For now have a look at the smart contract code you saw earlier.</h4>' +
                        "<pre><code>pragma solidity ^ 0.4.2; <br>" +
                        "contract KYC{<br>" +
                        "   string public uuid;<br>" +
                        "   string public hash;<br>" +
                        "   constructor(string id, string ha) public{<br>" +
                        "       uuid = id;<br>" +
                        "       hash = ha;<br>" +
                        "   }<br><br>" +
                        "}</code></pre>",
                buttons: {
                    next: function () {
                        $.confirm({
                            theme: 'material',
                            title: 'Generate some values!',
                            columnClass: 'large',
                            content: '<h3>UUID</h3>' +
                                    '<h4> This value is randomly generated. Click the button below to generate a value until you find one you like.</h4>' +
                                    '<button class="btn btn-blue" id="uuidbtn">Generate UUID</button>' +
                                    '<div id="uuidresult"></div>' +
                                    '<h3>Hash</h3>' +
                                    '<h4> Input some text here to be hashed</h4>' +
                                    '<input class="form-control round-form" id="hashbtn" placeholder="Input some text!">' +
                                    '<div id="hashresult"></div>' +
                                    '<button class="btn btn-red" id="contractsubmit">Submit Contract</button>' +
                                    '<div id="transactionresult"></div>',
                            onContentReady: function () {
                                $('#uuidbtn').click(function () {
                                    $.ajax({
                                        url: "./BlockchainVis?method=uuid",
                                        type: "GET",
                                        contentType: "application/json",
                                        success: function (resp) {
                                            $('#uuidresult').html('<h4>' + resp.result + '</h4>');
                                        }, error: function (xhr) {

                                        }
                                    });
                                });
                                $('#hashbtn').keyup(function () {
                                    console.log('hi');
                                    $.ajax({
                                        url: "./BlockchainVis?method=hash&randomstring=" + $('#hashbtn').val(),
                                        type: "GET",
                                        contentType: "application/json",
                                        success: function (resp) {
                                            $('#hashresult').html('<h4>' + resp.result + '</h4>');
                                        }, error: function (xhr) {

                                        }
                                    });
                                });
                                $('#contractsubmit').click(function () {
                                    if ($('#hashresult').html().length == 0 || $('#uuidresult').html().length == 0) {
                                        $('#transactionresult').html('<h4> Please put in all the values! </h4>');
                                    }
                                    var hashsub = $('#hashresult').html().substring(4, $('#hashresult').html().length - 5);
                                    var uuidsub = $('#uuidresult').html().substring(4, $('#uuidresult').html().length - 5);
                                    console.log(hashsub + ' ' + uuidsub);
                                    var conObject = {};
                                    conObject["uuid"] = uuidsub;
                                    conObject["hash"] = hashsub;
                                    console.log(JSON.stringify(conObject));
                                    $.ajax({
                                        url: "./BlockchainVis?method=deployContract&publicKey=" + publickey,
                                        type: "POST",
                                        data: JSON.stringify(conObject),
                                        contentType: "application/json",
                                        success: function (resp) {
                                            $('#transactionresult').html('<h4>' + resp.result + '</h4>');
                                        }, error: function (xhr) {

                                        }
                                    });
                                });
                            },
                            buttons: {
                                close: {}
                            }
                        });
                    }
                }
            });
        });
        $('#account').click(function () {
            $.confirm({
                theme: 'material',
                title: 'How much money do you have?',
                columnClass: 'large',
                content: '<div class="col-md-6 mb">' +
                        '<div class="darkblue-panel pn">' +
                        '<div class="darkblue-header">' +
                        '<h5>BALANCE</h5>' +
                        '</div>' +
                        '<h1 class="ml15">' +
                        '<span class="word">' + ethBalance + 'ETH</span>' +
                        '</h1>' +
                        '</div>' +
                        '</div>' +
                        '<h4>This is your account balance, accumulated while you were answering questions just now. <br><br>' +
                        'There\'s no actual value to the currency here, but on a real ethereum network what you have here could buy you a nice rolex.</h4>',
                buttons: {
                    next: function () {
                        $.confirm({
                            theme: 'material',
                            title: 'What\'s your account number?',
                            columnClass: 'large',
                            content: '<h2>Public Key<h2>' +
                                    '<h3>' + publickey + '<h3>' +
                                    '<h4>Your public key is like your address: it allows you to find your account. By keying in a public key next, you\'ll be able to find out what your friends\' balance is.</h4><br>' +
                                    '<input id="friendkey" class="form-control round-form" type="text" placeholder="Enter your friend\'s public key here!">' +
                                    '<div id="balancediv"></div>',
                            onContentReady: function () {
                                $('#friendkey').keyup(function () {
                                    var key = $('#friendkey').val();
                                    if (key.length == 42) {
                                        $.ajax({
                                            url: "./BlockchainVis?method=getBalanceTest&publickey=" + $('#friendkey').val(),
                                            type: "GET",
                                            contentType: "application/json",
                                            success: function (resp) {
                                                $("#balancediv").html("<h3>" + resp.result + " ETH <h3>");
                                            }, error: function (xhr) {

                                            }
                                        });
                                    }

                                });
                            },
                            buttons: {
                                next: function () {
                                    $.confirm({
                                        theme: 'material',
                                        title: 'Transferring Ether',
                                        columnClass: 'large',
                                        content: '<h2>Public Key<h2>' +
                                                '<h3>' + publickey + '<h3>' +
                                                '<h4>Next we\'re going to transfer some currency to your friends! Simply put in their public key and the amount you want to transfer.</h4><br>' +
                                                '<input id="friendkey" class="form-control round-form" type="text" placeholder="Enter your friend\'s public key here!">' +
                                                '<input id="transferbalance" class="form-control round-form" type="number" placeholder="Enter the amount to transfer in WEI! ">' +
                                                '<div id="balancediv"></div>' +
                                                '<div id="statusdiv"></div>' +
                                                '<button id="submittrans" class="btn btn-red">Submit</button>',
                                        onContentReady: function () {
                                            $('#submittrans').click(function () {
                                                var friendkey = $('#friendkey').val();
                                                var balance = $('#transferbalance').val();
                                                if (friendkey.length == 42 && balance > 0) {
                                                    $.ajax({
                                                        url: "./BlockchainVis?method=transferEth&from=" + publickey + "&to=" + friendkey + "&value=" + balance,
                                                        type: "GET",
                                                        contentType: "application/json",
                                                        success: function (resp) {
                                                            $('#statusdiv').html("<h4>Transactionhash: " + resp.result + "</h4>");
                                                            console.log(resp);
                                                        }, error: function (xhr) {

                                                        }
                                                    });
                                                }
                                            });
                                        },
                                        buttons: {
                                            close: function () {

                                            }
                                        }
                                    });
                                }
                            }
                        });
                    }
                }
            });
        });
        
        
        $('#FINAL_QUIZ').click(function () {
//            $(document).on('ready', function() {
//            $('.open-modal').click(function() {
            $('#myModal').modal();
//            });
//        });
        });
        
        
        
        $('#hashtest').click(function () {
            $.confirm({
                theme: 'material',
                columnClass: 'large',
                title: 'Let\'s hash something!',
                content: '<input type="text" id="tohash" class="form-control round-form" placeholder="Type your string here" id="hashstring">' +
                        '<div id="hashresult"></div>',
                onContentReady: function () {
                    $('#tohash').keyup(function () {
                        var value = $('#tohash').val();
                        toHash = value;
                        console.log('hi');
                        $.ajax({
                            url: "./BlockchainVis?method=hash&randomstring=" + value,
                            type: "GET",
                            contentType: "application/json",
                            success: function (resp) {
                                $('#hashresult').html(resp.result);
                            }, error: function (xhr) {

                            }
                        });
                    });
                }
            })
        });
        $('#overblck').click(function () {
            $.confirm({
                theme: 'material',
                title: 'Linking Everything Together',
                content: '<img src="img/linking.gif"></img' +
                        '<h5>Now comes time to link everything together. Move on to Data Handling and Encryption!</h5>',
                buttons: {
                    close: {

                    }
                }
            });
        });
        $('#encrypt').click(function () {
            $.confirm({
                theme: 'material',
                title: 'Why do we hash?',
                content: '<img src="img/encryption.gif">' +
                        '<h5>Imagine you have a bunch of data. Someone hacks into your server/machine/laptop and instead of stealing it, changes it ever so slightly.<br>' +
                        'How do we detect this?</h5>',
                buttons: {
                    next: function () {
                        $.confirm({
                            theme: 'material',
                            title: 'The rundown on hashing',
                            content: "<img src='img/hashing.png'>" +
                                    "<h5>The important thing to note is that when hashing ANY information, the resulting text will always be the same length. You can try this in the 'Hashing' link later on. With this in mind, the moment you change any part of the data, the resulting hashed text will change.</h5>"
                        });
                    }
                }
            });
        })

        $('#smartcon').click(function () {
            $.confirm({
                theme: 'material',
                title: 'Onto Smart Contracts!',
                content: '<img src="img/smartcontract.gif"></img>' +
                        '<h4>A smart contract functions very much like a program on your computer. It can run instructions, store things and be called when you want to.</h4>',
                buttons: {
                    next: function () {
                        $.confirm({
                            theme: 'material',
                            title: 'Properties of Smart Contracts',
                            content: "<pre><code>pragma solidity ^ 0.4.2; <br>" +
                                    "contract KYC{<br>" +
                                    "   string public uuid;<br>" +
                                    "   string public hash;<br>" +
                                    "   constructor(string id, string ha) public{<br>" +
                                    "       uuid = id;<br>" +
                                    "       hash = ha;<br>" +
                                    "   }<br><br>" +
                                    "}</code></pre>" +
                                    "<h4>Above is a sample smart contract. While it may look complicated, there's only 2 things we need to pay attention to for now.</h4>",
                            buttons: {
                                next: function () {
                                    $.confirm({
                                        theme: 'material',
                                        title: 'Variables: Explained!',
                                        content: "<pre><code>" +
                                                "string public uuid;<br>" +
                                                "string public hash;<br>" +
                                                "</code></pre>" +
                                                "<h5>Don't be scared! once you get the hang of this is pretty simple. <br>" +
                                                "'uuid' and 'hash' are just variable names, they help to identify the data you're storing. <br>" +
                                                "'string' is a type of data. In this case it's just a bunch of text. 'this' is a string. So is 'hello'." +
                                                "'public' is an access modifier. What it's saying is that ANYONE with access to this contract can read the data, hence 'public'. </h5>",
                                        buttons: {
                                            next: function () {
                                                $.confirm({
                                                    theme: 'material',
                                                    title: 'Constructors: Explained!',
                                                    content: "<pre><code>" +
                                                            "constructor(string id, string ha) public{<br>" +
                                                            "   uuid = id;<br>" +
                                                            "   hash = ha;<br>" +
                                                            "}<br><br>" +
                                                            "</code></pre>" +
                                                            "<h5>Constructors are basically what their name implies: They build the contract!" +
                                                            "Constructors do certain things when they are called. Over here, they assign and store the uuid and hash variables.</h5>",
                                                    buttons: {
                                                        close: {}
                                                    }
                                                });
                                            }
                                        }
                                    });
                                }
                            }
                        })
                    }
                }
            });
        });
        $('#whatis').click(function () {
            $.confirm({
                theme: 'material',
                title: 'So this is a blockchain.',
                content: '<img src="img/blockchain-broadcast-varification.gif"></img>' +
                        '<h4>It\'s not as complicated as you think. Think of each block as a bit of data, that stores information about other blocks of data. Because everyone has copies of these blocks, it\'s easy to tell if something\'s not right.</h4>',
                buttons: {
                    next: function () {
                        $.confirm({
                            theme: 'material',
                            title: 'What\'s in a blockchain?',
                            content: '<img src="img/BTY_2.gif"></img>' +
                                    "<h4>A blockchain consists of 3 basic parts: data, hashes and reference hashes.</h4>" +
                                    "<h3>Data</h3>" +
                                    "<h4>Transactions on the blockchain can be sent, attached with data.</h4>" +
                                    "<h3>Hash</h3>" +
                                    "<h4>A hash is a unique identifier as a representation of the data in the block itself. If any data in the block changes, so does this.</h4>" +
                                    "<h3>Reference Hash</h3>" +
                                    "<h4>Same as above, but instead this is representative of another block's data.",
                            buttons: {
                                close: {}
                            }
                        });
                    }
                }
            })
        })
    </script>
    <script type="application/javascript">
        $(document).on('ready', function() {
        $('.open-modal').click(function() {
        $('#myModal').modal();
        });
        });
    </script>
</html>