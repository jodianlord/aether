
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
                        <div class="col-lg-12">
                            <div class="form-panel" style="height:600px">
                                <h4 class="mb"><i class="fa fa-angle-right"></i>Facial Comparison</h4>
                                
                                
                                <table id="picTable">
                                </table>  
                                </br>
                                <table>
                                    <tr style="text-align: center"align="center">
                                        <td style="width: 10%;text-align: center"align="center">
                                            <button onclick="window.location.href='FRsuccess.jsp'" style="width: 150px;"class="btn btn-round btn-success">Correct</button>
                                            </br></br></br>
                                            <button id="submitreject" style="width: 150px;" class="btn btn-round btn-danger">Incorrect</button>
                                        </td>
                                    </tr>                              
                                </table> 
                                 
                            </div>
                        </div>
                    </div>
                   
                </section>
            </section>

            <!--main content end-->
        </section>

    </body>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script>
        
        var uuid = getUrlVars()["uuid"];
        var obj = {};
        obj["uuid"] = uuid;
        $.ajax({
            url: "http://localhost:8084/bank_b/TableRetrieve",
            type: "POST",
            data: JSON.stringify(obj),
            success: function (data) {
                console.log(data);
                var tbody = document.getElementById("picTable");
                var div = document.createElement("div");
                var pictureBase64 = data.picture;
                
                var fr = sessionStorage.getItem("faced");
               // window.alert(fr);
                var verificationBase64 = "data:image/png;base64," + fr;
                var pictureImage = new Image();
                pictureImage.src = pictureBase64;
                tbody.appendChild(pictureImage);
                
                //tbody.appendChild(div);
                
                var verificationImage = new Image();
                verificationImage.src = verificationBase64;
                tbody.appendChild(verificationImage);

            },
            error: function () {

            }
        });
        
        function getUrlVars() {
            var vars = {};
            var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
            vars[key] = value;
            });
            return vars;
        }
    </script>
    <script>
    
    $(submitreject).click(function(){
        alert("Account Creation Failed : A notification has been sent to the customer!");
        window.setTimeout(function(){
        
        // Move to a new location or you can do something else
        window.location.href = "verificationlist.jsp";

    }, 1500);
    });
    </script>
    <script type="application/javascript">
            document.getElementById("verifyface").className = "active";
        </script>
</html>

