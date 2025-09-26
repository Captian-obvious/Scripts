--!ahsl
local assetId=nil;
local base_uri="https://captianobvious.pythonanywhere.com/api/v3/asset";

RegisterAdonisCommand(":loadasset",1,function(args)
    assetId=args[1];
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
                    warn("Failed to parse JSON for asset " .. tostring(assetid) .. ": " .. tostring(dat))
                    return nil;
                end;
            else
                warn("Request to fetch asset failed due to request error: "..response.StatusMessage.." ("..tostring(response.StatusCode)..")");
                return nil;
            end;
        end);
    end;
end);