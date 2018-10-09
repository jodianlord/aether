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
        <div class="se-pre-con">                        
        </div>
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


                                    <!-- What is a Blockchain?-->
                                    <div class="item" style="background-color:#8a3b3b">
                                        </br>
                                        <h1 style="color:#EFD67F;margin-left:30px;margin-top: 30px">What is a Blockchain?</h1>
                                        <div style="height:260px">
                                            <p style="color:white;margin-left:30px; font-size:20px;height:60px">
                                                A block in blockchain can be seen as a list of data which can be assessed anywhere. Once data is stored in a block, it becomes very difficult to change it. This removes the need for a central authority as it eliminates any form of manipulation by third parties.    
                                            </p>
                                            <div style="position: relative;left:20%;margin-top:10px" id ="canvasdiv"></div>
                                            <!--<img id="contractImg" src="img/diploma.svg" style="position: relative;width:200px;height:200px">-->


                                            <!--<div id="progressbar"></div>-->
                                        </div>

                                        <!-- What is in a Blockchain?-->
                                        <div class="item" style="background-color:#8a3b3b">
                                            </br>
                                            <h1 style="color:#EFD67F;margin-left:30px;margin-top: 30px">What is in a Blockchain?</h1>
                                            <div style="height:260px">
                                                <p style="color:white;margin-left:30px; font-size:20px;height:60px">
                                                    A block in a blockchain consists of 3 components:</br></br>
                                                    1. <b>Data:</b> Data stored here is dependent on the type of blockchain. For the KYC process, Ethereum (a type of blockchain) is used as it can store smart contracts as its data.</br></br></br>
                                                    2. <b>Hash:</b> The hash uniquely identifies a block and its contents. When the contents change, the hash changes as well. </br></br></br>
                                                    3. <b>Hash of previous block:</b> This is the chain in blockchain as it links one block to one another. This is what makes it very difficult to change the data stored on the block.
                                                    <!--</p>-->
                                                    <!--<img id="contractImg" src="img/diploma.svg" style="position: relative;width:200px;height:200px">-->
                                            </div>

                                            <!--<div id="progressbar"></div>-->
                                        </div>


                                        <!--What are Smart Contracts-->
                                        <div class="item" style="background-color:#8a3b3b">
                                            </br>
                                            <h1 style="color:#EFD67F;margin-left:30px;margin-top: 30px">What are Smart Contracts?</h1>
                                            <div style="height:260px">
                                                <p style="color:white;margin-left:30px; font-size:20px;height:60px">
                                                    A smart contract is a tiny computer program stored in a block in a blockchain. This can be coded using Solidity which syntax resembles JavaScript. A smart contract in the blockchain make it immutable and distributed. 
                                                    </br></br></br><b>Immutable:</b> Once a smart contract is created, it can never be changed again
                                                    </br></br></br><b>Distributed:</b> Output of contract is validated by everyone on the blockchain network
                                                </p>
                                                <!--<img id="contractImg" src="img/diploma.svg" style="position: relative;width:200px;height:200px">-->
                                            </div>

                                            <!--<div id="progressbar"></div>-->
                                        </div>

                                        <!--Linking it all up-->
                                        <div class="item" style="background-color:#8a3b3b">
                                            </br>
                                            <h1 style="color:#EFD67F;margin-left:30px;margin-top: 30px">Linking It All</h1>
                                            <div style="height:260px">
                                                <p style="color:white;margin-left:30px; font-size:20px;height:60px">
                                                    Recall back to when you created your digital identity and a BIN file is sent to your email. 
                                                    <br><br>In this BIN file, it contains a transaction hash. The purpose of this transaction hash is to serve as a "address" to where your smart contract is stored on which block on the blockchain. 
                                                    <br><br>Remember that a smart contract is essentially a tiny computer program on the block.
                                                    <br><br>In this case, the smart contract is programmed to receive a input and give a output like a vending machine.
                                                    <br><br>Hence, the input of a hash value will be matched to the hash the smart contract in on. If it matches, it will output your particulars. 

                                                </p>
                                                <!--<img id="contractImg" src="img/diploma.svg" style="position: relative;width:200px;height:200px">-->
                                            </div>

                                            <!--<div id="progressbar"></div>-->
                                        </div>

                                        <!--Lets try!-->
                                        <div class="item" style="background-color:#8a3b3b">
                                            </br>
                                            <h1 style="color:#EFD67F;margin-left:30px;margin-top: 30px">Let's try!</h1>
                                            <div style="height:260px">
                                                <p style="color:white;margin-left:30px; font-size:20px;height:60px">
                                                    Now let's try to deploy a smart contract!     
                                                </p>
                                                <!--<img id="contractImg" src="img/diploma.svg" style="position: relative;width:200px;height:200px">-->
                                            </div>

                                            <!--<div id="progressbar"></div>-->
                                        </div>









                                        <!-- 1. Contract Fundamentals-->


                                        <!-- 1. Overview-->
                                        <div class="item">
                                            </br>
                                            <h1 style="color:#EFD67F;margin-left:30px;margin-top: 30px">1: Overview</h1>
                                            <div style="height:260px">
                                                <p style="color:white;margin-left:30px; font-size:20px;height:60px">
                                                    Let's wind back to the activity just now. Remember when we were keying the customer's details? This is something similar. Key in some values here.
                                                </p>
                                                <div>
                                                    <input type="text" class="form-control" id="randomval" style="position: relative;margin-left: 30px;width:300px;" placeholder="Enter Values here!">

                                                </div>

                                            </div>

                                            <div id="progressbar"></div>
                                        </div>

                                        <!-- 2. Encoding -->

                                        <div class="item">
                                            </br>
                                            <h1 style="color:#EFD67F;margin-left:30px;margin-top: 30px">2: Encoding</h1>
                                            <div style="height:260px">
                                                <p style="color:white;margin-left:30px; font-size:20px;height:60px">
                                                    In the case of this application, we do not encode (you can think of this as 'uploading') the values directly to the blockchain. Instead we generate a Keccak256 hash (a line of text that changes depending on what's in the file). Press the button below to generate the hash for the values you just put in. If you want to see this change, type different text on the previous screen!
                                                </p>
                                                </br></br></br></br>
                                                <input type="button" class="btn btn-red" id="encodebtn" value="Encode" style="position: relative;margin-left: 30px;width:300px;">
                                                <div id="generatedhash" style="color:greenyellow;margin:10px 10px 10px 10px"></div>
                                                <!--<button class="btn btn-red">-->
                                            </div>

                                            <div id="progressbar"></div>
                                        </div>

                                        <!-- 3. Third-->
                                        <div class="item">
                                            </br>
                                            <h1 style="color:#EFD67F;margin-left:30px;margin-top: 30px">3: Let's deploy a contract!</h1>
                                            <div style = "height:260px">
                                                <p style="color:white;margin-left:30px; font-size:20px;height:60px">
                                                    Now that you have the Keccak 256 Hash of the data you want to encode, click the button below to generate a unique ID for your data. This is randomly generated and serves to identify your data from the rest.
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
                                        <!--                                    <div class="item">
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
                                                                                                <span class="word"><!%= eth%> ETH</span>
                                                                                            </h1>
                                                                                            -
                                                                                            <h1 class="ml15">
                                                                                                <span class="word"> WEI</span>
                                                                                            </h1>
                                                                                            
                                                                                        </div>
                                                                                    </div>
                                                                                </div> /col-md-4 <div id="progressbar"></div>
                                                                            </div>-->

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


                                        <!--Why Blockchain and Smart Contracts in KYC?-->
                                        <div class="item" style="background-color:#8a3b3b">
                                            </br>
                                            <h1 style="color:#EFD67F;margin-left:30px;margin-top: 30px">Why Blockchain and Smart Contracts in KYC?</h1>
                                            <div style="height:260px">
                                                <p style="color:white;margin-left:30px; font-size:20px;height:60px">
                                                    Lets review your step(s) that you have did just now! : How is it being applied? 
                                                    </br></br>
                                                    Blockchain uses a peer-to-peer network. You can think of the banks and KYC agents as part of the network. 
                                                    When a new block which contains a smart contract is created, it is sent to everyone in the network. 
                                                    This means that each bank in the network will get a copy of the customer block which the contains the smart contract.
                                                </p>
                                                <!--<img id="contractImg" src="img/diploma.svg" style="position: relative;width:200px;height:200px">-->
                                            </div>

                                            <!--<div id="progressbar"></div>-->
                                        </div>

                                        <!--Why Blockchain and Smart Contracts in KYC? Part:2-->
                                        <div class="item" style="background-color:#8a3b3b">
                                            </br>
                                            <h1 style="color:#EFD67F;margin-left:30px;margin-top: 30px">Why Blockchain and Smart Contracts in KYC?</h1>
                                            <div style="height:260px">
                                                <p style="color:white;margin-left:30px; font-size:20px;height:60px">                                   
                                                    However, they cannot access this block of customer data unless the customer provides them with their transaction hash to unlock the smart contract. This means that a bank cannot create a bank account for the customer unless the customer provides “authorisation”. This “authorisation” comes in the form of the bin file sent to the customer and the use of facial recognition.

                                                </p>
                                                <!--<img id="contractImg" src="img/diploma.svg" style="position: relative;width:200px;height:200px">-->
                                            </div>

                                            <!--<div id="progressbar"></div>-->
                                        </div>


                                        <!-- IT's Time to create your Bank Account -->
                                        <!--                                    <div class="item" style="background-color:white">
                                                                                </br>
                                                                                <h1 style="color:#EFD67F;margin-left:30px;margin-top: 30px">It's time to create your Bank Account</h1>
                                                                                <div style="height:260px">
                                                                                    <p style="color:black;margin-left:30px; font-size:20px;height:60px">
                                                                                        Please select the Bank that you want to create your account with!
                                                                                    </p>
                                                                                    
                                                                                    <a href="https://sm.jordysamuel.com:30307/bank_b/">
                                                                                        <img src="img/logo_tbank_alt.png" style="position: relative;height:50%;width:30%;margin-left:30px;margin-top: 30px">
                                                                                    </a>
                                                                                </div>
                                        
                                                                                <div id="progressbar"></div>
                                                                            </div>-->


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
<script src="js/konva.min.js"></script>
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
        $.ajax({
            url: "./BlockchainVis?method=hash&randomstring=" + $("#randomval").val(),
            type: "GET",
            success: function (response) {
                document.getElementById("hash").innerHTML = response.result;
                transactionHash = response.result;
            },
            error: function (xhr) {
            }
        });
    })

    $("#encodebtn").click(function () {
        console.log($("#randomval").val());
        $.ajax({
            url: "./BlockchainVis?method=hash&randomstring=" + $("#randomval").val(),
            type: "GET",
            success: function (response) {
                document.getElementById("generatedhash").innerHTML = response.result;
                transactionHash = response.result;
            },
            error: function (xhr) {
            }
        });
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