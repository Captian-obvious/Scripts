--!ahsl
local order={1,3,2,5,4,7,6,8};
local buttons={};
local ordered_buttons={};
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
				for i,v in pairs(buttons) do
					v.BrickColor=BrickColor.new("Lime green");
				end;
			end;
		else
			print("Order Incorrect");
			orderPart=0;
			for i,v in pairs(buttons) do
				v.BrickColor=BrickColor.new("Medium stone grey");
			end;
		end;
	end;
end;
--[[ Create the initial table of buttons, and also add click detectors --]]
for i,v in pairs(workspace.ruins.puzzle1.buttons:GetChildren()) do
	if v and v.Parent and v:IsA("BasePart") then
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