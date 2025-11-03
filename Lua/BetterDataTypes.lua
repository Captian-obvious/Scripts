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
function mod.boolfromnumber(value)
    if value==0 then
        return false;
    else
        return true;
    end;
end;
function mod.array(elementCount,defaultValue)
    local t={};
    function t:count()
        local count=0;
        for k,v in pairs(self) do
            if type(k)~="function" then
                count=count+1;
            end;
        end;
        return count;
    end;
    function t:contains(value)
        for k,v in pairs(self) do
            if v==value then
                return true;
            end;
        end;
        return false;
    end;
    function t:append(value)
        table.insert(self,value);
    end;
    local metatable={__index=table};
    setmetatable(t,metatable);
    for i=1,elementCount do
        t[i]=defaultValue;
    end;
    return t;
end;
function mod.copytable(t)
    local newTable={};
    for k,v in pairs(t) do
        newTable[k]=v;
    end;
    return newTable;
end;
function mod.dictionary()
    local t={};
    function t:keys()
        local keysArray={};
        for k,v in pairs(self) do
            if type(k)~="function" then
                table.insert(keysArray,k);
            end;
        end;
        return keysArray;
    end;
    function t:values()
        local valuesArray={};
        for k,v in pairs(self) do
            if type(v)~="function" then
                table.insert(valuesArray,v);
            end;
        end;
        return valuesArray;
    end;
    local metatable={
        __index=table,
        __newindex=function(table,key,value)
            rawset(table,key,value);
        end
    };
    setmetatable(t,metatable);
    return t;
end;
return mod;