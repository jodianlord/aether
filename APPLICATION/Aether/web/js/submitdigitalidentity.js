/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
document.getElementById("submit").onclick = function () {
    
   
    
    if(!document.getElementById('email').value.includes('@') || document.getElementById('mobile').value.match(/^[0-9]+$/) == null){
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
    
    
    
    

    $.confirm({
        title: "Input your OTP!",
        content: '<form action="" class="formName">' +
                '<div class="form-group">' +
                '<label>OTP Number</label>' +
                '<input type="text" placeholder="Your OTP" class="name form-control" id="OTP_Number" required />' +
//                '<input type="text" id="reply"/>' +
                '</div>' +
                '</form>',
        buttons: {
            formSubmit: {
                text: "Submit",
                btnClass: 'btn-red',
                action: function () {
                    var OTP_Number = document.getElementById("OTP_Number").value;
                    var canvasbase = canvas.toDataURL();
                    object["picture"] = canvasbase;
                    var reader = new FileReader();
                    reader.readAsDataURL(documentFile);
                    reader.onload = function () {
                        var filebase = reader.result;
                        object["userdata"] = filebase;
                        object["OTP_Number"] = OTP_Number;
                        console.log(object);
                        
//                        $.get('TWOFA', function(data) {
//                            
//                        });
                        


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
            },
            cancel: function(){
                return;
            }
        }

    });
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

