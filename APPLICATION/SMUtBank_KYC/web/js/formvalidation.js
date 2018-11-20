/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$("#nric").keyup(function(){
    var val = document.getElementById('nric').value;
    if(val.match(/^[STFG]\d{7}[A-Z]$/)){
        document.getElementById("nricerror").style.display =  "none";
    }else if (val.length == 9) {
        document.getElementById("nricerror").style.display =  "none";
    }else {
        document.getElementById("nricerror").style.display =  "block";
    }
});


$("#email").keyup(function(){
    var val = document.getElementById('email').value;
    if(val.match(/^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/)){
        document.getElementById("emailerror").style.display =  "none";
    }else{
        document.getElementById("emailerror").style.display =  "block";
    }
});

$("#mobile").keyup(function(){
    var val = document.getElementById('mobile').value;
    if(val.match(/(8|9)\d{7}/)){
        document.getElementById("mobileerror").style.display =  "none";
    }else{
        document.getElementById("mobileerror").style.display =  "block";
    }
});

$("#address").keyup(function(){
    var val = document.getElementById('address').value;
    if(val.match(/\d{6}/)){
        document.getElementById("addresserror").style.display =  "none";
    }else{
        document.getElementById("addresserror").style.display =  "block";
    }
});



