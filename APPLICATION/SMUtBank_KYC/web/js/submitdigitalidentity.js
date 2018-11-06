/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.0/jquery-confirm.min.js";

document.getElementById("submit").onclick = function () {

    if (!document.getElementById('email').value.includes('@') || document.getElementById('mobile').value.match(/^[0-9]+$/) == null) {
        $.alert({
            title: 'Sorry!',
            content: 'You have some input errors'
        });
        return;
    }

    if (pondScum.getFile() === null) {
        $.alert({
            title: 'Sorry!',
            content: 'Please upload your documents before continuing!',
        });
        return;
    }
    var documentFile = pondScum.getFile().file;
    var formData = new FormData(document.querySelector('form'));
    //console.log(formData);
    var object = {};
    var unsetFields = false;
    formData.forEach(function (value, key) {
        object[key] = value;
        if (value.length === 0) {
            unsetFields = true;
        }
    });
    if (unsetFields) {
        $.alert({
            title: 'Sorry!',
            content: 'Please set all fields!',
        });
        return;
    }
    var formJSON = JSON.stringify(object);
    var canvas = document.getElementById("canvas");
    if (canvas === null) {
        $.alert({
            title: 'Sorry!',
            content: 'Please take your picture!',
        });
        return;
    }
    
    var redirect;
    
    $.ajax({
        url: "./TWOFA",
        data: {"mobileNumber": document.getElementById('mobile').value},
        dataType: "text",
        success: function (response) {
            var returnOTP = response;
     
            var userOTP = prompt("Enter the OTP sent to you");

            if (returnOTP === userOTP) {
                var canvasbase = canvas.toDataURL();
                object["picture"] = canvasbase;
                var reader = new FileReader();
                reader.readAsDataURL(documentFile);
                reader.onload = function () {
                    var filebase = reader.result;
                    object["userdata"] = filebase;
                    object["password"] = "password";
                    
                    $.confirm({
                        buttons: {
                            OK: function () {
                                window.location.href = "identity.jsp";
                            }
                        },
                        content: function () {
                            var self = this;
                            return $.ajax({
                                url: './IdentityServlet',
                                type: "POST",
                                data: JSON.stringify(object),
                                contentType: "application/json",
                            }).done(function (response) {
                                self.setContent('Identity Uploaded!');
                                self.setTitle('Success!');
                                redirect = true;
                            }).fail(function(){
                                self.setTitle('Failure!');
                                self.setContent('Transaction Not Sent!');
                                redirect = true;
                            });     
                        }
                    });
                    
                };
                reader.onerror = function (error) {
                    console.log('Error: ', error);
                };
            }
         else {
            $.alert({
                title: 'Failure!',
                content: 'Wrong OTP!',
            });
        }
    },
        error: function (xhr) {
            console.log("fail");
            var returnOTP = "";
        }
    });
    
    if(redirect === true) {
        window.location.href = "identity.jsp";
    }
}
    

function getBase64(file) {
    var reader = new FileReader();
    var file64;
    reader.readAsDataURL(file);
    reader.onload = function () {
        file64 = reader.result;
    };
    reader.onerror = function (error) {
        console.log('Error: ', error);
    };
}



