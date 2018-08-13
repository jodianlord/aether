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
                        <div class="col-lg-1"></div>
                        <form id="details">
                            <div class="col-lg-9 main-chart">
                                <div class="row mt">
                                </div><!-- /row -->
                                <div class="row">
                                    <!-- TWITTER PANEL -->
                                    <div class="col-md-12 mb">
                                        <div class="darkblue-panel pn col-md-12">
                                            <div class="darkblue-header">
                                                <h5>Input Details</h5>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="row">
                                                    <div class="form-group" style="display:flex; flex-direction: row; justify-content: center; align-items: center">
                                                        <label class="col-sm-2 col-sm-2 control-label">Name</label>
                                                        <div class="col-sm-10">
                                                            <input type="text" name="fullname" class="form-control round-form">
                                                        </div>
                                                    </div>
                                                    <div class="form-group" style="display:flex; flex-direction: row; justify-content: center; align-items: center">
                                                        <label class="col-sm-2 col-sm-2 control-label">Email</label>
                                                        <div class="col-sm-10">
                                                            <input type="text" name="email" class="form-control round-form">
                                                        </div>
                                                    </div>
                                                    <div class="form-group" style="display:flex; flex-direction: row; justify-content: center; align-items: center">
                                                        <label class="col-sm-2 col-sm-2 control-label">Mobile</label>
                                                        <div class="col-sm-10">
                                                            <input type="text" name="mobile" class="form-control round-form">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="row">
                                                    <div class="form-group" style="display:flex; flex-direction: row; justify-content: center; align-items: center">
                                                        <label class="col-sm-2 col-sm-2 control-label">Nationality</label>
                                                        <div class="col-sm-10">
                                                            <input type="text" name="nationality" class="form-control round-form">
                                                        </div>
                                                    </div>
                                                    <div class="form-group" style="display:flex; flex-direction: row; justify-content: center; align-items: center">
                                                        <label class="col-sm-2 col-sm-2 control-label">Occupation</label>
                                                        <div class="col-sm-10">
                                                            <input type="text" name="occupation" class="form-control round-form">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div><!-- /darkblue panel -->
                                    </div><!-- /col-md-4 -->
                                </div><!-- /row -->
                            </div><!-- /col-lg-9 END SECTION MIDDLE -->
                        </form>
                    </div><!--/row -->
                    <div class="row">
                        <div class="col-lg-1"></div>
                        <div class="col-lg-9 main-chart">
                            <div class="row">
                                <!-- TWITTER PANEL -->
                                <div class="col-md-6 mb">
                                    <div class="darkblue-panel pn">
                                        <div class="darkblue-header">
                                            <h5>UPLOAD DOCUMENTS</h5>
                                        </div>
                                    </div><! -- /darkblue panel -->
                                </div><!-- /col-md-4 -->

                                <div class="col-md-6 col-sm-6 mb">
                                    <!-- REVENUE PANEL -->
                                    <div class="darkblue-panel pn" id="picture">
                                        <div class="darkblue-header">
                                            <h5>Take Your Picture</h5>
                                        </div>
                                        <!-- Take picture here -->
                                        <div id="media">
                                            <video id="video" class="col-md-6 col-sm-6 mb"></video>
                                            <canvas id="canvas" class="col-md-6 col-sm-6 mb"></canvas>
                                        </div>
                                        <div class="col-md-6 mb"></div>
                                        <div>
                                            <button id="startstream" type="button" class="btn btn-primary">Start Camera</button>
                                            <div class="col-md-6 mb"></div>
                                            <button id="capture" type="button" class="btn btn-theme04">Take Photo</button>
                                        </div>
                                    </div>
                                </div><!-- /col-md-4 -->
                            </div><!-- /row -->
                        </div><!-- /col-lg-9 END SECTION MIDDLE -->
                    </div><!--/row -->

                </section>
            </section>

            <!--main content end-->
        </section>

        <%@include file="Components/script.html" %>
        <!--set dashboard button to active-->
        <script type="application/javascript">
            document.getElementById("identityside").className = "active";
        </script>
        <script src ="js/takePhoto.js"></script>

        <%@include file="Components/style.html" %>

    </body>
</html>

