const userAgent=`Superduperdev2IncFetchUtil/1.0.0`;
const base_url="https://captianobvious.pythonanywhere.com/api/v3/asset";
var assetid=tag_assetid;
(async function(){
    try{
        var url=base_url+"/"+assetid;
        var response=await fetch(url,{
            "headers":{
                "User-Agent":userAgent,
                "Accept":"application/json",
            },
            "method":"GET",
        });
        var message=response.statusText;
        var code=response.status;
        if (!response.ok){
            console.log("Request Error: "+message+` (${code})`);
            return "**An error occured while running this command!**\nREQUEST FAILED:\n"+message+` (${code})\n`+` \`\`\`json\n${await response.text()})\n\`\`\``;
        };
        return {
            content:`Asset ${assetid} fetched successfully!`,
            files:[
                {
                    name:`${assetid}.json`,
                    content:await response.text(),
                }
            ]
        };
    }catch(error){
        console.log("An error occured while running this command", error);
        return "**An error occured while running this command!**\nTraceback:\n"+error;
    };
})();