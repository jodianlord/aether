<%-- 
    Document   : dashboard
    Created on : 19-Jul-2018, 12:55:31
    Author     : jodia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.aether.dao.UserDAO, com.aether.blockchain.BlockchainHandler" %>
<%@page import="java.math.BigInteger"%>
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
        <div class="se-pre-con">                        
        </div>
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

                        <div class="row mt">
                        </div><!-- /row -->

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
                            <div class="green-panel pn">
                                <div class="green-header">
                                    <h5>TRANSFER ETHER</h5>
                                </div>



                                <row>
                                    <div class="col-xs-6">
                                        <input type="text" class="form-control" id="validUserID" placeholder="User ID">
                                    </div>
                                    <div class="col-xs-6" id="userAccountMsg">
                                    </div>


                                </row>

                                <canvas id="serverstatus03" height="100" width="100"></canvas>
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

                                <script>
                                    var userID;
                                    document.getElementById("validUserID").oninput = function () {
                                        var name = $("#validUserID").val();
                                        var filter = "userid=" + name;
                                        $.ajax({
                                            type: "GET",
                                            beforeSend: function (request) {
                                                request.setRequestHeader("X-DreamFactory-API-Key", "a552bede56b69bb18c9f0dbe41d58939d90f88db17c71d3bc08c5428ec94fbe3");
                                            },
                                            url: "http://vm.jordysamuel.com:30308/api/v2/mysql/_table/user",
                                            data: {"filter": filter},
                                            success: function (result) {
                                                console.log(result);
                                                var user = result["resource"];
                                                var element = document.getElementById("userAccountMsg");
                                                if (user.length < 1) {
                                                    $('#userAccountMsg').addClass("fail");
                                                    element.innerHTML = "No such user found!";
                                                    document.getElementById("transferEther").disabled = true;
                                                } else {
                                                    document.getElementById("transferEther").disabled = false;
                                                    element.innerHTML = user[0]["userid"] + " is found! ";
                                                    userID = user[0]["userid"];
                                                    $('#userAccountMsg').removeClass("fail");
                                                    $('#userAccountMsg').addClass("success");
                                                    document.getElementById("transferEther").addEventListener("click", function () {
                                                        console.log(userID);
                                                        var from = "<%=session.getAttribute("userid")%>";
                                                        var to = userID;
                                                        var password = document.getElementById("password").value;
                                                        var value = document.getElementById("ethervalue").value;
                                                        $.ajax({
                                                            url: "./TransactionServlet",
                                                            type: "GET",
                                                            data: {
                                                                from: from,
                                                                to: to,
                                                                password: password,
                                                                value: value
                                                            },
                                                            success: function (response) {
                                                                $.alert({
                                                                    title: 'Success!',
                                                                    content: 'Transaction Sent!',
                                                                });
                                                            },
                                                            error: function (xhr) {
                                                                $.alert({
                                                                    title: 'Failure!',
                                                                    content: 'Transaction Not Sent!',
                                                                });
                                                            }
                                                        });
                                                    });
                                                }
                                            }
                                        });
                                    }

                                </script>

                                <div class="co-xs-6">

                                    <row>
                                        <div class="col-xs-6">
                                            <input type="text" class="form-control" id="ethervalue" placeholder="Transfer Ether (WEI)">
                                            <input type="password" class="form-control" id="password" placeholder="Input Password">
                                        </div>

                                        <div class="col-xs-6">
                                            <button style="width:100%" type="button" class="btn btn-success" id="transferEther" disabled>Transfer</button>
                                        </div>

                                    </row>

                                </div>

                            </div>


                        </div>

                    </div>

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
        <style>
            div {

            }
            .success {
                color: green;
            }
            .fail {
                color: red;
            }
        </style>
    </body>
</html>

