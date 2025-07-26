--!ahsl
local order={1,3,2,5,4,7,6,8};
local baseIndex=20;
local maxDistance=10;
local orderPart=0; -- the place where we are in the order
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
function handleButtonClick(player,button,currentButton)
    if not player or not button then return end;
    local tindex=table.find(buttons,button);
    if tindex then
        local index=order[tindex];
        print("Button clicked: " .. tostring(button.Name) .. " with index: " ..tostring(index));
        if button==currentButton then
            print("Correct order on part "..tostring(orderPart));
            if orderPart==#order then
                print("Successful order");
            end;
        else
            print("Unsuccessful Order, reset >:)");
            orderPart=0;
        end;
    end;
end;
print("table of buttons: ".. tostring(table.concat(buttons, ", ")));
if buttons[1] ~= nil then
    for i=1,#buttons do
        local v=buttons[i];
        if IsA(v,"BasePart") then
            spawn(function()
                local ClickDetector=Instance.new("ClickDetector",v);
                ClickDetector.MaxActivationDistance=maxDistance;
                ClickDetector.MouseClick:Connect(function(player)
                    orderPart=orderPart+1;
                    handleButtonClick(player,v,buttons[orderPart] or nil);
                end);
            end);
        else
            warn("Button at index " .. tostring(i) .. " is not a BasePart, skipping.");
        end;
    end;
end;