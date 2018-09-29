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
                                        <h1 style="color:white">1</h4>
                                        <img src="img/diploma.svg" style="width:200px;height:200px">
                                    </div>
                                    <div class="item"><h1>2</h4></div>
                                    <div class="item"><h1>3</h4></div>
                                    <div class="item"><h1>4</h4></div>
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
            margin: 10,
            loop: true,
            autoWidth: true,
            items: 4
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
        width: 600px;
        height: 300px;
    }

</style>