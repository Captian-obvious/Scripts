--!ahsl
local assetId=nil;
local base_uri="https://captianobvious.pythonanywhere.com/api/v3/asset";

RegisterAdonisCommand("loadasset",1,function(args_string)
    assetId=args_string;
    if tonumber(assetId) then
        local ok,parsed=pcall(function()
            local response=Http.Request({
                Url=base_uri.."/"..assetId.."?placeId="..game.PlaceId, --placeid is required for request to function
                Method="GET",
                Headers={
                    "Accept":"application/json",
                },
            });
            if response.Success then
                print("Response size:",#response.Body);
                local ok,dat = pcall(function()
                    return Http.JSONDecode(response.Body);
                end);
                if ok then
                    return dat;
                else
                    warn("Failed to parse JSON for asset " .. assetId .. ": " .. tostring(dat))
                    return nil;
                end;
            else
                warn("Request to fetch asset failed due to request error: "..response.StatusMessage.." ("..tostring(response.StatusCode)..")");
                return nil;
            end;
        end);
        if ok then
            BuildAsset(parsed);
        else
            warn("Asset retrieval failed: "..tostring(parsed));
        end;
    else
        warn("AssetId must be a number!")
    end;
end);

function BuildAsset(data)
    print(data);
end;