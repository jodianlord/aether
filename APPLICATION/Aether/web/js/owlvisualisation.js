var currentStage = "Contract";

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
        '<input type="text" placeholder="Transaction Hash" class="name form-control" required />' +
        '</div>' +
        '</form>',
        buttons:{
            formSubmit: {
                text: 'Submit',
                btnClass: 'btn-blue',
                action: function(){
                    var transactionHash = this.$content.find('.name').val();
                    if(!name){
                        $.alert("Please provide a valid transaction hash!");
                        return false;
                    }
                    
                }
            },
            cancel: {
                text: 'Cancel',
                btnClass: 'btn-red',
                action: function(){
                    return;
                }
            }
        }
    });
})

$("#deployImg").click(function () {
    console.log("deploying contract");
    var blockchainobj = {};
    var blockchainParam = {};
    blockchainobj["method"] = "deployContract";
    blockchainParam["publicKey"] = "0x2d117903f7b2dc16abe2d6272d11d84233ff7c1f";
    blockchainParam["password"] = "password";
    blockchainParam["uuid"] = uuid;
    blockchainParam["hash"] = hash;
    blockchainobj["param"] = blockchainParam;
    console.log(blockchainobj);

    var unlockobj = {};
    var unlockparam = {};
    unlockobj["method"] = "unlockAccount";
    unlockparam["publicKey"] = "0x2d117903f7b2dc16abe2d6272d11d84233ff7c1f";
    unlockparam["password"] = "password";
    unlockobj["param"] = unlockparam;
    $.confirm({
        title: "These are the fields you'll be using",
        content: "uuid: " + uuid + " hash: " + hash,
        buttons: {
            deploy: function () {
                $.ajax({
                    beforeSend: function (request) {
                        request.setRequestHeader("X-Blockchain-Key", "513091f8-ffb1-4e52-ac6b-a5e09021ef91");
                    },
                    url: "http://vm.jordysamuel.com:30301/Blockchain/",
                    type: "POST",
                    data: JSON.stringify(unlockobj),
                    contentType: "application/json",
                    success: function (response) {
                        $.ajax({
                            beforeSend: function (request) {
                                request.setRequestHeader("X-Blockchain-Key", "513091f8-ffb1-4e52-ac6b-a5e09021ef91");
                            },
                            url: "http://vm.jordysamuel.com:30301/Blockchain/",
                            type: "POST",
                            data: JSON.stringify(blockchainobj),
                            contentType: "application/json",
                            success: function (response) {
                                console.log(response);
                                $.alert({
                                    title: "Success!",
                                    content: JSON.stringify(response)
                                })
                                $("#contractInfo").append(JSON.stringify(response));
                                console.log("done");
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