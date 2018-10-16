/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
document.getElementById("submit").onclick = function () {
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

    var canvasbase = canvas.toDataURL();
    object["picture"] = canvasbase;
    var reader = new FileReader();
    reader.readAsDataURL(documentFile);
    reader.onload = function () {
        var filebase = reader.result;
        object["userdata"] = filebase;
        console.log(object);
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

