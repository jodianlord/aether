
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
                <section class="wrapper">

                    <div class="row mt">
                        <div class="col-lg-12">
                            <div class="form-panel" style="height:170px">
                                <h4 class="mb"><i class="fa fa-angle-right"></i> Upload .bin UDI File</h4>
                                <input type="file" class="filepond" id="fileupload">
                            </div>
                        </div>
                    </div>

                    <div class="row mt" id="details" hidden>
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

                    <div class="row mt">
                        <div class="col-lg-12">
                            <div class="form-panel col-lg-12" style="width:98%">
                                <h4 class="mb"><i class="fa fa-angle-right"></i> Take Picture</h4>
                                <div id="media">
                                </div>
                                <button id="startstream" type="button" class="btn btn-primary">Start Camera</button>
                                <button id="capture" type="button" class="btn btn-theme04">Take Photo</button>
                            </div>
                        </div>
                    </div>
                    <button id="submit" type="button" class="btn btn-danger btn-lg btn-block">Submit Account Creation</button>
                </section>
            </section>

            <!--main content end-->
        </section>

        <%@include file="Components/script.html" %>
        <!--set dashboard button to active-->
        <script type="application/javascript">
            document.getElementById("identityside").className = "active";
        </script>
        <script src ="js/takePhoto.js"></script>

        <%@include file="Components/style.html" %>

    </body>
</html>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.0/jquery-confirm.min.js"></script>
<script>
    document.getElementById("submit").onclick = function () {
        console.log("hi");
        var binFile = pondScum.getFile().file;
        var reader = new FileReader();
        console.log(reader);
        reader.readAsDataURL(binFile);
        reader.onload = function () {
            var filebase = reader.result;
            console.log(filebase);
            var object = {};
            object["binfile"] = filebase;

            var canvas = document.getElementById("canvas");
            if (canvas === null) {
                $.alert({
                    title: 'Sorry!',
                    content: 'Please take your picture!',
                });
                return;
            }

            var canvasbase = canvas.toDataURL();
            object["verificationfile"] = canvasbase;

            $.ajax({
                url: "./PassBin",
                type: "POST",
                data: JSON.stringify(object),
                contentType: "application/json",
                success: function (result) {
                    console.log("done!");
                    console.log(result);
                    $.ajax({
                        url: "./VerifyUser",
                        type: "POST",
                        data: JSON.stringify(result),
                        contentType: "application/json",
                        success: function (result) {
                            console.log("ok!");
                        }, error: function (xhr) {

                        }
                    });
                    if (result.fullname === "Jordy Nelson Samuel") {

                        $.confirm({
                            title: "Your account has been created!",
                            content: "Congrats!"
                        })
                    } else if (result.fullname === "Leong Yong Sheng") {
                        $.alert({
                            title: "Error!",
                            content: "Your face does not match the UDI. Please wait while staff attend to your request."
                        })
                    }

                }, error: function (xhr) {
                    console.log("Error Occured!");
                }
            });
        }
    }
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