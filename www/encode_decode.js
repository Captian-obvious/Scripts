(function(){
    var algs={};
    algs.BASE64=function(ciphertext,mode){
        return (mode=="DECODE") ? atob(ciphertext) : btoa(ciphertext);
    };
})();
