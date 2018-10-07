/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var streamObj;

document.getElementById("startstream").onclick = function () {

    $.confirm({
        title: 'Start Camera',
        content: 'By taking a photo of the consumer, we will be utilizing facial recognition technology using Python web service to use it as a form of 2FA.',
        type: 'red',
        buttons: {
            confirm: function () {
                document.getElementById("startstream").style.visibility = "hidden"; //make invisible
                var video = document.createElement("video"),
                        vendorUrl = window.URL || window.webkitURL;
                video.id = "video";
                video.classList.add("col-md-6");
                video.classList.add("col-sm-6");
                video.classList.add("mb");
                document.getElementById("media").innerHTML = "";
                document.getElementById("media").appendChild(video);

                navigator.getMedia = navigator.getUserMedia ||
                        navigator.webkitGetUserMedia ||
                        navigator.mozGetUserMedia ||
                        navigator.msGetUserMedia;
                navigator.getMedia({
                    video: true,
                    audio: false
                }, function (stream) {
                    streamObj = stream
                    video.srcObject = stream;
                    video.play();
                }, function (error) {
                    //An error occured
                    //error.code
                });


                document.getElementById("capture").style.visibility = "visible"; //make visible
            },
            cancel: function () {

            }

        }
    });
};

document.getElementById("capture").onclick = function () {

    $.confirm({
        title: 'Capture Picture!',
        content: 'Aether’s facial recognition capabilities are invoked based on a deployed web service that detects the facial features of the 2 uploaded image and compares them. The result will either be true or false.',
        type: 'red',
        buttons: {
            confirm: function () {
                canvas = document.createElement("canvas");
                canvas.id = "canvas";
                context = canvas.getContext("2d");
                canvas.width = 600;
                canvas.style.width = '45%';
                canvas.height = canvas.width * .75;
                context.drawImage(document.getElementById("video"), 0, 0, 400, 300);
                document.getElementById("media").innerHTML = "";
                document.getElementById("media").appendChild(canvas);
                streamObj.getTracks().forEach(function (track) {
                    track.stop();
                });
    
                document.getElementById("capture").style.visibility = "hidden"; //make invisible
                document.getElementById("captureagain").style.visibility = "visible"; //make visible
            },
            cancel: function () {

            }
        }
    });
};


document.getElementById("captureagain").onclick = function () {
    document.getElementById("captureagain").style.visibility = "hidden";
    document.getElementById("capture").style.visibility = "visible"; //make invisible
    var video = document.createElement("video"),
            vendorUrl = window.URL || window.webkitURL;
    video.id = "video";
    video.classList.add("col-md-6");
    video.classList.add("col-sm-6");
    video.classList.add("mb");
    document.getElementById("media").innerHTML = "";
    document.getElementById("media").appendChild(video);

    navigator.getMedia = navigator.getUserMedia ||
            navigator.webkitGetUserMedia ||
            navigator.mozGetUserMedia ||
            navigator.msGetUserMedia;
    navigator.getMedia({
        video: true,
        audio: false
    }, function (stream) {
        streamObj = stream
        video.srcObject = stream;
        video.play();
    }, function (error) {
        //An error occured
        //error.code
    });

}






