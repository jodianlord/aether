<%-- 
    Document   : dashboard
    Created on : 19-Jul-2018, 12:55:31
    Author     : jodia
--%>

<%@page import="java.math.BigInteger"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.aether.dao.UserDAO, com.aether.blockchain.BlockchainHandler" %>
<!DOCTYPE html>
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
                                    <div class="item">

                                        <h1 style="color:white">1: Contract Fundamentals</h1>
                                        <div class="row"></div>
                                        <div class="row">
                                            <div class = "column">
                                                <img id="contractImg" src="img/diploma.svg" style="width:200px;height:200px">
                                            </div>
                                            <div class = "column">
                                                <p style="color:white; font-size:20px">
                                                    This is a visualisation of what a contract is. You can think of a contract as an agreement between an account and the blockchain. Click the contract to take a look!
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="item"><h1 style="color:white">2</h1></div>
                                    <div class="item"><h1 style="color:white">3</h1></div>
                                    <div class="item"><h1 style="color:white">4</h1></div>
                                </div>
                            </div>
                        </div>
                    </section>

                    <!--main content end-->
            </section>

            <%@include file="Components/script.html" %>
            <!--set dashboard button to active-->
            <script type="application/javascript">
                document.getElementById("visualisationside").className = "active";
            </script>
            <%@include file="Components/style.html" %>

            <script src="js/jquery-1.8.3.min.js"></script>
            <script src="js/owlcarousel/js/owl.carousel.js"></script>
    </body>
</html>
<script type="text/javascript">
    $(document).ready(function () {
        $(".owl-carousel").owlCarousel({
            navigation: true,
            singleItem: true,
            autoWidth: true,
            margin: 100,
            center: true
        });
    });
</script>
<style>
    #container {
        position: relative;
        top: 100px;
        left: 60px;
    }
    #container canvas, #overlay {
        position: absolute;
    }
    .item {
        background-color: rgb(94, 110, 148);
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
    }

    .row {
        display: flex;
    }

    .column {
        flex: 50%;
    }

</style>