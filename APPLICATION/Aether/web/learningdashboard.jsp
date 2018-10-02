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
    try {
        balance = BlockchainHandler.getBalance(publickey);
        eth = BlockchainHandler.convertToEth(balance);
    } catch (NumberFormatException e) {
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
                        <div class="col-lg-12 main-chart">
                            <div class="row mt">
                                <div class="col-lg-6">
                                    <div class="content-panel">
                                        <h4><i class="fa"></i> Filters</h4>
                                        <div class="panel-body text-center">
                                            <label id="" height="300" width="400" style="margin-right: 20px">
                                                Test ID
                                            </label>
                                            <select id="testID" name="testID" required autocomplete="off">
                                                <option value= null selected> TestID </option>
                                                <option value="1">AY2016/17 S1</option>
                                                <option value="2">AY2016/17 S2</option>
                                                <option value="3">AY2017/18 S1</option>
                                                <option value="4">AY2017/18 S2</option>
                                                
                                            </select>
                                            </br>
                                            
                                            
                                            
                                        </div>
                                    </div>
                                </div>
                            
                                <div class="col-lg-6">
                                    <div class="content-panel">
                                        <h4><i class="fa"></i> Chart Overview</h4>
                                        <div class="panel-body text-center">
                                            Bar Chart will come here (Based on Test Id)
                                            <canvas id="bar" height="100" width="400">
                                                
                                                
                                            </canvas>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>



                        <div class="col-lg-12 main-chart">
                            <div class="row mt">
                            </div><!-- /row -->
                            <div class="row">

                                <div class="col-md-12">
                                    <div class="content-panel">
                                        <h4><i class="fa"></i>Learning Dashboard</h4>
                                        <hr>
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>User ID</th>
                                                    <th>Question ID</th>
                                                    <th>Correct Answer</th>
                                                    <th>User Answer</th>
                                                    <th>Points Obtained</th>
                                                    <th>Time Taken</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>1</td>
                                                    <td>Cneo</td>
                                                    <td>100</td>
                                                    <td>A</td>
                                                    <td>A</td>
                                                    <td>100 ETH</td>
                                                    <td>00:50</td>
                                                </tr>
                                                <tr>
                                                    <td>1</td>
                                                    <td>Cneo</td>
                                                    <td>100</td>
                                                    <td>A</td>
                                                    <td>A</td>
                                                    <td>100 ETH</td>
                                                    <td>01:30</td>
                                                </tr>
                                                <tr>
                                                    <td>1</td>
                                                    <td>Cneo</td>
                                                    <td>100</td>
                                                    <td>A</td>
                                                    <td>A</td>
                                                    <td>100 ETH</td>
                                                    <td>00:27</td>
                                                </tr>

                                            </tbody>
                                        </table>
                                    </div><! --/content-panel -->
                                </div><!-- /col-md-12 -->

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
            document.getElementById("learningdashboardside").className = "active";
        </script>

        <%@include file="Components/style.html" %>

    </body>
</html>

