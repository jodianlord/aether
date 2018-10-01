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
    $.alert({
        title: "These are the fields you'll be using",
        content: uuid + " " + hash
    });
});