--!ahsl
local order={1,3,2,5,4,7,6,8};
local baseIndex=20;
local buttons={};
for i=1,#order do
    table.insert(buttons,PartIndexing.GetPartsWithIndex(baseIndex+order[i])[1]);
end;
if #buttons>0 then

else
    warn("No parts with indexes based around "..tostring(baseIndex).." found for order: "..table.concat(order,","));
end;