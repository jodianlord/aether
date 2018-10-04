var currentStage = "Contract";
var transactionHash;


//Konva 
var stage = new Konva.Stage({
    container: 'canvasdiv',
    width: 600,
    height: 300
});

var layer = new Konva.Layer();

var rect = new Konva.Rect({
    width: 600,
    height: 300,
    fill: 'black',
    stroke: 'black',
    strokeWidth: 5
});

layer.add(rect);

var blockchainImg = new Konva.Image({
    x: 250,
    y: 190,
    width: 100,
    height: 100
});
layer.add(blockchainImg);

var blockchainObj = new Image();
blockchainObj.onload = function(){
    blockchainImg.image(blockchainObj);
    layer.draw();
};
blockchainObj.src = "img/blockchain.svg";

var boyImg = new Konva.Image({
    x: 250,
    y: 5,
    image: boyObj,
    width: 100,
    height:100
})
layer.add(boyImg);

var boyObj = new Image();
boyObj.onload = function(){
    boyImg.image(boyObj);
    layer.draw();
}
boyObj.src = "img/boy.svg";

stage.add(layer);

//layer.add(rect);




/*
//1st canvas animation
var canvas = document.createElement('canvas');
canvas.setAttribute('id', 'blockchaincanvas');
canvas.setAttribute('width', '2400');
canvas.setAttribute('height', '1200');
canvas.style.width = "600";
canvas.style.height = "300px";
document.getElementById('canvasdiv').appendChild(canvas);

var ctx = canvas.getContext('2d');

ctx.fillStyle = "#000000";
ctx.fillRect(0, 0, canvas.width, canvas.height);

const getContext = () => canvas.getContext('2d');

// It's better to use async image loading.
const loadImage = url => {
  return new Promise((resolve, reject) => {
    const img = new Image();
    img.onload = () => resolve(img);
    img.onerror = () => reject(new Error(`load ${url} fail`));
    img.src = url;
  });
};

// Here, I created a function to draw image.
const depict = options => {
  const ctx = getContext();
  // And this is the key to this solution
  // Always remember to make a copy of original object, then it just works :)
  const myOptions = Object.assign({}, options);
  return loadImage(myOptions.uri).then(img => {
    ctx.drawImage(img, myOptions.x, myOptions.y, myOptions.sw, myOptions.sh);
  });
};

const imgs = [
    { uri: 'img/boy.svg', x: 200, y:  50, sw: 500, sh: 500 },
    { uri: 'img/girl.svg', x: 950, y:  50, sw: 500, sh: 500 },
    { uri: 'img/man.svg', x: 1800, y: 50, sw: 500, sh: 500 },
    { uri: 'img/blockchain.svg', x: 1050, y: 800, sw: 300, sh: 300 }
  ];
  
imgs.forEach(depict);

var contractSize = 200;
*/

$("#contractImg").click(function () {
    console.log("hi");
    $.alert({
        title: 'Sample Contract Code In Solidity!',
        content: "<pre><code>pragma solidity ^ 0.4.2; <br>" +
            "contract KYC{<br>" +
            "   string public uuid;<br>" +
            "   string public hash;<br>" +
            "   bool public verified = false;<br><br>" +

            "   constructor(string id, string ha) public{<br>" +
            "       uuid = id;<br>" +
            "       hash = ha;<br>" +
            "   }<br><br>" +

            "   function setVerified() public{<br>" +
            "       verified = true;<br>" +
            "   }<br>" +
            "}</code></pre>"
    });
});

$("#addressImg").click(function () {
    $.confirm({
        title: "Copy paste your contract transaction hash to retrieve your contract address!",
        content: '' +
            '<form action="" class="formName">' +
            '<div class="form-group">' +
            '<label>Enter transaction hash here</label>' +
            '<input type="text" id="trans" placeholder="Transaction Hash" class="name form-control" required />' +
            '</div>' +
            '</form>',
        buttons: {
            formSubmit: {
                text: 'Submit',
                btnClass: 'btn-blue',
                action: function () {
                    console.log(document.getElementById("trans").values);
                    if (!name) {
                        $.alert("Please provide a valid transaction hash!");
                        return false;
                    }

                    $.ajax({
                        url: "./BlockchainVis?receipt=" + transactionHash,
                        type: "GET",
                        success: function (response) {
                            $.alert(JSON.stringify(response));
                        },
                        error: function (xhr) {
                            $.alert("Error!");
                        }
                    });

                }
            },
            cancel: {
                text: 'Cancel',
                btnClass: 'btn-red',
                action: function () {
                    return;
                }
            }
        }
    });
})

$("#deployImg").click(function () {
    console.log("deploying contract");
    var blockchainParam = {};
    blockchainParam["uuid"] = uuid;
    blockchainParam["hash"] = hash;

    $.confirm({
        title: "These are the fields you'll be using",
        content: "uuid: " + uuid + " hash: " + hash,
        buttons: {
            deploy: function () {
                $.ajax({
                    url: "./BlockchainVis?method=unlock&publicKey=" + publicKey,
                    type: "GET",
                    contentType: "application/json",
                    success: function (resp) {
                        console.log(resp);
                        $.ajax({
                            url: "./BlockchainVis?method=deployContract&publicKey=" + publicKey,
                            type: "POST",
                            data: JSON.stringify(blockchainParam),
                            contentType: "application/json",
                            success: function (response) {
                                console.log(response);
                                $.alert({
                                    title: "Success!",
                                    content: JSON.stringify(response)
                                });
                                $("#contractInfo").append(JSON.stringify(response));
                                console.log("done");
                                transactionHash = JSON.stringify(response);
                                console.log(transactionHash);
                            },
                            error: function (xhr) {
                                $.alert({
                                    title: "Failure!",
                                    content: "Contract not deployed"
                                });
                            }
                        });
                    },
                    error: function (xhr) {

                    }

                })


            },
            cancel: function () {
                $.alert("Cancelled!");
            }
        }
    });
});