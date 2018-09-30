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

                                    <!-- 1. Contract Fundamentals-->
                                    <div class="item">
                                        </br>
                                        <h1 style="color:#EFD67F;margin-left:30px;margin-top: 30px">1: Contract Fundamentals</h1>
                                        <p style="color:white;margin-left:30px; font-size:20px">
                                            This is a visualisation of what a contract is. You can think of a contract as an agreement between an account and the blockchain. Click the contract to take a look!
                                        </p>
                                        <img id="contractImg" src="img/diploma.svg" style="position: relative;width:200px;height:200px">
                                        <div id="progressbar"></div>
                                    </div>

                                    <!-- 2. Second -->
                                    <div class="item">
                                        </br>
                                        <h1 style="color:#EFD67F;margin-left:30px;margin-top: 30px">2: Step 2</h1>
                                        <p style="color:white;margin-left:30px; font-size:20px">
                                            Step 2
                                        </p>
                                        <img id="contractImg" src="img/diploma.svg" style="position: relative;width:200px;height:200px">
                                        <div id="progressbar"></div>
                                    </div>

                                    <!-- 3. Third-->
                                    <div class="item">
                                        </br>
                                        <h1 style="color:#EFD67F;margin-left:30px;margin-top: 30px">3: Step 3</h1>
                                        <p style="color:white;margin-left:30px; font-size:20px">
                                            Step 3
                                        </p>
                                        <img id="contractImg" src="img/diploma.svg" style="position: relative;width:200px;height:200px">
                                        <div id="progressbar"></div>
                                    </div>
                                    
                                    <!-- 4. Fourth-->
                                    <div class="item">
                                        </br>
                                        <h1 style="color:#EFD67F;margin-left:30px;margin-top: 30px">4: Step 4</h1>
                                        <p style="color:white;margin-left:30px; font-size:20px">
                                            Step 4
                                        </p>
                                        <img id="contractImg" src="img/diploma.svg" style="position: relative;width:200px;height:200px">
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
</script>
<script src="js/owlvisualisation.js"></script>
<style>
    #progressbar{
        position: relative;
        width: 100%;
        margin-top: 108px;
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

<<<<<<< HEAD

=======
>>>>>>> 8df291e84a54687993cf7cbff348acdc66893e08

</style>