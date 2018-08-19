
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
                                <img src="img/shawnKYC.jpg" id="kyc" width="500">
                                <img src="img/shawnInput.jpg" id="input" width="500">
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
                    </div>
                    <form action = "PassBin" method="post">
                        <input type ="submit" value = "val">
                        <button id="submit" type="button" class="btn btn-primary btn-lg btn-block">Submit Digital Identity</button>
                    </form>
                    <!-- <button id="submit" type="button" class="btn btn-primary btn-lg btn-block">Submit Digital Identity</button> -->
                </section>
            </section>

            <!--main content end-->
        </section>

        <%@include file="Components/style.html" %>

    </body>
</html>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
    (function(){
        var filter = "uuid=4f3c1af2-cbab-4d95-aff0-3b9176b3862c";
        
        $.ajax({
            type: "GET",
            url: "./PassBin",
            success:function(result){
                console.log(result);
                var firstImage = new Image();
                firstImage.src = result.picture;
                document.getElementById("KYC") = firstImage;
            },error:function(xhr){
                console.log(xhr);
            }
        });
    })();
    
</script>
<script>
    $.ajax({
        url: "http://localhost:8084/bank_b/ParseJson",
        type: "GET",
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