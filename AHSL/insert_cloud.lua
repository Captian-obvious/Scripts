--!ahsl
local assetId=nil;

RegisterAdonisCommand(":loadasset",1,function(args)
    assetId=args[1];
    if tonumber(assetId) then
        local ID=tonumber(assetId);

    end;
end);