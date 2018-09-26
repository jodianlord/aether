<%-- 
    Document   : dashboard
    Created on : 19-Jul-2018, 12:55:31
    Author     : jodia
--%>

<%@page import="java.math.BigInteger"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.aether.dao.UserDAO, com.aether.blockchain.BlockchainHandler" %>
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
                <section class="wrapper">
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
                                            <input type="text" name="residencetype" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 col-sm-2 control-label">Address</label>
                                        <div class="col-sm-10">
                                            <input type="text" name="address" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 col-sm-2 control-label">Occupation</label>
                                        <div class="col-sm-10">
                                            <input type="text" name="occupation" class="form-control">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 col-sm-2 control-label">Industry</label>
                                        <div class="col-sm-10">
                                            <input type="text" name="industry" class="form-control">
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="row mt">
                        <div class ="col-lg-3"></div>
                        <div class="col-lg-6">
                            <div class="form-panel" style="height:170px">
                                <h4 class="mb"><i class="fa fa-angle-right"></i> Upload Documents</h4>
                                <input type="file" class="filepond" id="fileupload">
                            </div>
                        </div>
                    </div>
                    <div class="row mt">
                        <div class ="col-lg-3"></div>
                        <div class="col-lg-6">
                            <div class="form-panel col-lg-12"
                                 <h4 class="mb"><i class="fa fa-angle-right"></i> Take Picture</h4>
                                <div id="media">
                                </div>
                                <button id="startstream" type="button" class="btn btn-primary">Start Camera</button>
                                <button id="capture" type="button" class="btn btn-theme04">Take Photo</button>
                            </div>
                        </div>
                    </div>
                    <button id="submit" type="button" class="btn btn-primary">Submit Digital Identity</button>
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
        <script src="js/submitdigitalidentity.js"></script> <!--<script src="js/submitdigitalidentity.js"></script>-->
        <script src="js/formvalidation.js"></script>
        <%@include file="Components/style.html" %>

    </body>
</html>

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
        background-color: #5e7496;
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
    .center-div
    {
        margin: 0 auto;
    }

</style>