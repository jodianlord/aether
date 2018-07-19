<%-- 
    Document   : dashboard
    Created on : 19-Jul-2018, 12:55:31
    Author     : jodia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
                        <h5 class="centered">Marcel Newman</h5>

                        <li class="mt">
                            <a class="active" href="index.html">
                                <i class="fa fa-dashboard"></i>
                                <span>Dashboard</span>
                            </a>
                        </li>

                        <li class="sub-menu">
                            <a href="javascript:;" >
                                <i class="fa fa-user"></i>
                                <span>Verify New User</span>
                            </a>
                            <ul class="sub">
                                <li><a  href="general.html">General</a></li>
                                <li><a  href="buttons.html">Buttons</a></li>
                                <li><a  href="panels.html">Panels</a></li>
                            </ul>
                        </li>

                        <li class="sub-menu">
                            <a href="javascript:;" >
                                <i class="fa fa-cogs"></i>
                                <span>Components</span>
                            </a>
                            <ul class="sub">
                                <li><a  href="calendar.html">Calendar</a></li>
                                <li><a  href="gallery.html">Gallery</a></li>
                                <li><a  href="todo_list.html">Todo List</a></li>
                            </ul>
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
                                <!-- SERVER STATUS PANELS -->
                                <div class="col-md-4 col-sm-4 mb">
                                    <div class="white-panel pn donut-chart">
                                        <div class="white-header">
                                            <h5>SERVER LOAD</h5>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-6 col-xs-6 goleft">
                                                <p><i class="fa fa-database"></i> 70%</p>
                                            </div>
                                        </div>
                                        <canvas id="serverstatus01" height="120" width="120"></canvas>
                                        <script>
                                            var doughnutData = [
                                                {
                                                    value: 70,
                                                    color: "#68dff0"
                                                },
                                                {
                                                    value: 30,
                                                    color: "#fdfdfd"
                                                }
                                            ];
                                            var myDoughnut = new Chart(document.getElementById("serverstatus01").getContext("2d")).Doughnut(doughnutData);
                                        </script>
                                    </div><! --/grey-panel -->
                                </div><!-- /col-md-4-->


                                <div class="col-md-4 col-sm-4 mb">
                                    <div class="white-panel pn">
                                        <div class="white-header">
                                            <h5>TOP PRODUCT</h5>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-6 col-xs-6 goleft">
                                                <p><i class="fa fa-heart"></i> 122</p>
                                            </div>
                                            <div class="col-sm-6 col-xs-6"></div>
                                        </div>
                                        <div class="centered">
                                            <img src="img/product.png" width="120">
                                        </div>
                                    </div>
                                </div><!-- /col-md-4 -->

                                <div class="col-md-4 mb">
                                    <!-- WHITE PANEL - TOP USER -->
                                    <div class="white-panel pn">
                                        <div class="white-header">
                                            <h5>TOP USER</h5>
                                        </div>
                                        <p><img src="img/ui-zac.jpg" class="img-circle" width="80"></p>
                                        <p><b>Zac Snider</b></p>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <p class="small mt">MEMBER SINCE</p>
                                                <p>2012</p>
                                            </div>
                                            <div class="col-md-6">
                                                <p class="small mt">TOTAL SPEND</p>
                                                <p>$ 47,60</p>
                                            </div>
                                        </div>
                                    </div>
                                </div><!-- /col-md-4 -->


                            </div><!-- /row -->


                            <div class="row">
                                <!-- TWITTER PANEL -->
                                <div class="col-md-4 mb">
                                    <div class="darkblue-panel pn">
                                        <div class="darkblue-header">
                                            <h5>BALANCE</h5>
                                        </div>
                                        <h1 class="ml15">
                                            <span class="word">100.00</span>
                                            <span class="word">ETH</span>
                                        </h1>
                                        <p>April 17, 2014</p>
                                        <footer>
                                            <div class="pull-left">
                                                <h5><i class="fa fa-hdd-o"></i> 17 GB</h5>
                                            </div>
                                            <div class="pull-right">
                                                <h5>60% Used</h5>
                                            </div>
                                        </footer>
                                    </div><! -- /darkblue panel -->
                                </div><!-- /col-md-4 -->


                                <div class="col-md-4 mb">
                                    <!-- INSTAGRAM PANEL -->
                                    <div class="instagram-panel pn">
                                        <i class="fa fa-instagram fa-4x"></i>
                                        <p>@THISISYOU<br/>
                                            5 min. ago
                                        </p>
                                        <p><i class="fa fa-comment"></i> 18 | <i class="fa fa-heart"></i> 49</p>
                                    </div>
                                </div><!-- /col-md-4 -->

                                <div class="col-md-4 col-sm-4 mb">
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

                            <div class="row mt">
                                <!--CUSTOM CHART START -->
                                <div class="border-head">
                                    <h3>VISITS</h3>
                                </div>
                                <div class="custom-bar-chart">
                                    <ul class="y-axis">
                                        <li><span>10.000</span></li>
                                        <li><span>8.000</span></li>
                                        <li><span>6.000</span></li>
                                        <li><span>4.000</span></li>
                                        <li><span>2.000</span></li>
                                        <li><span>0</span></li>
                                    </ul>
                                    <div class="bar">
                                        <div class="title">JAN</div>
                                        <div class="value tooltips" data-original-title="8.500" data-toggle="tooltip" data-placement="top">85%</div>
                                    </div>
                                    <div class="bar ">
                                        <div class="title">FEB</div>
                                        <div class="value tooltips" data-original-title="5.000" data-toggle="tooltip" data-placement="top">50%</div>
                                    </div>
                                    <div class="bar ">
                                        <div class="title">MAR</div>
                                        <div class="value tooltips" data-original-title="6.000" data-toggle="tooltip" data-placement="top">60%</div>
                                    </div>
                                    <div class="bar ">
                                        <div class="title">APR</div>
                                        <div class="value tooltips" data-original-title="4.500" data-toggle="tooltip" data-placement="top">45%</div>
                                    </div>
                                    <div class="bar">
                                        <div class="title">MAY</div>
                                        <div class="value tooltips" data-original-title="3.200" data-toggle="tooltip" data-placement="top">32%</div>
                                    </div>
                                    <div class="bar ">
                                        <div class="title">JUN</div>
                                        <div class="value tooltips" data-original-title="6.200" data-toggle="tooltip" data-placement="top">62%</div>
                                    </div>
                                    <div class="bar">
                                        <div class="title">JUL</div>
                                        <div class="value tooltips" data-original-title="7.500" data-toggle="tooltip" data-placement="top">75%</div>
                                    </div>
                                </div>
                                <!--custom chart end-->
                            </div><!-- /row -->	

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
                  duration: 800,
                  delay: function(el, i) {
                    return 800 * i;
                  }
                })
        </script>

        <style>
            .ml15 {
                font-weight: 800;
                font-size: 3.8em;
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

