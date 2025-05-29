(function(){
    var algs={
        BASE64:function(ciphertext,mode){
            return (mode.toLowerCase()=="decode") ? atob(ciphertext) : btoa(ciphertext);
        },
        ASCII:function(ciphertext,mode){
            if (mode == "encode") {
                return ciphertext.split("").map(char => char.charCodeAt(0)).join(" ");
            } else if (mode == "decode") {
                return ciphertext.split(" ").map(code => String.fromCharCode(parseInt(code, 10))).join("");
            } else {
                return "Unsupported operation.";
            };
        },
    };
    var action=window.tag_action;
    var alg=window.tag_alg;
    var ciphertext=window.tag_ciphered;
    var key=window.tag_key || "";
    var returned="";
    if (alg.toLowerCase()=="ascii"){
        returned=algs.ASCII(ciphertext,action);
    }else if(alg.toLowerCase()=="base64"){
        returned=algs.BASE64(ciphertext,action);
    };
    return returned;
})();
