--ahsl
local order={1,3,2,5,4,7,6,8};
local buttons={};
local ordered_buttons={};
local raw_buttons=GetChildren(GetChild(workspace,"buttons"));
local maxDistance=20;
local orderPart=0;
local baseName="button";
function handleButtonClick(player,button)
    if not player or not button or not button.Parent then return end;
    if orderPart <= #order then
        if button==ordered_buttons[orderPart] then
            print("Order Correct");
            button.BrickColor=BrickColor.new("Really red");
            if orderPart==#order then
                for i=1,#buttons do
                    buttons[i].BrickColor=BrickColor.new("Lime green");
                end;
            end;
        else
            print("Order Incorrect");
            orderPart=0;
            for i=1,#buttons do
                buttons[i].BrickColor=BrickColor.new("Medium stone grey");
            end;
        end;
    end;
end;
--[[ Create the initial table of buttons, and also add click detectors --]]
for i=1,#raw_buttons do
    v=raw_buttons[i];
    if v and v.Parent and IsA(v,"BasePart") then
        local tableIndex=tonumber(v.Name:sub(#baseName+1));
        table.insert(buttons,tableIndex,v);
        local clickDetector=Instance.new("ClickDetector",v);
        clickDetector.MaxActivationDistance=maxDistance;
        clickDetector.MouseClick:Connect(function(player)
            orderPart+=1; --increment the order step
            handleButtonClick(player,v);
        end);
    end;
end;
--[[ Create the ordered buttons list --]]
for i=1,#order do
    local button=buttons[order[i]];
    if button then
        table.insert(ordered_buttons,button)
    end;
end;