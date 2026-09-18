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
local oldprint,oldwarn=print,warn;
local DEBUG_PREFIX="[WaterHandler]:";
local function print(...)
	if not game:GetService("RunService"):IsStudio() then return; end;
	oldprint(DEBUG_PREFIX,...);
end;
local function warn(...)
	if not game:GetService("RunService"):IsStudio() then return; end;
	oldwarn(DEBUG_PREFIX,...);
end;
local character=script.Parent;
local chat=require(script.ServerMessages);
local timeToDamage=100;
local passedTime=0;
local damageTimerMax=20;
local damageTimer=0;
local hasStartedSequence=false;
local damageApplying=false;
local callbackName="DamageCallbackHandler";
local event=Services.ReplicatedStorage:FindFirstChild(callbackName) or Instance.new("RemoteEvent",Services.ReplicatedStorage);
event.Name=callbackName;
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
local conn=nil;
function damageApplyer(h:Humanoid)
	print("Damage applyer started, damageTimer Value:",damageTimer);
	while damageTimer<damageTimerMax do
		damageTimer+=task.wait();
	end;
	if conn then
		conn:Disconnect();
		conn=nil;
	end;
	print("Damage applyer ended, damageTimer Value:",damageTimer);
	if damageApplying then
		damageApplying=false;
		h:TakeDamage(h.MaxHealth);
	end;
	hasStartedSequence=false;
end;
local timerCoroutine=nil;
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
					if not hasStartedSequence and passedTime>=timeToDamage then
						hasStartedSequence=true;
						event:FireClient(plr,"damage_overlay",damageTimerMax,hasStartedSequence);
						--task.spawn(damageApplyer,h);
						if not timerCoroutine then
							damageApplying=true;
							timerCoroutine=coroutine.create(damageApplyer);
							coroutine.resume(timerCoroutine,h);
							conn=event.OnServerEvent:Connect(function(plr)
								if plr.Character~=character then return end; --must be the correct character
								if h and h.Health>0 then
									damageTimer=damageTimerMax; -- stop other if this arrives first
								end;
							end);
						end;
					end;
				else
					damageApplying=false;
					if passedTime>=(timeToDamage-damageTimerMax) and hasStartedSequence then
						hasStartedSequence=false;
						event:FireClient(plr,"damage_overlay",damageTimer,hasStartedSequence);
						if timerCoroutine then
							coroutine.close(timerCoroutine);
							timerCoroutine=nil;
						end;
						if conn then
							conn:Disconnect();
							conn=nil;
						end;
					end;
					passedTime=0;
					damageTimer=0;
				end;
			end;
		end;
	end;
end;