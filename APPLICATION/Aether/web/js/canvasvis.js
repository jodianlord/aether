/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


gl = setUpCanvas();
fillBlack(gl);

function setUpCanvas() {
    var canvas = document.createElement('canvas');
    canvas.setAttribute('id', 'blockchaincanvas');
    canvas.setAttribute('width', '1500');
    canvas.setAttribute('height', '800');
    canvas.classList.add('canvas');
    document.getElementById('canvas').appendChild(canvas);
    //var ctx = canvas.getContext("2d");
    gl = canvas.getContext('experimental-webgl', {
        preserveDrawingBuffer: true,
        premultipliedAlpha: true
    });
    console.log(gl);
    return gl;
}

function fillBlack(gl) {
    gl.viewport(0, 0, canvas.width, canvas.height);
    gl.clearColor(0.0, 0.0, 0.0, 1.0);
    gl.clear(gl.COLOR_BUFFER_BIT);
}


/*
 //fill background
 ctx.fillStyle = "black";
 ctx.fillRect(0, 0, canvas.width, canvas.height);
 
 //top bar
 ctx.fillStyle = "#404040";
 ctx.fillRect(0, 0, canvas.width, canvas.height/7);
 
 //circles 
 ctx.strokeStyle = "#ffffff";
 ctx.lineWidth = 7.5;
 ctx.beginPath();
 ctx.arc(300,60,30,0,2*Math.PI);
 ctx.stroke();
 
 //grayed out circles
 ctx.strokeStyle = "#484848";
 ctx.beginPath();
 ctx.arc(600,60,30,0,2*Math.PI);
 ctx.stroke();
 
 ctx.beginPath();
 ctx.arc(900,60,30,0,2*Math.PI);
 ctx.stroke();
 
 ctx.beginPath();
 ctx.arc(1200,60,30,0,2*Math.PI);
 ctx.stroke();
 
 //draw text
 ctx.font = "3em Tahoma";
 ctx.fillStyle = "#ffffff";
 ctx.fillText("1", 290, 72.5);
 
 ctx.fillStyle = "#686868";
 ctx.fillText("2", 590, 72.5);
 ctx.fillText("3", 890, 72.5);
 ctx.fillText("4", 1190, 72.5);
 */