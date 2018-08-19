
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
        var uuid = "2d6668b3-81a1-404e-9f09-e6c4a22ca40b";
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
                var verificationBase64 = "data:image/png;base64," + data.verification;
                
                var pictureImage = new Image();
                pictureImage.src = pictureBase64;
                tbody.appendChild(pictureImage);
                
                //tbody.appendChild(div);
                
                var verificationImage = new Image();
                verificationImage.src = verificationBase64;
                tbody.appendChild(verificationImage);
                
                //$('#picTable').find(tbody).append("<tr style='text-align: center' align='center'>");
                //$(table).find(tbody).append("<td style='width: 35%'></br>" + pictureImage + "</td>");
                //$(table).find(tbody).append("<td style='width: 35%'></br>" + verificationImage + "</td></tr>");
                //$(table).find(tbody).append("<td style='width: 10%;text-align: center'align='center'>"
                                            //+ " <button onclick='window.location.href='FRsuccess.jsp' style='width: 150px;'class='btn btn-round btn-success'>Correct</button>"
                                            //+ " </br></br></br></br>" 
                                            //+ " <button id='submitreject' style='width: 150px;' class='btn btn-round btn-danger'>Incorrect</button></td></tr>");
                                           
                
                //var toAdd = "<tr style=\"text-align: center\"align=\"center\">";
                //toAdd += "<td style=\"width: 35%\"><img" + pictureImage + "width=\"500\"></br></td>";
                //toAdd += "<td style=\"width: 35%\"><img" + verificationImage + "width=\"500\"></br></td>";
                //toAdd += "<td style=\"width: 10%;text-align: center\"align=\"center\">";
                //toAdd += "<button onclick=\"window.location.href='FRsuccess.jsp'\" style=\"width: 150px;\"class=\"btn btn-round btn-success\">Correct</button>";
                //toAdd += "<br> </br></br> </br>";
                //toAdd += "<button id=\"submitreject\" style=\"width: 150px;\" class=\"btn btn-round btn-danger\">Incorrect</button>";
                //toAdd += "</td></tr>";
                //toAdd += "<td>" + (i+1) + "</td>";
                //toAdd += "<td style=\"width: 35%\"><img src="img/shawnKYC.jpg" width="500"></br>Image 1</td>
                //toAdd += "<td>" + data[i].uuid + "</td>";
                //toAdd += "<td>" + data[i].transactionHash + "</td>";
                //toAdd += "<td>" + data[i].verified + "</td>";
                //toAdd += "<td><a href=" + "./verifyface.jsp>" + verifyString + "</a></td>";
                //toAdd+= "</tr>";
                //tbody.innerHTML += toAdd;
                //}
            },
            error: function () {

            }
        });
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

