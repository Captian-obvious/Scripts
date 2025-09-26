--!ahsl
local assetId=nil;
local base_uri="https://captianobvious.pythonanywhere.com/api/v3/asset";

RegisterAdonisCommand(":loadasset",1,function(args)
    assetId=args[1];
    if tonumber(assetId) then
        local suc,parsed=pcall(function()
            local response=Http.Request({
                Url=base_uri.."/"..assetId.."?placeId="..game.PlaceId, --placeid is required for request to function
                Method="GET",
                Headers={
                    "Accept":"application/json",
                },
            });
            if response.ok then
                return parsed;
            end;
        end);
    end;
end);