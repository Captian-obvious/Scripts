const userAgent="Superduperdev2IncFetchUtil/1.0.0 on ";
(async function(){
    const url="";
    try {
        var response=await fetch(url,{
            "headers":{
                "User-Agent":"",
            }
        });
    }catch(error){
        console.log("An error occured while running this command", error);
        return "**An error occured while running this command!**\nTraceback:\n"+error;
    };
})();