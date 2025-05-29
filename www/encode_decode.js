(function(){
    var algs={};
    algs.BASE64=function(ciphertext,mode){
        return (mode.lower()=="decode") ? atob(ciphertext) : btoa(ciphertext);
    };
    algs.ASCII=function(ciphertext,mode){
        return (mode.lower()=="decode") ? atob(ciphertext) : btoa(ciphertext);
    };
    var args={args};
    var action=args[1];
    var alg=args[2];
    var ciphertext=args[3];
    var key=args[4];
    var returned="";
    if (alg.lower()=="ascii"){
        returned=algs.ASCII(ciphertext,action);
    }else if(alg.lower()=="base64"){
        returned=algs.BASE64(ciphertext,action);
    };
    return returned;
})();
