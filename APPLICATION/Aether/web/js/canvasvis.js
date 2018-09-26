var canvas = create2DCanvas();
var ctx = canvas.getContext('2d');

var currentEvent = "Contract";

var contractSize = 400;
var canvasX = canvas.width / 2 - 200;
var canvasY = canvas.height / 2 - 200;

initCanvas(canvas, ctx);
drawContract(canvas, ctx);
//contractAnimate();

canvas.addEventListener('click', function (evt) {
    xCoordinate = evt.clientX;
    yCoordinate = evt.clientY;
    if (xCoordinate > 700 && currentEvent == "Contract") {
        var img = new Image;
        img.src = "img/diploma.svg";
        img.addEventListener('load', function () {
            var interval = setInterval(function () {
                return function () {
                    ctx.clearRect(0, 0, canvas.width, canvas.height);
                    initCanvas(canvas, ctx);
                    ctx.drawImage(img, canvasX, canvasY, contractSize, contractSize);

                    canvasX -= 1;
                };
            }(), 0.001);
        }, false);

    } else {

    }
    console.log("xCoordinate: " + xCoordinate + " yCoordinate: " + yCoordinate);
}, false);

function contractAnimate() {
    requestAnimationFrame(contractAnimate);

    ctx.clearRect(0, 0, canvas.width, canvas.height);
    initCanvas(canvas, ctx);

    console.log("increment");

    var img = new Image();

    img.onload = function () {
        ctx.drawImage(img, canvasX, canvasY, contractSize, contractSize);
    }
    img.src = "img/diploma.svg";

    if (contractSize > 50) {
        contractSize = contractSize - 1;
    } else {

    }

}

function drawContract(canvas, ctx) {
    var img = new Image();
    img.onload = function () {
        ctx.drawImage(img, canvasX, canvasY, contractSize, contractSize);
    }
    img.src = "img/diploma.svg";
}

function initCanvas(canvas, ctx) {
    fill2DBlack(canvas, ctx);
    draw2DCircles(canvas, ctx);
    drawTextBox(canvas, ctx, "Hello");
    //drawArrows(canvas, ctx);
    drawCanvasArrows(canvas, ctx);
}

function drawCanvasArrows(canvas, ctx) {
    ctx.beginPath();
    ctx.lineWidth = 7;
    ctx.strokeStyle = "#ffffff";
    ctx.moveTo(100, 600);
    ctx.lineTo(150, 550);
    ctx.stroke();

    ctx.moveTo(105, 600);
    ctx.lineTo(150, 650);
    ctx.stroke();

    ctx.moveTo(2300, 600);
    ctx.lineTo(2250, 550);
    ctx.stroke();

    ctx.moveTo(2305, 600);
    ctx.lineTo(2250, 650);
    ctx.stroke();
}

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

function drawArrows(canvas, ctx) {
    var img = new Image();
    img.onload = function () {
        ctx.drawImage(img, canvas.width / 10, canvas.height / 2, 100, 100);
    }
    var img2 = new Image();
    img2.onload = function () {
        ctx.drawImage(img2, (canvas.width / 10) * 9, canvas.height / 2, 100, 100);
    }
    img.src = "img/left-arrow.svg";
    img2.src = "img/right-arrow.svg";
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
    ctx.fillStyle = "#505050";
    ctx.fillRect(0, 0, canvas.width, canvas.height / 8);
}

function fill2Dtop(canvas, ctx) {
    ctx.fillStyle = "#404040";
    ctx.fillRect(0, 0, canvas.width, canvas.height / 200);
}

function draw2DCircles(canvas, ctx) {
    //active circles 
    ctx.strokeStyle = "#ffffff";
    ctx.lineWidth = 5;

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