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
           url: "./BlockchainVis?method=hash&randomstring=" +  $("#randomval").val(),
           type: "GET",
           success: function(response){
               document.getElementById("hash").innerHTML = response.result;
               transactionHash = response.result;
           },
           error: function(xhr){
           }
        });
    })
    
    $("#encodebtn").click(function(){
        console.log($("#randomval").val());
        $.ajax({
           url: "./BlockchainVis?method=hash&randomstring=" +  $("#randomval").val(),
           type: "GET",
           success: function(response){
               document.getElementById("generatedhash").innerHTML = response.result;
               transactionHash = response.result;
           },
           error: function(xhr){
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