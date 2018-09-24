
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
            <section id="main-content">
                <section class="wrapper" style="background-color: black">
                    
                     <div class="row mt">
                        <div class="col-lg-12">
                            <div class="form-panel" style="height:500px">
                                <h4 class="mb"><i class="fa fa-angle-right"></i>Facial Comparison</h4>
                                <table id="picTable">
                                    
                                </table>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row mt">
                        <div class="col-lg-12">
                            <div class="form-panel">
                                <h4 class="mb"><i class="fa fa-angle-right"></i> User Details</h4>
                                <form class="form-horizontal style-form" id="userdata">

                                    <div class="form-group">
                                        <div style="margin-top: 10px">
                                            <label class="col-sm-2 col-sm-2 control-label">Full Name</label>
                                            <div class="col-sm-10">
                                                <input  type="text" id="fullname" name="fullname" class="form-control-static" style="width:50%">
                                            </div>
                                        </div>
                                        <div style="margin-top: 10px">
                                            <label class="col-sm-2 col-sm-2 control-label">NRIC</label>
                                            <div class="col-sm-10">
                                                <input id="nric" type="text" name="nric" class="form-control-static" style="width:50%">
                                            </div>
                                        </div>
                                        <div style="margin-top: 10px">
                                            <label class="col-sm-2 col-sm-2 control-label">Email</label>
                                            <div class="col-sm-10">
                                                <input id="email" type="text" name="email" class="form-control-static"  style="width:50%">
                                            </div>
                                        </div>
                                        <div style="margin-top: 10px">
                                            <label class="col-sm-2 col-sm-2 control-label">Mobile</label>
                                            <div class="col-sm-10">
                                                <input id="mobile" type="text" name="mobile" class="form-control-static"  style="width:50%">
                                            </div>
                                        </div>
                                        <div style="margin-top: 10px">
                                            <label class="col-sm-2 col-sm-2 control-label">Gender</label>
                                            <div class="col-sm-10">
                                                <input id="gender" type="text" name="gender" class="form-control-static"  style="width:50%">
                                            </div>
                                        </div>
                                        <div style="margin-top: 10px">
                                            <label class="col-sm-2 col-sm-2 control-label">Nationality</label>
                                            <div class="col-sm-10">
                                                <input type="text" id="nationality" name="nationality" class="form-control-static"  style="width:50%">
                                            </div>
                                        </div>
                                        <div style="margin-top: 10px">
                                            <label class="col-sm-2 col-sm-2 control-label">Marital Status</label>
                                            <div class="col-sm-10">
                                                <select class="form-control-static" name="marital" id="marital"  style="width:50%">
                                                    <option>Single</option>
                                                    <option>Married</option>
                                                    <option>Divorced</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div style="margin-top: 10px">
                                            <label class="col-sm-2 col-sm-2 control-label">Residence Type</label>
                                            <div class="col-sm-10">
                                                <input type="text" id="residencetype" name="residencetype" class="form-control-static"  style="width:50%">
                                            </div>
                                        </div>
                                        <div style="margin-top: 10px">
                                            <label class="col-sm-2 col-sm-2 control-label">Address</label>
                                            <div class="col-sm-10">
                                                <input type="text" id="address" name="address" class="form-control-static"  style="width:50%">
                                            </div>
                                        </div>
                                        <div style="margin-top: 10px">
                                            <label class="col-sm-2 col-sm-2 control-label">Occupation</label>
                                            <div class="col-sm-10">
                                                <input type="text" id="occupation" name="occupation" class="form-control-static"  style="width:50%">
                                            </div>
                                        </div>
                                        <div style="margin-top: 10px">
                                            <label class="col-sm-2 col-sm-2 control-label">Industry</label>
                                            <div class="col-sm-10">
                                                <input type="text" id="industry" name="industry" class="form-control-static"  style="width:50%">
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        
                        
                        <button type ="submit" id="submitaccconfirm" style="width:100%"class="btn btn-primary btn-lg btn-danger">Create Account</button>
                    </div
                    
                    
                    <!-- <form action = "PassBin" method="post">
                        
                        <!--<button id="submit" type="button" class="btn btn-primary btn-lg btn-block">Submit Digital Identity</button>
                    </form> -->
                    <!-- <button id="submit" type="button" class="btn btn-primary btn-lg btn-block">Submit Digital Identity</button> -->
                </section>
            </section>

            <!--main content end-->
        </section>

        <%@include file="Components/style.html" %>

    </body>
    
    <script type="application/javascript">
            document.getElementById("verifyface").className = "active";
        </script>
</html>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
    var testuuid = sessionStorage.getItem("testuuid");
    //window.alert(testuuid);
    var uuid = "2239fa1f-3c37-4893-b040-22bb29c3ede3";
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

            var verificationBase64 = "data:image/png;base64," + fr;

            var pictureImage = new Image();
            pictureImage.src = pictureBase64;
            tbody.appendChild(pictureImage);

            //tbody.appendChild(div);

            var verificationImage = new Image();
            verificationImage.src = verificationBase64;
            tbody.appendChild(verificationImage);
            
            $("#fullname").val(data.fullname);
            $("#nric").val(data.nric);
            $("#email").val(data.email);
            $("#mobile").val(data.mobile);
            $("#gender").val(data.gender);
            $("#nationality").val(data.nationality);
            $("#marital").val(data.marital);
            $("#residencetype").val(data.residencetype);
            $("#address").val(data.address);
            $("#occupation").val(data.occupation);
            $("#industry").val(data.industry);
        },
        error: function () {

        }
    });
</script>
<!--<script>
    var uuid = "2d6668b3-81a1-404e-9f09-e6c4a22ca40b";
    var obj = {};
    obj["uuid"] = uuid;
    $.ajax({
        url: "http://localhost:8084/bank_b/TableRetrieve",
        type: "POST",
        data: JSON.stringify(obj),
        success: function (data) {
            $("#fullname").val(data.fullname);
            $("#nric").val(data.nric);
            $("#email").val(data.email);
            $("#mobile").val(data.mobile);
            $("#gender").val(data.gender);
            $("#nationality").val(data.nationality);
            $("#marital").val(data.marital);
            $("#residencetype").val(data.residencetype);
            $("#address").val(data.address);
            $("#occupation").val(data.occupation);
            $("#industry").val(data.industry);
        },
        error: function () {

        }
    });
</script>-->
<script>
    
    $(submitaccconfirm).click(function(){
        alert("Your Account has been successfully created!");
        window.setTimeout(function(){

        // Move to a new location or you can do something else
        window.location.href = "verifyface.jsp";

    }, 1500);
    });
    
</script>

<script src="https://unpkg.com/filepond/dist/filepond.js"></script>

<script>
            var pondScum = FilePond.create(document.getElementById("fileupload"));
            pondScum.setOptions({
                maxFiles: 10,
                required: true
            });
            //FilePond.parse(document.body);
</script>

<style>
    .filepond--root {
        max-height: 10em;
        width: 75%;
        margin: auto;
    }
    .filepond--panel-root {
        background-color: red;
    }
    .filepond--drop-label {
        margin: auto;
        color: white;
        font-size: 22px;
    }
    .filepond--file {
        font-weight: 200;
        color: white;
        font-size: 24px;
    }
    .innerVid{
        width: 50%;
        margin: 0 auto;
    }
</style>