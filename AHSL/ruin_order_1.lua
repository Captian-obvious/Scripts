--!ahsl
local order={1,3,2,5,4,7,6,8};
local baseIndex=20;
local buttons={};
for i=1,#order do
    local res=pcall(function()
        table.insert(buttons,i,PartIndexing.GetPartsWithIndex(baseIndex+order[i])[1]);
    end);
    if not res[1] then
        warn("No parts with index " ..tostring(baseIndex+order[i]).." were found, or an error occured during execution");
        if res[2] then
            warn("Error: " .. tostring(res[2]));
        end;
    end;
end;

if buttons[1] ~= nil then
    for i=1,#buttons do
        local v=buttons[i];
        if IsA(v,"BasePart") then
            local ClickDetector=Instance.new("ClickDetector",v);
        end;
    end;
end;