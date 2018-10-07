<%-- 
    Document   : dashboard
    Created on : 19-Jul-2018, 12:55:31
    Author     : jodia
--%>

<%@page import="java.nio.charset.Charset"%>
<%@page import="java.util.Random"%>
<%@page import="java.math.BigInteger"%>
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
    <body>
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
            .blockchainoverview {
                background: url(img/bg1.png) no-repeat center top;
                text-align: center;
                background-position: center center;
            }
            .whatisblockchain {
                background: url(img/enterprise-blockchain.png) no-repeat center top;
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
            <%@include  file="Components/sidebar.html" %>

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
                                    <div id="blockover" class="blockchainoverview vispanel pn">
                                        <i class="fa fa-th-large fa-4x"></i>
                                        <h2>Blockchain</h2>
                                        <h4>What Is It?</h4>
                                    </div>
                                </div><!-- /col-md-4-->

                                <!-- WHATIS PANEL -->
                                <div class="col-md-4 col-sm-4 mb" id="box2">
                                    <div id="secure" class="whatisblockchain vispanel pn">
                                        <i class="fa fa-user-secret fa-4x"></i>
                                        <h2>Data Handling & Encryption</h2>
                                        <h4>Keeping things safe</h4>
                                    </div>
                                </div><!-- /col-md-4-->
                            </div>

                            <div class="row hiddenrow" id="hidden1">

                                <!-- OVERVIEW PANEL -->
                                <div class="col-md-4 col-sm-4 mb">
                                    <div id="whatis" class="blockchainoverview vispanel pn">
                                        <i class="fa fa-lock fa-4x"></i>
                                        <h2>The Basics: What's A Blockchain?</h2>
                                        <h4>Click to start</h4>
                                    </div>
                                </div><!-- /col-md-4-->

                                <!-- OVERVIEW PANEL -->
                                <div class="col-md-4 col-sm-4 mb">
                                    <div id="smartcon" class="blockchainoverview vispanel pn">
                                        <i class="fa fa-file-contract fa-4x"></i>
                                        <h2>Smart Contracts</h2>
                                        <h4>Click to start</h4>
                                    </div>
                                </div><!-- /col-md-4-->

                                <!-- OVERVIEW PANEL -->
                                <div class="col-md-4 col-sm-4 mb">
                                    <div id="overblck" class="blockchainoverview vispanel pn">
                                        <i class="fa fa-link fa-4x"></i>
                                        <h2>Linking It Together</h2>
                                        <h4>Click to start</h4>
                                    </div>
                                </div><!-- /col-md-4-->

                            </div>
                            <div class="row hiddenrow" id="hidden2">
                                <!-- OVERVIEW PANEL -->
                                <div class="col-md-4 col-sm-4 mb">
                                    <div id="encrypt" class="blockchainoverview vispanel pn">
                                        <i class="fa fa-fingerprint fa-4x"></i>
                                        <h2>The Basics of Encryption</h2>
                                        <h4>Click to start</h4>
                                    </div>
                                </div><!-- /col-md-4--> 

                                <!-- OVERVIEW PANEL -->
                                <div class="col-md-4 col-sm-4 mb">
                                    <div id="hashtest" class="blockchainoverview vispanel pn">
                                        <i class="fa fa-hashtag fa-4x"></i>
                                        <h2>Hashing</h2>
                                        <h4>Let's Test Hashing!</h4>
                                    </div>
                                </div><!-- /col-md-4--> 
                            </div>
                        </div>
                    </div>
                </section>
            </section>

            <%@include file="Components/script.html" %>
            <%@include file="Components/style.html" %>

    </body>
    <script type="text/javascript">
        var toHash;

        $('#blockover').click(function () {
            console.log("hi");
            document.getElementById("hidden1").style.display = "block";
            document.getElementById("hidden2").style.display = "none";
            //document.getElementById("box2").style.opacity = 0.5;
            $("#hidden1").delay(100).animate({opacity: 1}, 700);
            $('#box1').delay(100).animate({opacity: 1}, 700);
            $('#box2').delay(100).animate({opacity: 0.2}, 700);
        });

        $('#secure').click(function () {
            console.log("hi again");
            document.getElementById("hidden1").style.display = "none";
            document.getElementById("hidden2").style.display = "block";
            $("#hidden2").delay(100).animate({opacity: 1}, 700);
            $('#box1').delay(100).animate({opacity: 0.2}, 700);
            $('#box2').delay(100).animate({opacity: 1}, 700);
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
                        '<h5>Now comes time to link everything together.'
            });
        });

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
</html>