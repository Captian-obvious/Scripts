/*
Retrieves the status of the Superduperdev2 Inc. Mainframe at the testing facility (roblox game)
This is a simple script that can be run in the browser console to get the 
status of the mainframe and what users are sending into it 
funny script with intentions to be used as an assyst tag to confuse AHC!
The API it fetches is the event webservice mainframe status, which is set by
the mainframe itself via a PUT request
to retrieve it we send a POST request to the mainframe 
status endpoint with the query we want to retrieve
its strange but hey thats how we designed it so thats how it has to be done.
*/
(async function(){
    let apikey="";
    var thefetch=await fetch("https://siweb.pythonanywhere.com/app/sieventwebservice/mainframeStatus/get",{
        "method":"POST",
        "headers":{
            "Content-Type": "application/json",
            "api-key": apikey,
        },
        "body": JSON.stringify({ // retrieve the full status, we could also have done "pulse_status" if all we wanted was the pulse or just gotten the mainframe status via "mainframe"
            "query": "full"
        })
    });
    try {
        var thestatus=await thefetch.json();
        var globalMainframeStatus=thestatus.gMainframeStatus; // the funny status that tells us what is being sent
        var pulseStatus=thestatus.pulseStatus;
        let pulseActive=pulseStatus.pulseActive;
        let timeUntilNextPulse=pulseStatus.timeUntilNextPulse;
        result="PULSE: NO DATA";
        if(pulseActive){
            result="PULSE: Pulse is active. Next pulse in: " + timeUntilNextPulse + " seconds.";
            if (pulseStatus.fired){
                result="PULSE: INCOMING DATA!";
            }else{
                result+="Pulse has not fired yet.";
            };
        };
        result+="\n\n**MAINFRAME STATUS:**\n";
        if(globalMainframeStatus){
            result+="Mainframe is online and operational.";
            if (globalMainframeStatus.dataHasBeenSent){
                result+="\nData has been sent successfully.";
            }else{
                result+="\nData has not been sent yet.";
            };
            let data=globalMainframeStatus.data;
            if (data){
                result+="\nData: " + JSON.stringify(data, null, 2);
            }else{
                result+="\nNo data available.";
            };
        }else{
            result+="Mainframe Status is currently offline or not operational.";
        };
    }catch(e){
        result = `An error occured while fetching status: ${e}`;
    };
    return result;
})();
