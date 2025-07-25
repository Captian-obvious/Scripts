--!ahsl
local order={1,3,2,5,4,7,6,8};
local baseIndex=20;
local buttons={};
for i=1,#order do
    local res,err=pcall(function()
        table.insert(buttons,PartIndexing.GetPartsWithIndex(baseIndex+order[i])[1]);
    end);
    if not res then
        warn("No parts with index" ..tostring(baseIndex+order[i]).." were found, or an error occured during execution")
    end;
end;
if #buttons>0 then

else
    warn("No parts with indexes based around "..tostring(baseIndex).." found for order: "..table.concat(order,","));
end;