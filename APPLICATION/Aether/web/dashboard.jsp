<%-- 
    Document   : dashboard
    Created on : 19-Jul-2018, 12:55:31
    Author     : jodia
--%>

<%@page import="java.math.BigInteger"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.aether.dao.UserDAO, com.aether.blockchain.BlockchainHandler" %>
<!DOCTYPE html>
<%
    String publickey = UserDAO.getUser((String) session.getAttribute("userid")).getPublicKey();
    BigInteger balance = new BigInteger("0");
    BigInteger eth = new BigInteger("0");
    try{
        balance = BlockchainHandler.getBalance(publickey);
        eth = BlockchainHandler.convertToEth(balance);
    }catch(NumberFormatException e){
    }
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
                                            <span class="word"><%= eth%> ETH</span>
                                        </h1>
                                        <h1 class="ml15">
                                            <span class="word"><%= balance%> WEI</span>
                                        </h1>
                                    </div><! -- /darkblue panel -->
                                </div><!-- /col-md-4 -->


                                <div class="col-md-6 col-sm-6 mb">
                                    <!-- REVENUE PANEL -->
                                    <div class="darkblue-panel pn">
                                        <div class="darkblue-header">
                                            <h5>REVENUE</h5>
                                        </div>
                                        <div class="chart mt">
                                            <div class="sparkline" data-type="line" data-resize="true" data-height="75" data-width="90%" data-line-width="1" data-line-color="#fff" data-spot-color="#fff" data-fill-color="" data-highlight-line-color="#fff" data-spot-radius="4" data-data="[200,135,667,333,526,996,564,123,890,464,655]"></div>
                                        </div>
                                        <p class="mt"><b>$ 17,980</b><br/>Month Income</p>
                                    </div>
                                </div><!-- /col-md-4 -->

                            </div><!-- /row -->

                        </div><!-- /col-lg-9 END SECTION MIDDLE -->



                    </div><! --/row -->
                </section>
            </section>

            <!--main content end-->
        </section>

        <%@include file="Components/script.html" %>
        <!--set dashboard button to active-->
        <script type="application/javascript">
            document.getElementById("dashboardside").className = "active";
        </script>
        
        <%@include file="Components/style.html" %>

    </body>
</html>

