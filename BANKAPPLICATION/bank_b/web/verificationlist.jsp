
<!DOCTYPE html>
<html lang="en">
    <%@include  file="Components/head.html" %>

    <body style="background-color: black">

        <section id="container" >

            <%@include  file="Components/topbar.html" %>
            <%@include  file="Components/sidebar.html" %>

            <!-- **********************************************************************************************************************************************************
            MAIN CONTENT
            *********************************************************************************************************************************************************** -->
            <!--main content start-->
            <section id="main-content"style="height: 100%;background-color: black">
                <section class="wrapper" style="height: 100%;background-color: black">

                    <div class="row mt">
                        <div class="col-md-12 mt">
                            <div class="content-panel">
                                <table class="table table-hover">
                                    <h4><i class="fa fa-angle-right"></i> Accounts Pending Verification </h4>
                                    <hr>
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>UUID</th>
                                            <th>Transaction Hash</th>
                                            <th>Verified</th>
                                            <th>Check</th>
                                        </tr>
                                    </thead>
                                    <tbody id="tablebody">
                                    </tbody>
                                </table>
                            </div><!--/content-panel -->
                        </div><!-- /col-md-12 -->
                    </div>

                </section>
            </section>

            <!--main content end-->
        </section>

    </body>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script>
        $.ajax({
            url: "http://localhost:8084/bank_b/GetVerification",
            type: "GET",
            success: function (data) {
                console.log(data);
                var tbody = document.getElementById("tablebody");
                var uuid = "";
                var verifyString = "Verify"
                for(var i = 0; i < data.length; i += 1){
                    var toAdd = "<tr>";
                    toAdd += "<td>" + (i+1) + "</td>";
                    uuid = data[i].uuid;
                    toAdd += "<td>" + data[i].uuid + "</td>";
                    toAdd += "<td>" + data[i].transactionHash + "</td>";
                    toAdd += "<td>" + data[i].verified + "</td>";
                    toAdd += "<td><a href=" + "./verifyface.jsp?uuid=" + uuid + ">" +  verifyString + "</a></td>";
                    uuid = "";
                    toAdd+= "</tr>";
                    tbody.innerHTML += toAdd;
                }
            },
            error: function () {

            }
        });
    </script>
    <script type="application/javascript">
        document.getElementById("verifyface").className = "active";
    </script>
</html>

