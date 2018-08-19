
<!DOCTYPE html>
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
                <section class="wrapper" style="background-color: black">
                    
                    <div class="row mt">
                        <div class="col-lg-12">
                            <div class="form-panel" style="height:600px">
                                <h4 class="mb"><i class="fa fa-angle-right"></i>Facial Comparison</h4>
                                <img src="img/shawnKYC.jpg" width="500">
                                <img src="img/shawnInput.jpg" width="500">
                                
                                <a href="FRsuccess.jsp" class="button">Correct</a>
                                <a href="FRfail.jsp" class="button">Incorrect</button>
                            </div>
                        </div>
                    </div>
                   
                </section>
            </section>

            <!--main content end-->
        </section>

    </body>
</html>

