const os=require("os"),fs=require("fs"),path=require("path");
const userAgent=`Superduperdev2IncFetchUtil/1.0.0 (${os.arch()})`;
(async function(){
    const url="";
    try {
        var response=await fetch(url,{
            "headers":{
                "User-Agent":userAgent,
            },
        });
    }catch(error){
        console.log("An error occured while running this command", error);
        return "**An error occured while running this command!**\nTraceback:\n"+error;
    };
})();