local mod={};
function mod.tonumber(value)
    if typeof(value)=="boolean" then
        if value==true then
            return 1;
        else
            return 0;
        end;
    elseif typeof(value)=="string" then
        return tonumber(value);
    end;
end;
return mod;