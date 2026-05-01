--[[
== WATER HANDLER ==
Controls how player interactions with Water behave
In this case, adding an oxygen system
]]
local Services={
	Players=game:GetService('Players'),
	ReplicatedStorage=game:GetService("ReplicatedStorage"),
	Terrain=workspace.Terrain
};
local character=script.Parent;
local chat=require(script.ServerMessages);
local timeToDamage=100; --time until it kills the player
local passedTime=0;
local damageTimerMax=20;
local damageTimer=0;
local hasStartedSequence=false;
local damageApplying=false;
if chat.Initialized~=true then
	chat:Initialize();
end;
local event=Services.ReplicatedStorage:FindFirstChild("DrownCallbackHandler") or Instance.new("RemoteEvent",Services.ReplicatedStorage);
event.Name="DrownCallbackHandler";
function checkIfWater(pos:Vector3)
	local voxelSize=4; --DO NOT CHANGE
	local size=Vector3.new(voxelSize,voxelSize,voxelSize);
	local region=Region3.new(pos-size/2,pos+size/2);
	region=region:ExpandToGrid(voxelSize);
	local material,occupancy=Services.Terrain:ReadVoxels(region,voxelSize);
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
function damageApplyer(h)
	damageApplying=true;
	while damageApplying and damageTimer<damageTimerMax do
		damageTimer+=task.wait();
	end;
	damageTimer=0;
	if damageApplying then
		h:TakeDamage(h.MaxHealth);
	end;
end;
if character then
	character:SetAttribute('CanDrown',true);
	local plr=Services.Players:GetPlayerFromCharacter(character);
	local h=character:FindFirstChildOfClass('Humanoid');
	if h then
		h.Died:Connect(function()
			local rootPart=h.RootPart;
			local head=h.Parent:FindFirstChild('Head');
			if rootPart then
				if checkIfWater(rootPart.CFrame.Position) and character:GetAttribute('CanDrown')==true then
					chat:MakeSystemMessage(plr.Name,{Text="You drowned!",Color=Color3.new(1,64/255,77/255),Font='Ubuntu'});
				end;
			end;
		end);
		while h and h.Health>0 do
			local dt=task.wait();
			local head=h.Parent:FindFirstChild('Head');
			if head then
				if checkIfWater(head.CFrame.Position+Vector3.new(0,2,0)) and character:GetAttribute('CanDrown')==true then --snap to voxel above head, prevents shallow drown
					passedTime+=dt;
					--print("Player is underwater"); --debug, will remove once i confirm something
					if not hasStartedSequence and passedTime>=timeToDamage then
						hasStartedSequence=true;
						if event then
							event:FireClient(plr,"start_drown",damageTimerMax,hasStartedSequence);
						end;
						task.spawn(damageApplyer,h);
					end;
				else
					damageApplying=false;
					if passedTime>=(timeToDamage-damageTimerMax) and hasStartedSequence then
						hasStartedSequence=false;
						if event then
							event:FireClient(plr,"start_drown",damageTimer,hasStartedSequence);
						end;
					end;
					passedTime=0;
				end;
			end;
		end;
	end;
end;