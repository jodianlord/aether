/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
document.getElementById("submit").onclick = function () {
    var check = true;
    if (!document.getElementById('email').value.includes('@') || document.getElementById('mobile').value.match(/^[0-9]+$/) == null) {
        //test
        check = false;
        $.alert({
            title: 'Sorry!',
            content: 'You have some input errors'
        });
        return;
    }
    else{
        check = true;
    }

    if (pondScum.getFile() === null) {
        check = false;
        $.alert({
            title: 'Sorry!',
            content: 'Please upload your documents before continuing!',
        });
        return;
    }
    else{
        check = true;
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
        check = false;
        $.alert({
            title: 'Sorry!',
            content: 'Please set all fields!',
        });
        return;
    }
    else{
        check = true;
    }
    
    var formJSON = JSON.stringify(object);
    var canvas = document.getElementById("canvas");
    if (canvas === null) {
        check = false;
        $.alert({
            title: 'Sorry!',
            content: 'Please take your picture!',
        });
        return;
    }
    if(check){
        //cfm
        $.confirm({
        title: 'Submit Digital Identity!',
        content: 'Submit Digital Identity!',
        buttons: {
            confirm: function () {
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
                                $.ajax({
                                    url: "./IdentityServlet",
                                    type: "POST",
                                    data: JSON.stringify(object),
                                    contentType: "application/json",
                                    success: function (response) {
                                        $.alert({
                                            title: "Success!",
                                            content: "Identity Uploaded!"
                                        });
                                    },
                                    error: function (xhr) {
                                        console.log(xhr);
                                        $.alert({
                                            title: 'Failure!',
                                            content: 'Transaction Not Sent!',
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
            },
            cancel: function () {
                $.alert('Canceled!');
            }
        }
    });  
        
        
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

