const userAgent=`Superduperdev2IncFetchUtil/1.0.0`;
const base_url="https://captianobvious.pythonanywhere.com/api/v3/asset";
var placeid=7081918890;
var assetid=tag_assetid;
(async ()=>{
    var respond="No response returned";
    try{
        var url=`${base_url}/${assetid}?placeId=${placeid}`;
        var response=await fetch(url,{
            "headers":{
                "User-Agent":userAgent,
                "Accept":"application/json",
            },
            "method":"GET",
        });
        var message=response.statusText;
        var code=response.status;
        var returnedJSON=await response.text();
        if (!response.ok){
            console.log("Request Error: "+message+` (${code})`);
            respond="**An error occured while running this command!**\nREQUEST FAILED:\n"+message+` (${code})\n`+` \`\`\`json\n${returnedJSON}\n\`\`\``;
        };
        respond={
            content: "Message content",
        };
    }catch(error){
        console.log("An error occured while running this command", error);
        respond="**An error occured while running this command!**\nTraceback:\n"+error;
    };
    return respond;
})();