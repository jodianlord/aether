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
                        
                    </div>
                    <div class="row mt">
                        <div class="col-lg-3">
                            <i class="fas fa-file-contract"></i>
                        </div>
                    </div>
                    <div class="row mt">
                        
                    </div>
                </section>
            </section>

            <!--main content end-->
        </section>

        <%@include file="Components/script.html" %>
        <!--set dashboard button to active-->
        <script type="application/javascript">
            document.getElementById("visualisationside").className = "active";
        </script>
        <script src ="js/takePhoto.js"></script>
        <script src="js/submitdigitalidentity.js"></script>
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