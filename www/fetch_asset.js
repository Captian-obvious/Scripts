const os=require("os"),fs=require("fs"),path=require("path");
var platform=os.platform();
const userAgent=`Superduperdev2IncFetchUtil/1.0.0 {(${os.type()} ${os.release()} [${os.arch()}]) on ${platform}}`;
const url="";
(async function(){
    try {
        var response=await fetch(url,{
            "headers":{
                "User-Agent":userAgent,
                "Accept":"application/json",
            },
            "method":"GET",
        });
    }catch(error){
        console.log("An error occured while running this command", error);
        return "**An error occured while running this command!**\nTraceback:\n"+error;
    };
})();