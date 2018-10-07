/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var streamObj;

document.getElementById("startstream").onclick = function () {
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

document.getElementById("capture").onclick = function () {
    canvas = document.createElement("canvas");
    canvas.id = "canvas";
    context = canvas.getContext("2d");
    canvas.width = 600;
    canvas.style.width = '45%';
    canvas.height = canvas.width * .75;
    context.drawImage(document.getElementById("video"), 0, 0, 400, 300);
    document.getElementById("media").innerHTML = "";
    document.getElementById("media").appendChild(canvas);
    streamObj.getTracks().forEach(function(track){
        track.stop();
    });
}