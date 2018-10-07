
<!DOCTYPE html>
<html lang="en">
    <%@include  file="Components/head.html" %>
    <div class="se-pre-con">                        
        </div>
    <body style="background-color: black">

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
                                <h4 class="mb"><i class="fa fa-angle-right"></i></h4>
                                A notification has been sent to the customer
                            </div>
                        </div>
                    </div>
                    
                    <!--<button id="submit" type="button" class="btn btn-primary btn-lg btn-block" >Confirm</button>-->
                    <a href="verifyface.jsp" class="button">Confirm</button>
                </section>
            </section>

            <!--main content end-->
        </section>

        <%@include file="Components/style.html" %>

    </body>
    <script type="application/javascript">
            document.getElementById("verifyface").className = "active";
            sessionStorage.clear();
        </script>
</html>

