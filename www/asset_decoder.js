const userAgent=`Superduperdev2IncFetchUtil/1.0.0`;
const base_url="https://captianobvious.pythonanywhere.com/api/v3";
var placeid=7081918890;
async function ParseAsset(jsonData) {
    const asset = JSON.parse(jsonData);
    if (asset["metadata"] && asset.metadata["ExplicitAutoJoints"]) {
        console.log("Asset was authored with ExplicitAutoJoints, Instance:MakeJoints() will be required to properly display this model.");
    };
    try {
        let TREE=asset.tree;
        let CLASSREF=asset.class_ref;
        console.log(`Asset contains ${asset.instance_count} instances and ${asset.class_count} unique classes.`);
        for (let instance of TREE){
            if (instance.ClassId!==undefined){
                let ref_pointer=CLASSREF[instance.ClassId];
                instance.ClassName=ref_pointer.Name; // if somehow ClassName is missing, add it
                for (let property in ref_pointer.Properties){
                    if (instance.properties===undefined){
                        instance.properties={};
                    };
                };
            };
        };
    } catch (e) {
        console.error("Failed to parse asset data:", e);
    };
    return asset;
};
async function applyChildData(childData){
    let response=await fetch(base_url+"/parse",{
        method:"POST",
        body:childData,
        headers:{
            "Accept":"application/json",
            "User-Agent":userAgent,
        },
    });
    if (response.ok){
        let jsonData=await response.json();
        return jsonData;
    }else{
        return {
            code: response.status,
            message: response.statusText,
            additional: await response.text(),
        };
    };
};