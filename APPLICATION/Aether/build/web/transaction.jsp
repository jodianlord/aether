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
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="Dashboard">
        <meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">

        <title>Aether</title>

        <!-- Bootstrap core CSS -->
        <link href="css/bootstrap.css" rel="stylesheet">
        <!--external css-->
        <link href="font-awesome/css/font-awesome.css" rel="stylesheet" />
        <link rel="stylesheet" type="text/css" href="css/zabuto_calendar.css">
        <link rel="stylesheet" type="text/css" href="js/gritter/css/jquery.gritter.css" />
        <link rel="stylesheet" type="text/css" href="lineicons/style.css">    
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.1/css/all.css" integrity="sha384-O8whS3fhG2OnA5Kas0Y9l3cfpmYjapjI0E4theH4iuMD+pLhbf6JI0jIMfYcK3yZ" crossorigin="anonymous">

        <!-- Custom styles for this template -->
        <link href="css/style.css" rel="stylesheet">
        <link href="css/style-responsive.css" rel="stylesheet">

        <script src="js/chart-master/Chart.js"></script>

        <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
    </head>

    <body>

        <section id="container" >
            <!-- **********************************************************************************************************************************************************
            TOP BAR CONTENT & NOTIFICATIONS
            *********************************************************************************************************************************************************** -->
            <!--header start-->
            <header class="header black-bg">
                <div class="sidebar-toggle-box">
                    <div class="fa fa-bars tooltips" style="color:#0d101c" data-placement="right" data-original-title="Toggle Navigation"></div>
                </div>
                <!--logo start-->
                <a href="dashboard.jsp" class="logo"><b>Aether</b></a>
                <!--logo end-->
                <div class="top-menu">
                    <ul class="nav pull-right top-menu">
                        <li><a class="logout" href="login.html">Logout</a></li>
                    </ul>
                </div>
            </header>
            <!--header end-->

            <!-- **********************************************************************************************************************************************************
            MAIN SIDEBAR MENU
            *********************************************************************************************************************************************************** -->
            <!--sidebar start-->
            <aside>
                <div id="sidebar"  class="nav-collapse ">
                    <!-- sidebar menu start-->
                    <ul class="sidebar-menu" id="nav-accordion">

                        <p class="centered"><a href="profile.html"><img src="img/ui-sam.jpg" class="img-circle" width="60"></a></p>
                        <h5 class="centered"><%=session.getAttribute("userid")%></h5>

                        <li class="mt">
                            <a href="dashboard.jsp">
                                <i class="fa fa-dashboard"></i>
                                <span>Dashboard</span>
                            </a>
                        </li>

                        <li class="sub-menu">
                            <a href="javascript:;" >
                                <i class="fa fa-user"></i>
                                <span>Verify New User</span>
                            </a>
                        </li>

                        <li class="sub-menu">
                            <a class="active" href="transaction.jsp" >
                                <i class="fa fa-money-bill-wave"></i>
                                <span>Make A transaction</span>
                            </a>
                        </li>
                        <li class="sub-menu">
                            <a href="javascript:;" >
                                <i class="fa fa-book"></i>
                                <span>Extra Pages</span>
                            </a>
                            <ul class="sub">
                                <li><a  href="blank.html">Blank Page</a></li>
                                <li><a  href="login.html">Login</a></li>
                                <li><a  href="lock_screen.html">Lock Screen</a></li>
                            </ul>
                        </li>
                        <li class="sub-menu">
                            <a href="javascript:;" >
                                <i class="fa fa-tasks"></i>
                                <span>Forms</span>
                            </a>
                            <ul class="sub">
                                <li><a  href="form_component.html">Form Components</a></li>
                            </ul>
                        </li>
                        <li class="sub-menu">
                            <a href="javascript:;" >
                                <i class="fa fa-th"></i>
                                <span>Data Tables</span>
                            </a>
                            <ul class="sub">
                                <li><a  href="basic_table.html">Basic Table</a></li>
                                <li><a  href="responsive_table.html">Responsive Table</a></li>
                            </ul>
                        </li>
                        <li class="sub-menu">
                            <a href="javascript:;" >
                                <i class=" fa fa-bar-chart-o"></i>
                                <span>Charts</span>
                            </a>
                            <ul class="sub">
                                <li><a  href="morris.html">Morris</a></li>
                                <li><a  href="chartjs.html">Chartjs</a></li>
                            </ul>
                        </li>

                    </ul>
                    <!-- sidebar menu end-->
                </div>
            </aside>
            <!--sidebar end-->

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

        <!-- js placed at the end of the document so the pages load faster -->
        <script src="js/jquery.js"></script>
        <script src="js/jquery-1.8.3.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script class="include" type="text/javascript" src="js/jquery.dcjqaccordion.2.7.js"></script>
        <script src="js/jquery.scrollTo.min.js"></script>
        <script src="js/jquery.nicescroll.js" type="text/javascript"></script>
        <script src="js/jquery.sparkline.js"></script>

        <!--script for text effect-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/animejs/2.0.2/anime.min.js"></script>

        <!--common script for all pages-->
        <script src="js/common-scripts.js"></script>

        <script type="text/javascript" src="js/gritter/js/jquery.gritter.js"></script>
        <script type="text/javascript" src="js/gritter-conf.js"></script>

        <!--script for this page-->
        <script src="js/sparkline-chart.js"></script>    
        <script src="js/zabuto_calendar.js"></script>	

        <script type="application/javascript">
            $(document).ready(function () {
            $("#date-popover").popover({html: true, trigger: "manual"});
            $("#date-popover").hide();
            $("#date-popover").click(function (e) {
            $(this).hide();
            });

            $("#my-calendar").zabuto_calendar({
            action: function () {
            return myDateFunction(this.id, false);
            },
            action_nav: function () {
            return myNavFunction(this.id);
            },
            ajax: {
            url: "show_data.php?action=1",
            modal: true
            },
            legend: [
            {type: "text", label: "Special event", badge: "00"},
            {type: "block", label: "Regular event", }
            ]
            });
            });


            function myNavFunction(id) {
            $("#date-popover").hide();
            var nav = $("#" + id).data("navigation");
            var to = $("#" + id).data("to");
            console.log('nav ' + nav + ' to: ' + to.month + '/' + to.year);
            }
        </script>

        <script type="application/javascript">
            anime.timeline({loop: false})
            .add({
            targets: '.ml15 .word',
            scale: [14,1],
            opacity: [0,1],
            easing: "easeOutCirc",
            duration: 200,
            delay: function(el, i) {
            return 800 * i;
            }
            })
        </script>

        <style>
            .ml15 {
                font-weight: 800;
                font-size: 3em;
                text-transform: uppercase;
                letter-spacing: 0.5em;
            }

            .ml15 .word {
                display: inline-block;
                line-height: 1em;
            }
        </style>

    </body>
</html>

