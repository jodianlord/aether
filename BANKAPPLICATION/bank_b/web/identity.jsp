
<!DOCTYPE html>
<html lang="en">
    <%@include  file="Components/head.html" %>

    <body style="background-color: #f2f2f2">
        <div class="se-pre-con"> </div>
        <section id="container" >

            <%--<%@//include  file="Components/topbar.html" %>--%>
            <%@include  file="Components/sidebar.html" %>
            <script src="https://unpkg.com/jquery"></script>
            <script src="https://surveyjs.azureedge.net/1.0.46/survey.jquery.js"></script>
            <link href="https://surveyjs.azureedge.net/1.0.46/survey.css" type="text/css" rel="stylesheet"/>
            <!-- **********************************************************************************************************************************************************
            MAIN CONTENT
            *********************************************************************************************************************************************************** -->
            <!--main content start-->
            <section id="main-content">
                <section class="wrapper">

                    <div class="row mt">
                        <div class ="col-lg-3"></div>
                        <div class="col-lg-6">
                            <div class="form-panel col-lg-12" style="height:250px;margin-top: -5em">
                                <h4 class="mb"><i class="fa fa-angle-right"></i> Upload .bin UDI File</h4>
                                <input type="file" class="filepond" id="fileupload">
                                
                                
                            </div>
                        </div>
                    </div>

                    <div class="row mt">
                        <div class ="col-lg-3"></div>
                        <div class="col-lg-6">
                            <div class="form-panel col-lg-12">
                                <h4 class="mb"><i class="fa fa-angle-right"></i>Take Picture</h4>
                                <div id="media">
                                </div>
                                <button id="startstream" type="button" class="btn btn-primary">Start Camera</button>
                                <button id="capture" type="button" class="btn btn-theme04">Take Photo</button>
                                <button id="captureagain" type="button" class="btn btn-primary">Retake Photo</button>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row mt">
                        <div class ="col-lg-3"></div>
                        <div class="col-lg-6">
                            <button id="populate" type="button" style="margin-top:-20px;margin-left: 10px"class="btn btn-danger btn-lg btn-block">Populate User Details</button>
                    
                        </div>
                    </div>

                     <div class="row mt">
                        <div class="col-lg-3"></div>
                        <div class="col-lg-6">
                            <div class="form-panel  col-lg-12">
                                <h4 class="mb"><i class="fa fa-angle-right"></i> User Details</h4>
                                <form class="form-horizontal style-form" id="userdata" action="/CreateCustomerServlet" method="post">
                                    <div class="form-group">
                                        <label class="col-sm-2 col-sm-2 control-label">Preferred Username</label>
                                        <div class="col-sm-10">
                                            <input type="text" id="prefUsername" name="prefUsername" value="" class="form-control" placeholder="e.g. S9445002A or Johndoe2014">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 col-sm-2 control-label">Full Name</label>
                                        <div class="col-sm-10">
                                            <input type="text" id="fullname" name="fullname" class="form-control" placeholder="e.g. John Doe">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 col-sm-2 control-label">NRIC</label>
                                        <div class="col-sm-10" id="nricdiv">
                                            <input type="text" id="nric" name="nric" class="form-control" placeholder="e.g. S1234567D">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 col-sm-2 control-label">Email</label>
                                        <div class="col-sm-10" id="emaildiv">
                                            <input type="text" id="email" name="email" class="form-control" placeholder="e.g. johndoe@mail.com">
                                            <div id="emailerror" style="display:none">
                                                Please enter a valid email address!
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 col-sm-2 control-label">Mobile</label>
                                        <div class="col-sm-10">
                                            <input type="text" id="mobile" name="mobile" class="form-control" placeholder="e.g. 81245678">
                                            <div id="mobileerror" style="display:none">
                                                Please enter a valid mobile number!
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 col-sm-2 control-label">Gender</label>
                                        <div class="col-sm-10">
                                            <!--<input type="text" id="gender" name="gender" class="form-control">-->
                                            <select class="form-control" id = "gender" name="gender">
                                                <option disabled="disabled" selected="selected">Please Select</option>
                                                <!--<optgroup label="Please Select">-->
                                                    <option>Male</option>
                                                    <option>Female</option>
                                                    <option>I do not wish to disclose</option>

                                                <!--</optgroup>-->
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 col-sm-2 control-label">Nationality</label>
                                        <div class="col-sm-10">
                                            <!--<input type="text" id="nationality" name="nationality" class="form-control">-->
                                            <select class="form-control" id="nationality"  name="nationality">
                                                <option disabled="disabled" selected="selected">Please Select</option>
                                                <!--<optgroup label="Please Select">-->
                                                    <option value="singaporean">Singaporean</option>
                                                    <option value="afghan">Afghan</option>
                                                    <option value="albanian">Albanian</option>
                                                    <option value="algerian">Algerian</option>
                                                    <option value="american">American</option>
                                                    <option value="andorran">Andorran</option>
                                                    <option value="angolan">Angolan</option>
                                                    <option value="antiguans">Antiguans</option>
                                                    <option value="argentinean">Argentinean</option>
                                                    <option value="armenian">Armenian</option>
                                                    <option value="australian">Australian</option>
                                                    <option value="austrian">Austrian</option>
                                                    <option value="azerbaijani">Azerbaijani</option>
                                                    <option value="bahamian">Bahamian</option>
                                                    <option value="bahraini">Bahraini</option>
                                                    <option value="bangladeshi">Bangladeshi</option>
                                                    <option value="barbadian">Barbadian</option>
                                                    <option value="barbudans">Barbudans</option>
                                                    <option value="batswana">Batswana</option>
                                                    <option value="belarusian">Belarusian</option>
                                                    <option value="belgian">Belgian</option>
                                                    <option value="belizean">Belizean</option>
                                                    <option value="beninese">Beninese</option>
                                                    <option value="bhutanese">Bhutanese</option>
                                                    <option value="bolivian">Bolivian</option>
                                                    <option value="bosnian">Bosnian</option>
                                                    <option value="brazilian">Brazilian</option>
                                                    <option value="british">British</option>
                                                    <option value="bruneian">Bruneian</option>
                                                    <option value="bulgarian">Bulgarian</option>
                                                    <option value="burkinabe">Burkinabe</option>
                                                    <option value="burmese">Burmese</option>
                                                    <option value="burundian">Burundian</option>
                                                    <option value="cambodian">Cambodian</option>
                                                    <option value="cameroonian">Cameroonian</option>
                                                    <option value="canadian">Canadian</option>
                                                    <option value="cape verdean">Cape Verdean</option>
                                                    <option value="central african">Central African</option>
                                                    <option value="chadian">Chadian</option>
                                                    <option value="chilean">Chilean</option>
                                                    <option value="chinese">Chinese</option>
                                                    <option value="colombian">Colombian</option>
                                                    <option value="comoran">Comoran</option>
                                                    <option value="congolese">Congolese</option>
                                                    <option value="costa rican">Costa Rican</option>
                                                    <option value="croatian">Croatian</option>
                                                    <option value="cuban">Cuban</option>
                                                    <option value="cypriot">Cypriot</option>
                                                    <option value="czech">Czech</option>
                                                    <option value="danish">Danish</option>
                                                    <option value="djibouti">Djibouti</option>
                                                    <option value="dominican">Dominican</option>
                                                    <option value="dutch">Dutch</option>
                                                    <option value="east timorese">East Timorese</option>
                                                    <option value="ecuadorean">Ecuadorean</option>
                                                    <option value="egyptian">Egyptian</option>
                                                    <option value="emirian">Emirian</option>
                                                    <option value="equatorial guinean">Equatorial Guinean</option>
                                                    <option value="eritrean">Eritrean</option>
                                                    <option value="estonian">Estonian</option>
                                                    <option value="ethiopian">Ethiopian</option>
                                                    <option value="fijian">Fijian</option>
                                                    <option value="filipino">Filipino</option>
                                                    <option value="finnish">Finnish</option>
                                                    <option value="french">French</option>
                                                    <option value="gabonese">Gabonese</option>
                                                    <option value="gambian">Gambian</option>
                                                    <option value="georgian">Georgian</option>
                                                    <option value="german">German</option>
                                                    <option value="ghanaian">Ghanaian</option>
                                                    <option value="greek">Greek</option>
                                                    <option value="grenadian">Grenadian</option>
                                                    <option value="guatemalan">Guatemalan</option>
                                                    <option value="guinea-bissauan">Guinea-Bissauan</option>
                                                    <option value="guinean">Guinean</option>
                                                    <option value="guyanese">Guyanese</option>
                                                    <option value="haitian">Haitian</option>
                                                    <option value="herzegovinian">Herzegovinian</option>
                                                    <option value="honduran">Honduran</option>
                                                    <option value="hungarian">Hungarian</option>
                                                    <option value="icelander">Icelander</option>
                                                    <option value="indian">Indian</option>
                                                    <option value="indonesian">Indonesian</option>
                                                    <option value="iranian">Iranian</option>
                                                    <option value="iraqi">Iraqi</option>
                                                    <option value="irish">Irish</option>
                                                    <option value="israeli">Israeli</option>
                                                    <option value="italian">Italian</option>
                                                    <option value="ivorian">Ivorian</option>
                                                    <option value="jamaican">Jamaican</option>
                                                    <option value="japanese">Japanese</option>
                                                    <option value="jordanian">Jordanian</option>
                                                    <option value="kazakhstani">Kazakhstani</option>
                                                    <option value="kenyan">Kenyan</option>
                                                    <option value="kittian and nevisian">Kittian and Nevisian</option>
                                                    <option value="kuwaiti">Kuwaiti</option>
                                                    <option value="kyrgyz">Kyrgyz</option>
                                                    <option value="laotian">Laotian</option>
                                                    <option value="latvian">Latvian</option>
                                                    <option value="lebanese">Lebanese</option>
                                                    <option value="liberian">Liberian</option>
                                                    <option value="libyan">Libyan</option>
                                                    <option value="liechtensteiner">Liechtensteiner</option>
                                                    <option value="lithuanian">Lithuanian</option>
                                                    <option value="luxembourger">Luxembourger</option>
                                                    <option value="macedonian">Macedonian</option>
                                                    <option value="malagasy">Malagasy</option>
                                                    <option value="malawian">Malawian</option>
                                                    <option value="malaysian">Malaysian</option>
                                                    <option value="maldivan">Maldivan</option>
                                                    <option value="malian">Malian</option>
                                                    <option value="maltese">Maltese</option>
                                                    <option value="marshallese">Marshallese</option>
                                                    <option value="mauritanian">Mauritanian</option>
                                                    <option value="mauritian">Mauritian</option>
                                                    <option value="mexican">Mexican</option>
                                                    <option value="micronesian">Micronesian</option>
                                                    <option value="moldovan">Moldovan</option>
                                                    <option value="monacan">Monacan</option>
                                                    <option value="mongolian">Mongolian</option>
                                                    <option value="moroccan">Moroccan</option>
                                                    <option value="mosotho">Mosotho</option>
                                                    <option value="motswana">Motswana</option>
                                                    <option value="mozambican">Mozambican</option>
                                                    <option value="namibian">Namibian</option>
                                                    <option value="nauruan">Nauruan</option>
                                                    <option value="nepalese">Nepalese</option>
                                                    <option value="new zealander">New Zealander</option>
                                                    <option value="ni-vanuatu">Ni-Vanuatu</option>
                                                    <option value="nicaraguan">Nicaraguan</option>
                                                    <option value="nigerien">Nigerien</option>
                                                    <option value="north korean">North Korean</option>
                                                    <option value="northern irish">Northern Irish</option>
                                                    <option value="norwegian">Norwegian</option>
                                                    <option value="omani">Omani</option>
                                                    <option value="pakistani">Pakistani</option>
                                                    <option value="palauan">Palauan</option>
                                                    <option value="panamanian">Panamanian</option>
                                                    <option value="papua new guinean">Papua New Guinean</option>
                                                    <option value="paraguayan">Paraguayan</option>
                                                    <option value="peruvian">Peruvian</option>
                                                    <option value="polish">Polish</option>
                                                    <option value="portuguese">Portuguese</option>
                                                    <option value="qatari">Qatari</option>
                                                    <option value="romanian">Romanian</option>
                                                    <option value="russian">Russian</option>
                                                    <option value="rwandan">Rwandan</option>
                                                    <option value="saint lucian">Saint Lucian</option>
                                                    <option value="salvadoran">Salvadoran</option>
                                                    <option value="samoan">Samoan</option>
                                                    <option value="san marinese">San Marinese</option>
                                                    <option value="sao tomean">Sao Tomean</option>
                                                    <option value="saudi">Saudi</option>
                                                    <option value="scottish">Scottish</option>
                                                    <option value="senegalese">Senegalese</option>
                                                    <option value="serbian">Serbian</option>
                                                    <option value="seychellois">Seychellois</option>
                                                    <option value="sierra leonean">Sierra Leonean</option>
                                                    <option value="slovakian">Slovakian</option>
                                                    <option value="slovenian">Slovenian</option>
                                                    <option value="solomon islander">Solomon Islander</option>
                                                    <option value="somali">Somali</option>
                                                    <option value="south african">South African</option>
                                                    <option value="south korean">South Korean</option>
                                                    <option value="spanish">Spanish</option>
                                                    <option value="sri lankan">Sri Lankan</option>
                                                    <option value="sudanese">Sudanese</option>
                                                    <option value="surinamer">Surinamer</option>
                                                    <option value="swazi">Swazi</option>
                                                    <option value="swedish">Swedish</option>
                                                    <option value="swiss">Swiss</option>
                                                    <option value="syrian">Syrian</option>
                                                    <option value="taiwanese">Taiwanese</option>
                                                    <option value="tajik">Tajik</option>
                                                    <option value="tanzanian">Tanzanian</option>
                                                    <option value="thai">Thai</option>
                                                    <option value="togolese">Togolese</option>
                                                    <option value="tongan">Tongan</option>
                                                    <option value="trinidadian or tobagonian">Trinidadian or Tobagonian</option>
                                                    <option value="tunisian">Tunisian</option>
                                                    <option value="turkish">Turkish</option>
                                                    <option value="tuvaluan">Tuvaluan</option>
                                                    <option value="ugandan">Ugandan</option>
                                                    <option value="ukrainian">Ukrainian</option>
                                                    <option value="uruguayan">Uruguayan</option>
                                                    <option value="uzbekistani">Uzbekistani</option>
                                                    <option value="venezuelan">Venezuelan</option>
                                                    <option value="vietnamese">Vietnamese</option>
                                                    <option value="welsh">Welsh</option>
                                                    <option value="yemenite">Yemenite</option>
                                                    <option value="zambian">Zambian</option>
                                                    <option value="zimbabwean">Zimbabwean</option>
                                                <!--</optgroup>-->
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 col-sm-2 control-label">Marital Status</label>
                                        <div class="col-sm-10">
                                            <select class="form-control" id="marital" name="marital">
                                                <option disabled="disabled" selected="selected">Please Select</option>
                                                <!--<optgroup label="Please Select">-->
                                                    <option>Single</option>
                                                    <option>Married</option>
                                                    <option>Divorced</option
                                                <!--</optgroup>-->
                                                
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 col-sm-2 control-label">Residence Type</label>
                                        <div class="col-sm-10">
                                            <!--<input type="text" id="residencetype" name="residencetype" class="form-control">-->
                                            <select class="form-control" id="residencetype" name="residencetype">
                                                <option disabled="disabled" selected="selected">Please Select</option>
                                                <!--<optgroup label="Please Select">-->
                                                    <option value = "hdb_SEM">HDB - Standard / Executive / Maisonette</option>
                                                    <option value = "hdb_studioSC">HDB - Studio Apartment for Senior Citizens</option>
                                                    <option value = "hdb_hudc">HDB - HUDC / Executive Condominium</option>
                                                    <option value = "hdb_shop">HDB - Shop with Accomodation</option>
                                                    <option value = "private_condo">Condominium / Private Apartment</option>
                                                    <option value = "terrace_bungalow">Terrace / Bungalow</option>
                                                <!--</optgroup>-->
                                            </select>
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
                                            <!--<input type="text" id="industry" name="industry" class="form-control">-->
                                            <select id="industry" class="form-control"  name="industry">
                                                <option disabled="disabled" selected="selected">Please Select</option>
                                                <!--<optgroup label="Please Select">-->
                                                    <option value="Student">Education (Student) </option>
                                                    <option value="Education">Education</option>    
                                                    <option value="Arms / Defence">Arms / Defence</option>
                                                    <option value="Arts / Antique Dealer / Auctioneer">Arts / Antique Dealer / Auctioneer</option>
                                                    <option value="Bakery Outlet">Bakery Outlet</option>
                                                    <option value="Beauty / Massage Outlet">Beauty / Massage Outlet</option>
                                                    <option value="Car Wash Outlet">Car Wash Outlet</option>
                                                    <option value="Casino / Gaming Operator">Casino / Gaming Operator</option>
                                                    <option value="Coin Operated Amusements">Coin Operated Amusements</option>
                                                    <option value="Convenience Store / Minimarts">Convenience Store / Minimarts</option>
                                                    <option value="Financial Services">Financial Services (Except Money Exchange Houses)</option>
                                                    <option value="Hawker Stall">Hawker Stall</option>
                                                    <option value="Import / Export Company with Warehousing">Import / Export Company with Warehousing</option>
                                                    <option value="Import / Export Company without Warehousing">Import / Export Company without Warehousing</option>
                                                    <option value="Internet Payment Service Providers, E-commerce Providers">Internet Payment Service Providers, E-commerce Providers</option>
                                                    <option value="Laundromats">Laundromats (e.g Self-Service/Coin Operated Laundry)</option>
                                                    <option value="Money Service Businesses">Money Service Businesses (e.g. Remittance Agent / Licensed Money Lenders)</option>
                                                    <option value="Night club / Sauna / Bar / Karaoke Lounge">Night club / Sauna / Bar / Karaoke Lounge</option>
                                                    <option value="Non-profit Organization">Non-profit Organization / Charity Organization / Religious Bodies</option>
                                                    <option value="Offshore Bank / Investment Company">Offshore Bank / Investment Company</option>
                                                    <option value="Oil and Energy">Oil / Petroleum / Petrochemicals / Energy or Nuclear</option>
                                                    <option value="Parking Garage">Parking Garage</option>
                                                    <option value="Pawn Shop">Pawn Shop</option>
                                                    <option value="Precious Metals Dealer / Jeweller">Precious Metals Dealer / Jeweller</option>
                                                    <option value="Restaurant">Restaurant</option>
                                                    <option value="Retail Outlet">Retail Outlet</option>
                                                    <option value="Scrap Metals Dealers">Scrap Metals Dealers</option>
                                                    <option value="Toto / 4D Outlet">Toto / 4D Outlet</option>
                                                    <option value="Transport Related Provider">Transport Related Provider (Taxi Driver / Quasi Driver / Uber / Grab Car Driver)</option>
                                                    <option value="Trusts / Foundations">Trusts / Foundations</option>
                                                    <!--<option value="others">Others</option>-->
                                                <!--</optgroup>-->
                                            </select>
                                        </div>
                                        

                                    </div>
                                    
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class ="col-lg-3"></div>
                        <div class="col-lg-6">
                            <button id="submit" type="button" style="width:103%" class="btn btn-danger btn-lg btn-block">Submit Account Creation</button>
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
            var prefUser = document.getElementById("prefUsername").value;
            var p =prefUser.toString();
            if(p===null || p===""){
                $.alert({
                    title: 'Sorry!',
                    content: 'Please enter your preferred username!',
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
                        url: "./SendFR", //edit address accordingly
                        type: "POST",
                        data: JSON.stringify(jsonObject),
                        contentType: "application/json",
                        success: function (data) {
                            if (data.status === "Match") {
                                //create tbank customer
                                var createJson ={};
                                createJson["nric"]=$("#nric").val();
                                createJson["fullname"]=$("#fullname").val();
                                createJson["email"]=$("#email").val();
                                createJson["mobile"]=$("#mobile").val();
                                createJson["gender"]=$("#gender").val();
                                createJson["marital"]=$("#marital").val();
                                createJson["address"]=$("#address").val();
                                createJson["occupation"]=$("#occupation").val();
                                createJson["prefUsername"]=$("#prefUsername").val();
                                console.log("working for createjson");
                                    $.ajax({
                                        url: "./CreateCustomerServlet", //edit address accordingly
                                        type: "POST",
                                        data: JSON.stringify(createJson),
                                        contentType: "application/json",
                                        success: function (createData) {  
                                            if(createData.createStatus==="success"){
                                                $.confirm({
                                                    title: "Your account has been created! ",
                                                    content: "You can now login to your tBank account.",

                                                    buttons: {
                                                        OK: function () {
                                                           window.location.href = "http://tbankonline.com/SMUtBank_RIB/";
                                                            },
                                                        }                                   
                                                    });
                                            }
                                            else{
                                                $.confirm({
                                                    title: "Duplicated NRIC. Customer already exist in tBank ",
                                                    content: "Please check your information again as there are already an existing account with tBank",

                                                    buttons: {
                                                        OK: function () {
                                                           //window.location.href = "http://tbankonline.com/SMUtBank_RIB/";
                                                            },
                                                        }                                   
                                                    });
                                            }

                                        }, error: function (xhr) {
                                                console.log("Create Customer failed");
                                                $.confirm({
                                                    title: "Create Customer failed",
                                                    content: "Create customer failed please validate your information again.",

                                                    buttons: {
                                                        OK: function () {
                                                           //window.location.href = "http://tbankonline.com/SMUtBank_RIB/";
                                                            },
                                                        }                                   
                                                    });
                                        }
                                    });    
                                    console.log("aft servlet");
                            //end
                            /*
                                    $.confirm({
                                        title: "Your account has been created! ",
                                        content: "You can now login to your tBank account.",

                                        buttons: {
                                            OK: function () {
                                               window.location.href = "http://tbankonline.com/SMUtBank_RIB/";
                                            },
                                        }                                   
                                    });
                                    */
                            } else if (data.status === "Do Not Match") {
                                //AddVerification(uuid, transactionHash);
                                //sessionStorage.setItem("testuuid", uuid);
                                //sessionStorage.setItem("faced", data.facedetect);
                                $.alert({
                                    title: "Error!",
                                    content: "Your face does not match the UDI. Please wait while staff attend to your request."
                                });
                            } else if(data.status === "Error") {
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
                                $.alert({
                                        title: "Error!",
                                        content: "Your face does not match the UDI. Please wait while staff attend to your request."
                                });
                        },
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

<script>
    document.getElementById("captureagain").style.visibility = "hidden"; 
    var startstream = document.getElementById("startstream").style.visibility;
    var capture = document.getElementById("capture").style.visibility;
    if(startstream === "hidden") {
        document.getElementById("captureagain").style.visibility = "visible"; 
    } else if (capture === "hidden") {
        document.getElementById("captureagain").style.visibility = "visible"; 
    } else {
        document.getElementById("capture").style.visibility = "hidden"
    }
</script>

<style>
    ::placeholder { /* Chrome, Firefox, Opera, Safari 10.1+ */
        color: lightgray;
        opacity: 0.8; /* Firefox */
    }
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