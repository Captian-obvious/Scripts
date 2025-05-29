(function(){
    var algs={};
    algs.BASE64=function(ciphertext,mode){
        return (mode.lower()=="decode") ? atob(ciphertext) : btoa(ciphertext);
    };
    algs.ASCII=function(ciphertext,mode){
        return (mode.lower()=="decode") ? atob(ciphertext) : btoa(ciphertext);
    };
    var action=window.tag_action;
    var alg=window.tag_alg;
    var ciphertext=window.tag_ciphered;
    var key=window.tag_key || "";
    var returned="";
    if (alg.lower()=="ascii"){
        returned=algs.ASCII(ciphertext,action);
    }else if(alg.lower()=="base64"){
        returned=algs.BASE64(ciphertext,action);
    };
    return returned;
})();
