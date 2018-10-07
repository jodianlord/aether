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
            .blockchainoverview i {
                color: white;
                margin-top: 45px;
            }
            .blockchainoverview h2 {
                color: white;
                font-weight: 900;
            }
            .blockchainoverview h4 {
                color: white;
                font-weight: 900;
                letter-spacing: 1px;
            }

            .whatisblockchain {
                background: url(img/enterprise-blockchain.png) no-repeat center top;
                text-align: center;
                background-position: center center;
            }
            .whatisblockchain i {
                color: white;
                margin-top: 45px;
            }
            .whatisblockchain h2 {
                color: white;
                font-weight: 900;
            }
            .whatisblockchain h4 {
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
                                    <div id="blockover" class="blockchainoverview pn">
                                        <i class="fa fa-th-large fa-4x"></i>
                                        <h2>Blockchain</h2>
                                        <h4>What Is It?</h4>
                                    </div>
                                </div><!-- /col-md-4-->

                                <!-- WHATIS PANEL -->
                                <div class="col-md-4 col-sm-4 mb" id="box2">
                                    <div class="whatisblockchain pn">
                                        <i class="fa fa-question fa-4x"></i>
                                        <h2>What Is Blockchain?</h2>
                                        <h4>An Explanation</h4>
                                    </div>
                                </div><!-- /col-md-4-->
                            </div>

                            <div class="row hiddenrow" id="hidden1">

                                <!-- OVERVIEW PANEL -->
                                <div class="col-md-4 col-sm-4 mb">
                                    <div id="whatis" class="blockchainoverview pn">
                                        <i class="fa fa-lock fa-4x"></i>
                                        <h2>The Basics: What's A Blockchain?</h2>
                                        <h4>Click to start</h4>
                                    </div>
                                </div><!-- /col-md-4-->

                                <!-- OVERVIEW PANEL -->
                                <div class="col-md-4 col-sm-4 mb">
                                    <div id="smartcon" class="blockchainoverview pn">
                                        <i class="fa fa-file-contract fa-4x"></i>
                                        <h2>Smart Contrats</h2>
                                        <h4>Click to start</h4>
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
        $('#blockover').click(function () {
            console.log("hi");
            document.getElementById("hidden1").style.display = "block";
            //document.getElementById("box2").style.opacity = 0.5;
            $("#hidden1").delay(100).animate({opacity: 1}, 700);
            $('#box2').delay(100).animate({opacity: 0.2}, 700);
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