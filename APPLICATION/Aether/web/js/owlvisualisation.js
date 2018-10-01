var currentStage = "Contract";

$("#contractImg").click(function(){
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
                        "   }<br>"+
                    "}</code></pre>" 
    });
});

$("#deployImg").click(function(){
    console.log("deploying contract");
    
    $.confirm({
        title: "These are the fields you'll be using",
        content: uuid + " " + hash,
        buttons:{
            deploy: function(){
                $.ajax({
                    beforeSend: function(request) {
                        request.setRequestHeader("X-Blockchain-Key", "513091f8-ffb1-4e52-ac6b-a5e09021ef91");
                      },
                });
            },
            cancel: function(){
                $.alert("Cancelled!");
            }
        }
    });
});