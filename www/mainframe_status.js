(async function(){
    let apikey="";
    var thefetch=await fetch("https://siweb.pythonanywhere.com/app/sieventwebservice/mainframeStatus/get?q=all",{
        "method":"POST",
        "headers":{
            "Content-Type": "application/json",
            "api-key": apikey,
        },
    });
    try {
        let thestatus=await thefetch.json();
    }catch(e){
        result = `An error occured while fetching status: ${e}`;
    };
    return result;
})();
