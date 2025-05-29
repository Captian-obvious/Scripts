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
        ROT13: function(ciphertext, mode) {
            return ciphertext.replace(/[A-Za-z]/g, function(char) {
                return String.fromCharCode(
                    char.charCodeAt(0) + (char.toLowerCase() < 'n' ? 13 : -13)
                );
            });
        },
        BINASCII: function(ciphertext, mode) {
            if (mode === "encode") {
                return ciphertext.split("").map(char => char.charCodeAt(0).toString(2).padStart(8, '0')).join(" ");
            } else if (mode === "decode") {
                return ciphertext.split(" ").map(bin => String.fromCharCode(parseInt(bin, 2))).join("");
            } else {
                return "Unsupported operation.";
            };
        },
        BIN: function(ciphertext, mode) {
            if (mode === "encode") {
                let num = parseInt(ciphertext, 10);
                if (isNaN(num)) return "Invalid input: Not a number";
                let binary = num.toString(2);
                let chunks = [];
                // Split into 8-bit chunks (starting from the end)
                while (binary.length > 8) {
                    chunks.unshift(binary.slice(-8));
                    binary = binary.slice(0, -8);
                };
                chunks.unshift(binary.padStart(8, '0')); // Ensure last chunk is padded to 8 bits
                return chunks.join(" ");
            } else if (mode === "decode") {
                let parts = ciphertext.split(" ");
                let num = parseInt(parts.join(""), 2);
                return num.toString(10);
            } else {
                return "Unsupported operation.";
            };
        },
        BINHEX: function(ciphertext, mode) {
            if (mode === "encode") {
                // Convert binary to hex
                return ciphertext.split(" ").map(bin => parseInt(bin, 2).toString(16).toUpperCase()).join(" ");
            } else if (mode === "decode") {
                // Convert hex to binary, ensuring 8-bit alignment
                return ciphertext.split(" ").map(hex => parseInt(hex, 16).toString(2).padStart(8, '0')).join(" ");
            } else {
                return "Unsupported operation.";
            };
        }
    };
    var action=tag_action;
    var alg=tag_alg;
    var ciphertext=tag_ciphered;
    var key=tag_key;
    if (alg.toLowerCase()=="ascii"){
        return algs.ASCII(ciphertext,action);
    }else if(alg.toLowerCase()=="base64"){
        return algs.BASE64(ciphertext,action);
    }else if(alg.toLowerCase()=="rot13"){
        return algs.ROT13(ciphertext,action);
    }else if(alg.toLowerCase()=="binascii"){
        return algs.BINASCII(ciphertext,action);
    }else if(alg.toLowerCase()=="bin"){
        return algs.BIN(ciphertext,action);
    }else if(alg.toLowerCase()=="binhex"){
        return algs.BINHEX(ciphertext,action);
    };
})();
