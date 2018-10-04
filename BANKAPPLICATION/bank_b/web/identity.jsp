
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
                        <div class ="col-lg-3"></div>
                        <div class="col-lg-6">
                            <div class="form-panel" style="height:170px">
                                <h4 class="mb"><i class="fa fa-angle-right"></i> Upload .bin UDI File</h4>
                                <input type="file" class="filepond" id="fileupload">
                            </div>
                        </div>
                    </div>

                    <div class="row mt">
                        <div class ="col-lg-3"></div>
                        <div class="col-lg-6">
                            <div class="form-panel col-lg-12">
                                <h4 class="mb"><i class="fa fa-angle-right"></i> Take Picture</h4>
                                <div id="media">
                                </div>
                                <button id="startstream" type="button" class="btn btn-primary">Start Camera</button>
                                <button id="capture" type="button" class="btn btn-theme04">Take Photo</button>
                            </div>
                        </div>
                    </div>

                     <div class="row mt">
                        <div class="col-lg-3"></div>
                        <div class="col-lg-6">
                            <div class="form-panel">
                                <h4 class="mb"><i class="fa fa-angle-right"></i> User Details</h4>
                                <form class="form-horizontal style-form" id="userdata">
                                    <div class="form-group">
                                        <label class="col-sm-2 col-sm-2 control-label">Full Name</label>
                                        <div class="col-sm-10">
                                            <input type="text" id="fullname" name="fullname" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 col-sm-2 control-label">NRIC</label>
                                        <div class="col-sm-10" id="nricdiv">
                                            <input type="text" id="nric" name="nric" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 col-sm-2 control-label">Email</label>
                                        <div class="col-sm-10" id="emaildiv">
                                            <input type="text" id="email" name="email" class="form-control">
                                            <div id="emailerror" style="display:none">
                                                Please enter a valid email address!
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 col-sm-2 control-label">Mobile</label>
                                        <div class="col-sm-10">
                                            <input type="text" id="mobile" name="mobile" class="form-control">
                                            <div id="mobileerror" style="display:none">
                                                Please enter a valid mobile number!
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 col-sm-2 control-label">Gender</label>
                                        <div class="col-sm-10">
                                            <input type="text" id="gender" name="gender" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 col-sm-2 control-label">Nationality</label>
                                        <div class="col-sm-10">
                                            <input type="text" id="nationality" name="nationality" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 col-sm-2 control-label">Marital Status</label>
                                        <div class="col-sm-10">
                                            <select class="form-control" name="marital">
                                                <option>Single</option>
                                                <option>Married</option>
                                                <option>Divorced</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 col-sm-2 control-label">Residence Type</label>
                                        <div class="col-sm-10">
                                            <input type="text" id="residencetype" name="residencetype" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 col-sm-2 control-label">Address</label>
                                        <div class="col-sm-10">
                                            <input type="text" id="address" name="address" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 col-sm-2 control-label">Occupation</label>
                                        <div class="col-sm-10">
                                            <input type="text" id="occupation" name="occupation" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 col-sm-2 control-label">Industry</label>
                                        <div class="col-sm-10">
                                            <input type="text" id="industry" name="industry" class="form-control">
                                        </div>
                                        

                                    </div>
                                    <button id="populate" type="button" class="btn btn-danger btn-lg btn-block">Populate</button>
                                </form>
                            </div>
                        </div>
                    </div>
                     <div class ="col-lg-3"></div>
                        <div class="col-lg-6">
                            <button id="submit" type="button" class="btn btn-danger btn-lg btn-block">Submit Account Creation</button>
                        </div>
                     
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
    document.getElementById("populate").onclick = function () {
        var binFile = pondScum.getFile().file;
        var reader = new FileReader();
        console.log(reader);

        reader.readAsDataURL(binFile);
        reader.onload = function () {
            var object = {};
            object["binfile"] = reader.result;
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
                }, error: function (xhr) {
                }
            });

        }
    }
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
                success: function (data) {
                    console.log("done!");
                    console.log(data);
                    
                    var jsonObject = {};
                    
                    var uuid = data.uuid;
                    var transactionHash = data.transactionHash;
                    jsonObject["uuid"] = data.uuid;
                    var sampleimage = data.picture.replace("data:image/png;base64,","");
                    jsonObject["sampleimage"] = sampleimage;
                    var camimage = canvasbase.replace("data:image/png;base64,","");
                    jsonObject["camimage"] = camimage;
                    
                    console.log("json: " + JSON.stringify(jsonObject));

                    $.ajax({
                        url: "http://10.124.136.163:5000/facialreg", //edit address accordingly
                        type: "POST",
                        data: JSON.stringify(jsonObject),
                        contentType: "application/json",
                        success: function (data) {
                            console.log("FR Return=" + data.facedetect); //
                            if (data.status === "Match") {
                                $.confirm({
                                    title: "Your account has been created!",
                                    content: "Congrats!"
                                });
                            } else if (data.status === "Do Not Match") {
                                AddVerification(uuid, transactionHash);
                                sessionStorage.setItem("testuuid", uuid);
                                sessionStorage.setItem("faced", data.facedetect);
                                $.alert({
                                    title: "Error!",
                                    content: "Your face does not match the UDI. Please wait while staff attend to your request."
                                });
                            } else {
                                $.alert({
                                    title: "Error!",
                                    content: "The file has been compromised or tampered with. Please wait while staff attend to your request."
                                });
                            }
                            console.log(result.result);
                        }, error: function (xhr) {
                            
                        }
                    });

                }, error: function (xhr) {
                    console.log("The file has been compromised or tampered with. Please wait while staff attend to your request.");
                }
            });
        }
    }
    
    function AddVerification(uuid, transactionHash) {
        var object = {};
        object["uuid"] = uuid;
        object["transactionHash"] = transactionHash;
    
        $.ajax({
            method: "POST",
            url: "./AddVerification",
            type: "POST",
            data: JSON.stringify(object),
            contentType: "application/json",
            success: function(data){
                console.log(data);
            }
        });
    }
</script>
<script src="https://unpkg.com/filepond/dist/filepond.js"></script>

<script>
    var pondScum = FilePond.create(document.getElementById("fileupload"));
    pondScum.setOptions({
        maxFiles: 10,
        required: true
    })
            ;
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