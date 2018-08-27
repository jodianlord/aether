/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$("#email").keyup(function(){
    console.log("hid");
    var val = document.getElementById('email').value;
    if(!val.includes('@')){
        document.getElementById("emailerror").style.display =  "block";
    }else{
        document.getElementById("emailerror").style.display =  "none";
    }
});

$("#mobile").keyup(function(){
    console.log("hid");
    var val = document.getElementById('mobile').value;
    if(val.match(/^[0-9]+$/) == null){
        document.getElementById("mobileerror").style.display =  "block";
    }else{
        document.getElementById("mobileerror").style.display =  "none";
    }
});
