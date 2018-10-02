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
    } catch (NullPointerException e) {

    }
%>
<html lang="en">
    <%@include  file="Components/head.html" %>
    <link rel=¨stylesheet¨ type=¨text/css¨ src="css\quiz.css">
    <script src="https://unpkg.com/jquery"></script>
    <script src="https://surveyjs.azureedge.net/1.0.46/survey.jquery.js"></script>
    <link href="https://surveyjs.azureedge.net/1.0.46/survey.css" type="text/css" rel="stylesheet"/>
    <link rel="stylesheet" href="./index.css">
    
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
                                <div class="container">
                                    <h2>Basic Modal Example</h2>
                                    <!-- Trigger the modal with a button -->

                                    <button class="btn btn-lg btn-info open-modal">Open modal with JS</button>

                                    <!-- Modal -->
                                    <div class="modal fade" id="myModal" role="dialog">
                                        <div class="modal-dialog">

                                            <!-- Modal content-->
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                    <h4 class="modal-title">Modal Header</h4>
                                                </div>
                                                <div class="modal-body">
                                                    <div id="surveyElement"></div>
                                                    <div id="surveyResult"></div>

                                                    <script type="text/javascript" src="js/testQuiz.js"></script>
                                                    
                                                    
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                </div>
                                            </div>

                                        </div>
                                    </div>

                                </div>

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
        <!--        <script type="application/javascript" src="js/quizlet.js"></script>-->

        <script type="application/javascript">
            $(document).on('ready', function() {
            $('.open-modal').click(function() {
            $('#myModal').modal();
            });
            });
        </script>


        <%@include file="Components/style.html" %>

    </body>
</html>

