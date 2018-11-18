<!-- **********************************************************************************************************************************************************
MAIN SIDEBAR MENU
*********************************************************************************************************************************************************** -->
<!--sidebar start-->
<aside>
    <div id="sidebar"  class="nav-collapse ">
        <!-- sidebar menu start-->
        <ul class="sidebar-menu" id="nav-accordion">

            <p class="centered"><img src="img/ui-sam.jpg" class="img-circle" width="60"></p>
            <h5 class="centered"><%=session.getAttribute("userid")%></h5>

            <li class="sub-menu">
                <a>
                    <i class="fa fa-user"></i>
                    <span>Customer Onboarding</span>
                </a>


                <ul class="sub" style="overflow: hidden; display: block;" id="identityside tbank">
                    <li id="identityside" >
                        <a href="identity.jsp">
                            <!--<i class="fa fa-user"></i>-->
                            <span>Create Digital Identity</span>
                        </a>
                    </li>
                    <li id="tbank"  >
                        <a target=?? href="https://tbankonline.com/SMUtBank_CustomerOnboarding/">
                            <!--<i class="fas fa-unlock-alt"></i>-->

                            <!--<img src="img/logo_tbank_alt.png"  style="position: relative;height:70%;width:50%;margin-left:30px;">-->

                            <span>tBank</span>
                        </a>
                    </li>
                    
                </ul>
            </li>


            <!--            <li class="sub-menu">
                            <a id="dashboardside" href="dashboard.jsp">
                                <i class="fas fa-columns"></i>
                                <span>Dashboard</span>
                            </a>
                        </li>
            
                        
            
                        <li class="sub-menu">
                            <a id="transactionside" href="transaction.jsp" >
                                <i class="fa fa-money-bill-wave"></i>
                                <span>Make A transaction</span>
                            </a>
                        </li>
                        <li class="sub-menu">
                            <a id="admindashboardside" href="admindashboard.jsp" >
                                <i class="fas fa-unlock-alt"></i>
                                <span>Admin Dashboard</span>
                            </a>
                        </li>-->





            <li class="sub-menu" >
                <a>
                    <i class="fas fa-book"></i>
                    <span>Education</span>
                </a>
                
                
                
                <ul class="sub" style="overflow: hidden; display: block;">
                    <li id="visualisationside" >
                        <a href="visualisation.jsp">
                            <!--<i class="fas fa-book"></i>-->
                            <span>Blockchain Visualisation</span>
                        </a>
                    </li>
                    
                </ul>
                
                
                
                
            </li>

            <!--            <li class="sub-menu">
                            <a id="learningdashboardside" href="learningdashboard.jsp" >
                                <i class="fas fa-certificate"></i>
                                <span>Learning Dashboard</span>
                            </a>
                        </li>
            -->

            <%
                String learningIDValue = session.getAttribute("groupid").toString();
                //String learningIDVal = "4";
                if (!learningIDValue.equals("0")) {
            %>


            <li class="sub-menu" >
                <button style="width:100%" type="button" class="btn btn-success"id="Leaderboard" onclick='leaderboard()' data-toggle="modal" data-target="#leaderboardModal">
                        
                
                    <i class="fas fa-bar-chart-o"></i>
                    <span>Leaderboard</span>
                
            </button>
                
                
                
                
            </li>
            
            
            
            

            <%
                }

            %>







        </ul>
        <!-- sidebar menu end-->
    </div>
</aside>
<!--sidebar end-->
