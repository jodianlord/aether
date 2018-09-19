var canvas = create2DCanvas();
var ctx = canvas.getContext('2d');

fill2DBlack(canvas, ctx);
fill2Dtop(canvas, ctx);
draw2DCircles(canvas, ctx);

function create2DCanvas() {
    canvas = document.createElement('canvas');
    canvas.setAttribute('id', 'blockchaincanvas');
    canvas.setAttribute('width', '1500');
    canvas.setAttribute('height', '800');
    canvas.classList.add('canvas');
    document.getElementById('canvas').appendChild(canvas);
    return canvas;
}

function fill2DBlack(canvas, ctx) {
    ctx.fillStyle = "black";
    ctx.fillRect(0, 0, canvas.width, canvas.height);
}

function fill2Dtop(canvas, ctx) {
    ctx.fillStyle = "#404040";
    ctx.fillRect(0, 0, canvas.width, canvas.height / 7);
}

function draw2DCircles(canvas, ctx) {
    //active circles 
    ctx.strokeStyle = "#ffffff";
    ctx.lineWidth = 7.5;
    ctx.beginPath();
    ctx.arc(300, 60, 30, 0, 2 * Math.PI);
    ctx.stroke();

    //grayed out circles
    ctx.strokeStyle = "#484848";
    ctx.beginPath();
    ctx.arc(600, 60, 30, 0, 2 * Math.PI);
    ctx.stroke();

    ctx.beginPath();
    ctx.arc(900, 60, 30, 0, 2 * Math.PI);
    ctx.stroke();

    ctx.beginPath();
    ctx.arc(1200, 60, 30, 0, 2 * Math.PI);
    ctx.stroke();

    //draw text
    ctx.font = "3em Tahoma";
    ctx.fillStyle = "#ffffff";
    ctx.fillText("1", 290, 72.5);

    ctx.fillStyle = "#686868";
    ctx.fillText("2", 590, 72.5);
    ctx.fillText("3", 890, 72.5);
    ctx.fillText("4", 1190, 72.5);
    return ctx;
}

function draw2dCanvas() {
    var canvas = document.createElement('canvas');
    canvas.setAttribute('id', 'blockchaincanvas');
    canvas.setAttribute('width', '1500');
    canvas.setAttribute('height', '800');
    canvas.classList.add('canvas');
    ctx = canvas.getContext('2d');
    //top bar
    ctx.fillStyle = "#404040";
    ctx.fillRect(0, 0, canvas.width, canvas.height / 7);

    //circles 
    ctx.strokeStyle = "#ffffff";
    ctx.lineWidth = 7.5;
    ctx.beginPath();
    ctx.arc(300, 60, 30, 0, 2 * Math.PI);
    ctx.stroke();

    //grayed out circles
    ctx.strokeStyle = "#484848";
    ctx.beginPath();
    ctx.arc(600, 60, 30, 0, 2 * Math.PI);
    ctx.stroke();

    ctx.beginPath();
    ctx.arc(900, 60, 30, 0, 2 * Math.PI);
    ctx.stroke();

    ctx.beginPath();
    ctx.arc(1200, 60, 30, 0, 2 * Math.PI);
    ctx.stroke();

    //draw text
    ctx.font = "3em Tahoma";
    ctx.fillStyle = "#ffffff";
    ctx.fillText("1", 290, 72.5);

    ctx.fillStyle = "#686868";
    ctx.fillText("2", 590, 72.5);
    ctx.fillText("3", 890, 72.5);
    ctx.fillText("4", 1190, 72.5);
    return ctx;
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