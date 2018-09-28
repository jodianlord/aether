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
                            <div class="large-12 columns">
                                <div class="owl-carousel owl-theme">
                                    <div class="item" data-hash="zero">
                                        
                                        <img src ="img/diploma.svg">
                                        <h4>1) Contract</h4>
                                        
                                    </div>
                                    <div class="item" data-hash="one">
                                        <h4>2) Contract Code </h4>
                                    </div>
                                    <div class="item" data-hash="two">
                                        <h4>3) </h4>
                                    </div>
                                    <div class="item" data-hash="three">
                                        <h4>3</h4>
                                    </div>
                                    <div class="item" data-hash="four">
                                        <h4>4</h4>
                                    </div>
                                    
                                    
                                </div>
                                <hr>
                                <a class="button secondary url" href="#zero">zero</a> 
                                <a class="button secondary url" href="#one">one</a> 
                                <a class="button secondary url" href="#two">two</a> 
                                <a class="button secondary url" href="#three">three</a> 
                                <a class="button secondary url" href="#four">four</a> 
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
    $('.owl-carousel').owlCarousel({
        items: 4,
        loop: false,
        center: true,
        margin: 10,
        URLhashListener: true,
        autoplayHoverPause: true,
        startPosition: 'URLHash'
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


</style>