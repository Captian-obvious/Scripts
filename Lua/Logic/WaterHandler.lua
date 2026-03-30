local Services+{
    Players=game:GetService('Players'),
    Terrain=workspace.Terrain
};
local character=script.Parent;
local chat=require(script.SystemMessages);
if chat.Initialized~=true then
	chat:Initialize();
end;
function checkIfWater(pos:Vector3, size:Vector3)
	local region=Region3.new(pos-size/2,pos+size/2);
	region=region:ExpandToGrid(4);
	local material,occupancy=Services.Terrain:ReadVoxels(region,4);
	for x,xt in material do
		if typeof(xt)~="table" then
			continue;
		end;
		for y,yt in xt do
			if typeof(yt)~="table" then
				continue;
			end;
			for z,cell in yt do
				if cell==Enum.Material.Water then
					return true;
				end;
			end;
		end;
	end;
	return false;
end;
if character then
	character:SetAttribute('CanDrown',true);
	local plr=Services.Players:GetPlayerFromCharacter(character);
	local h=character:FindFirstChildOfClass('Humanoid');
	if h then
		task.spawn(function()
			while h and h.Health>0 do
				task.wait();
				local head=h.Parent:FindFirstChild('Head');
				if head then
					if checkIfWater(head.Position,Vector3.new(5,5,5)) then
						--print('Player is drown-able');
					end;
				end;
			end;
		end);
		h.Died:Connect(function()
			local rootPart=h.RootPart;
			local head=h.Parent:FindFirstChild('Head');
			if rootPart then
				if checkIfWater(rootPart.Position,Vector3.new(5,5,5)) then
					--print('Player is in water');
					if character:GetAttribute('CanDrown')==true then
						chat:MakeSystemMessage(plr.Name,{Text="You drowned!",Color=Color3.new(1,64/255,77/255),Font='Ubuntu'});
					end;
				end;
			end;
		end);
	end;
end;