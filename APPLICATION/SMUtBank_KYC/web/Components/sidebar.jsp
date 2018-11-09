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
                <a id="identityside" href="identity.jsp">
                    <i class="fa fa-user"></i>
                    <span>Create Digital Identity</span>
                </a>
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


            


            <li class="sub-menu">
                <a id="visualisationside" href="visualisation.jsp" >
                    <i class="fas fa-book"></i>
                    <span>Blockchain Visualisation</span>
                </a>
            </li>
            
            <li class="sub-menu">
                <a id="learningdashboardside" href="learningdashboard.jsp" >
                    <i class="fas fa-certificate"></i>
                    <span>Learning Dashboard</span>
                </a>
            </li>
            
            
            <%
                String learningIDValue = session.getAttribute("groupid").toString();
                //String learningIDVal = "4";
                if (!learningIDValue.equals("0")) {
            %>
            
            
            <li class="sub-menu">
                <a id="Leaderboard" onclick='leaderboard()' data-toggle="modal" data-target="#leaderboardModal">
                    <i class="fas fa-bar-chart-o"></i>
                    <span>Leaderboard</span>
                </a>
            </li>
            
            <%
            }
            
            %>
            
            
            
            
            <li class="sub-menu">
                <a id="tbank" target=?? href="https://vm.jordysamuel.com:8443/bank_b" >
                    <!--<i class="fas fa-unlock-alt"></i>-->
                    
                    <img src="img/logo_tbank_alt.png"  style="position: relative;height:70%;width:50%;margin-left:30px;">
                                            
                    <!--<span>tBank</span>-->
                </a>
            </li>
            
            
        </ul>
        <!-- sidebar menu end-->
    </div>
</aside>
<!--sidebar end-->
