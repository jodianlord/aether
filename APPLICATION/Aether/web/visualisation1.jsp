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
    <style>
        html, body {
            margin: 0; 
            height: 100%; 
            overflow: hidden
        }    

    </style>


    <body>

        <section id="overall" >

            <%@include  file="Components/topbar.html" %>
            <%@include  file="Components/sidebar.html" %>

            <!-- **********************************************************************************************************************************************************
            MAIN CONTENT
            *********************************************************************************************************************************************************** -->
            <!--main content start-->
            <section id="main-content">
                <div id="container">
                    <!-- title -->
                    <section class="title">
                        <div class="row">
                            <div class="large-12 columns">
                                <h1>Blockchain Visualisation</h1>
                            </div>
                        </div>
                    </section>

                    <!--  Demos -->
                    <section id="demos">
                        <div class="row">
                            <div class="large-12 columns" style="height:800px">
                                <div class="owl-carousel owl-theme">
                                    

                                    <!-- 1. Overview-->
                                    <div class="item">
                                        </br>
                                        <h1 style="color:#EFD67F;margin-left:30px;margin-top: 30px">1: Overview</h1>
                                        <div style="height:260px">
                                            <p style="color:white;margin-left:30px; font-size:20px;height:60px">
                                                Let's wind back to the activity just now. Remember when we were keying the customer's details? This is something similar. Key in some values here.
                                            </p>
                                            <input type="text" class="form-control" id="fields" style="position: relative;width:200px;height:20px">
                                        </div>

                                        <div id="progressbar"></div>
                                    </div>

                                    <!-- 2. Encoding -->
                                    <div class="item">
                                        </br>
                                        <h1 style="color:#EFD67F;margin-left:30px;margin-top: 30px">2: Encoding</h1>
                                        <div style="height:260px">
                                            <p style="color:white;margin-left:30px; font-size:20px;height:60px">
                                                In the case of this application, we do not encode (you can think of this as 'uploading') the values directly to the blockchain. Instead we generate a Keccak256 hash (a line of text that changes depending on what's in the file). Press the button below to generate the hash for the values you just put in.
                                            </p>
                                            <button class="btn btn-red">
                                        </div>

                                        <div id="progressbar"></div>
                                    </div>

                                    <!-- 3. Third-->
                                    <div class="item">
                                        </br>
                                        <h1 style="color:#EFD67F;margin-left:30px;margin-top: 30px">3: Let's deploy a contract!</h1>
                                        <div style = "height:260px">
                                            <p style="color:white;margin-left:30px; font-size:20px;height:60px">
                                                Now that you have the Keccak 256 Hash of the data you want to encode, click the button below to generate a unique ID for your data.
                                            </p>
                                            <div style="color:white;margin-left:30px; font-size:20px">
                                                UUID:
                                                <div id="uuid" style="color:greenyellow;margin:10px 10px 10px 10px"></div>
                                            </div>
                                            <div style="color:white;margin-left:30px; font-size:20px">
                                                Hash:
                                                <div id="hash" style="color:greenyellow;margin:10px 10px 10px 10px"></div>
                                            </div>
                                            <button id="valuesGenerator" class="btn btn-success" style="margin-left:30px;">Generate!!!</button>
                                        </div>
                                        <div id="progressbar"></div>
                                    </div>


                                    <!-- 4. Contract Fundamentals-->
                                    <div class="item">
                                        </br>
                                        <h1 style="color:#EFD67F;margin-left:30px;margin-top: 30px">4: Contract Fundamentals</h1>
                                        <div style="height:260px">
                                            <p style="color:white;margin-left:30px; font-size:20px;height:60px">
                                                This is the contract that we'll be using to deploy your information onto the blockchain. Click the image below to look at the code of the contract!
                                            </p>
                                            <img id="contractImg" src="img/diploma.svg" style="position: relative;width:200px;height:200px">
                                        </div>

                                        <div id="progressbar"></div>
                                    </div>




                                    <!-- 2. Second -->
                                    <div class="item">
                                        </br>
                                        <h1 style="color:#EFD67F;margin-left:30px;margin-top: 30px">2: Let's check your cash!</h1>
                                        <div style = "height:260px">
                                            <p style="color:white;margin-left:30px; font-size:20px;height:60px">
                                                This is the amount of 'money' you have in your account. This eth was transferred to you just now while you were answering questions. If you don't have enough, get your friends to transfer some to you! (for a price)
                                            </p>
                                            <br>
                                            <div class="" style="margin:0px 50px 0px 50px">
                                                <div class="darkblue-panel" style="height:200px">
                                                    <div class="darkblue-header">
                                                        <h5>BALANCE</h5>
                                                    </div>
                                                    <h1 class="ml15" >
                                                        <span class="word"><%= eth%> ETH</span>
                                                    </h1>
                                                    <!---
                                                    <h1 class="ml15">
                                                        <span class="word"> WEI</span>
                                                    </h1>
                                                    -->
                                                </div>
                                            </div>
                                        </div><!-- /col-md-4 --><div id="progressbar"></div>
                                    </div>






                                    <!-- 4. Fourth deployImg img/exchange.svg-->
                                    <div class="item">
                                        </br>
                                        <h1 style="color:#EFD67F;margin-left:30px;margin-top: 30px">4: Sending the contract to the server</h1>

                                        <div style="height:260px">
                                            <p style="color:white;margin-left:30px; font-size:20px;height:60px">
                                                Click the icon to deploy the contract to the server!
                                            </p>

                                            <img id="deployImg" src="img/exchange.svg" style="position: relative;width:200px;height:200px;left:40%">
                                        </div>
                                        <div id="progressbar"></div>
                                    </div>




                                    <!-- 5. Fifth-->
                                    <div class="item">
                                        </br>
                                        <h1 style="color:#EFD67F;margin-left:30px;margin-top: 30px">5: Transaction Hash</h1>
                                        <div style = "height:260px">
                                            <p style="color:white;margin-left:30px; font-size:20px;height: 60px">
                                                This is the transaction hash of your contract.
                                            </p>

                                            <div style="color:white;margin-left:30px; font-size:20px">
                                                Contract Info:
                                                <div id="contractInfo" style="color:greenyellow;margin:10px 10px 10px 10px"></div>
                                            </div>

                                        </div>

                                        <div id="progressbar"></div>
                                    </div>





                                    <!-- 6. Sixth  -->
                                    <div class="item">
                                        </br>
                                        <h1 style="color:#EFD67F;margin-left:30px;margin-top: 30px">6: Contract Address</h1>
                                        <div style="height:260px">
                                            <p style="color:white;margin-left:30px; font-size:20px;height:60px">
                                                Click the icon and input the transaction hash from the previous transaction to retrieve your contract address!
                                            </p>
                                            <img id="addressImg" src="img/notebook.svg" style="position: relative;width:200px;height:200px;left:40%">
                                        </div>
                                        <div id="progressbar"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>

                    <!--main content end-->
            </section>

            <%@include file="Components/script.html" %>
            <%@include file="Components/style.html" %>

    </body>
</html>
<script type="text/javascript">
    document.getElementById("visualisationside").className = "active";

    $(document).ready(function () {
        $(".owl-carousel").owlCarousel({
            navigation: true,
            singleItem: true,
            autoWidth: true,
            margin: 100,
            center: true
        });
    });
    var uuid = "<%= randomUUID%>";
    var hash = "<%= randomHash%>";
    var publicKey = "<%= publickey%>";

    $("#valuesGenerator").click(function () {
        console.log("hi");
        document.getElementById("uuid").innerHTML = "<%= randomUUID%>";
        document.getElementById("hash").innerHTML = "<%= randomHash%>"
    })
</script>
<script src="js/owlvisualisation.js"></script>
<style>
    #progressbar{
        position: absolute;
        width: 100%;
        margin-top: 125px;
        height: 10px;
        background-color: #00ff33;

    }

    #container {
        position: relative;
        top: 100px;
        left: 60px;
    }
    #container canvas, #overlay {
        position: absolute;
    }
    .item {
        background-color: #3F5F90;
        width: 1000px;
        height: 500px;
        position: relative;
    }

    #contractImg {
        position:absolute;
        top:0;
        bottom:0;
        margin:auto;
    }

    .h1{
        display: block;
        margin-top: 1em;
        margin-bottom: 1em;
        margin-left: 30px;
        margin-right: 30px;
    }

    p {
        display: block;
        margin-top: 1em;
        margin-bottom: 1em;
        margin-left: 30px;
        margin-right: 30px;
        height: 55px;
    }
</style>