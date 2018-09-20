var canvas = create2DCanvas();
var ctx = canvas.getContext('2d');

draw2DCircles(canvas, ctx);
drawTextBox(canvas, ctx, "Hello");

function create2DCanvas() {
    canvas = document.createElement('canvas');
    canvas.setAttribute('id', 'blockchaincanvas');
    canvas.setAttribute('width', '2400');
    canvas.setAttribute('height', '1200');
    canvas.style.width = "1200";
    canvas.style.height = "600px";
    document.getElementById('overlay').appendChild(canvas);
    return canvas;
}

function drawTextBox(canvas, ctx, text) {
    ctx.font = "3em Segoe UI";
    ctx.fillStyle = "#ffffff";
    wrapText(ctx, "This is a contract. It can contain functions, parameters, constructors and the like. Shall we take a look?", 900, 950, 650, 20 * 2);

    ctx.font = "6em Segoe UI";
    wrapText(ctx, "Contract Writing", 900, 100, 800);
}

function fill2DBlack(canvas, ctx) {
    ctx.fillStyle = "black";
    ctx.fillRect(0, 0, canvas.width, canvas.height);
}

function fill2Dtop(canvas, ctx) {
    ctx.fillStyle = "#404040";
    ctx.fillRect(0, 0, canvas.width, canvas.height / 200);
}

function draw2DCircles(canvas, ctx) {
    //active circles 
    ctx.strokeStyle = "#ffffff";
    ctx.lineWidth = 7.5;

    var circleSize = 30;
    var circleheight = 80;
    var circleXIntervals = 100

    ctx.beginPath();
    ctx.arc(circleXIntervals, circleheight, circleSize, 0, 2 * Math.PI);
    ctx.stroke();

    ctx.fillStyle = "#DAA520";
    ctx.fillRect(circleXIntervals - 35, circleheight + 40, 75, 10);

    //grayed out circles
    ctx.strokeStyle = "#484848";
    ctx.beginPath();
    ctx.arc(circleXIntervals * 2, circleheight, circleSize, 0, 2 * Math.PI);
    ctx.stroke();

    ctx.beginPath();
    ctx.arc(circleXIntervals * 3, circleheight, circleSize, 0, 2 * Math.PI);
    ctx.stroke();

    ctx.beginPath();
    ctx.arc(circleXIntervals * 4, circleheight, circleSize, 0, 2 * Math.PI);
    ctx.stroke();

    //draw text
    ctx.font = "3em Tahoma";
    ctx.fillStyle = "#ffffff";
    ctx.fillText("1", circleXIntervals - 10, circleheight + 15);

    ctx.fillStyle = "#686868";
    ctx.fillText("2", circleXIntervals * 2 - 10, circleheight + 15);
    ctx.fillText("3", circleXIntervals * 3 - 10, circleheight + 15);
    ctx.fillText("4", circleXIntervals * 4 - 10, circleheight + 15);
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
    ctx.fillText("1", 285, 72.5);

    ctx.fillStyle = "#686868";
    ctx.fillText("2", 585, 72.5);
    ctx.fillText("3", 895, 72.5);
    ctx.fillText("4", 1185, 72.5);
    return ctx;
}

function wrapText(context, text, x, y, maxWidth, lineHeight) {
    var words = text.split(' ');
    var line = '';

    for (var n = 0; n < words.length; n++) {
        var testLine = line + words[n] + ' ';
        var metrics = context.measureText(testLine);
        var testWidth = metrics.width;
        if (testWidth > maxWidth && n > 0) {
            context.fillText(line, x, y);
            line = words[n] + ' ';
            y += lineHeight;
        } else {
            line = testLine;
        }
    }
    context.fillText(line, x, y);
}