var currentStage = "Contract";
var transactionHash;


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