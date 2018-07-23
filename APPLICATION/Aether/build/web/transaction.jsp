<%-- 
    Document   : dashboard
    Created on : 19-Jul-2018, 12:55:31
    Author     : jodia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.aether.dao.UserDAO, com.aether.blockchain.BlockchainHandler" %>
<!DOCTYPE html>
<%
    String publickey = UserDAO.getUser((String) session.getAttribute("userid")).getPublicKey();
    String balance = BlockchainHandler.getBalance(publickey);
    double eth = BlockchainHandler.convertToEth(balance);
%>
<html lang="en">
    <%@include  file="Components/head.html" %>

    <body>

        <section id="container" >
            <%@include  file="Components/topbar.html" %>
            <%@include  file="Components/sidebar.html" %>

            <!-- **********************************************************************************************************************************************************
            MAIN CONTENT
            *********************************************************************************************************************************************************** -->
            <!--main content start-->
            <section id="main-content">
                <section class="wrapper">

                    <div class="row">
                        <div class="col-lg-1"></div>
                        <div class="col-lg-9 main-chart">
                            <div class="row mt">
                            </div><!-- /row -->
                            <div class="row">
                                <!-- TWITTER PANEL -->
                                <div class="col-md-6 mb">
                                    <div class="darkblue-panel pn">
                                        <div class="darkblue-header">
                                            <h5>BALANCE</h5>
                                        </div>
                                        <h1 class="ml15">
                                            <span class="word"><%= eth%></span>
                                            <span class="word">ETH</span>
                                        </h1>
                                        <h1 class="ml15">
                                            <span class="word"><%= balance%></span>
                                            <span class="word">WEI</span>
                                        </h1>
                                    </div><! -- /darkblue panel -->
                                </div><!-- /col-md-4 -->


                                <div class="col-md-6 col-sm-6 mb">
                                    <div class="grey-panel pn donut-chart">
                                        <div class="grey-header">
                                            <h5>SELECT ACCOUNT TO TRANSFER</h5>
                                        </div>
                                        <canvas id="serverstatus01" height="120" width="120"></canvas>
                                        <script>
                                            var doughnutData = [
                                                {
                                                    value: 70,
                                                    color: "#FF6B6B"
                                                },
                                                {
                                                    value: 30,
                                                    color: "#fdfdfd"
                                                }
                                            ];
                                            var myDoughnut = new Chart(document.getElementById("serverstatus01").getContext("2d")).Doughnut(doughnutData);
                                        </script>
                                        <div class="row">
                                            <div class="col-sm-6 col-xs-6 goleft">
                                                <p>Usage<br/>Increase:</p>
                                            </div>
                                            <div class="col-sm-6 col-xs-6">
                                                <h2>21%</h2>
                                            </div>
                                        </div>
                                    </div><! --/grey-panel -->
                                </div><!-- /col-md-4-->

                            </div><!-- /row -->

                            <div class="row">
                                <div class="col-md-6 col-sm-6 col-md-offset-3 mb">
                                    <div class="green-panel pn">
                                        <div class="green-header">
                                            <h5>TRANSFER ETHER</h5>
                                        </div>
                                        <canvas id="serverstatus03" height="120" width="120"></canvas>
                                        <script>
                                            var doughnutData = [
                                                {
                                                    value: 60,
                                                    color: "#2b2b2b"
                                                },
                                                {
                                                    value: 40,
                                                    color: "#fffffd"
                                                }
                                            ];
                                            var myDoughnut = new Chart(document.getElementById("serverstatus03").getContext("2d")).Doughnut(doughnutData);
                                        </script>
                                        <row>
                                            <div class="co-xs-6">
                                        </row>
                                        <row>
                                            <div class="col-xs-6">
                                                <input type="text" class="form-control" id="ethervalue" placeholder="Transfer Ether">
                                            </div>
                                        </row>

                                        <h3>60% TO TRANSFER</h3>
                                    </div>
                                </div><! --/col-md-4 -->
                            </div>

                        </div><!-- /col-lg-9 END SECTION MIDDLE -->



                    </div><! --/row -->
                </section>
            </section>

            <!--main content end-->
        </section>

        <%@include file="Components/script.html" %>
        
        <!--set dashboard button to active-->
        <script type="application/javascript">
            document.getElementById("transactionside").className = "active";
        </script>
        
        <%@include file="Components/style.html" %>

    </body>
</html>

