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
local timeSafe=110;
local damageTimerMax=20;
local timeToDamage=math.max(0,timeSafe-damageTimerMax);
local passedTime=0;
local damageTimer=0;
local damageApplying=false;
local recovering=false;
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
if character then
    character:SetAttribute('CanDrown',true);
    local plr=Services.Players:GetPlayerFromCharacter(character);
    local h=character:FindFirstChildOfClass('Humanoid');
    if h then
        h.Died:Connect(function()
            local head=h.Parent:FindFirstChild('Head');
            if head then
                if checkIfWater(head.CFrame.Position+Vector3.new(0,2,0)) and character:GetAttribute('CanDrown')==true then
                    chat:MakeSystemMessage(plr.Name,{Text="You drowned!",Color=Color3.new(1,64/255,77/255),Font='Ubuntu'});
                end;
            end;
        end);
        while h and h.Health>0 do
            local dt=task.wait();
            local head=h.Parent:FindFirstChild('Head');
            if head then
                local underwater=checkIfWater(head.CFrame.Position+Vector3.new(0,2,0));
                if underwater and character:GetAttribute('CanDrown')==true then --snap to voxel above head, prevents shallow drown
                    recovering=false;
                    if damageTimer>0 then
                        if not damageApplying then
                            damageApplying=true;
                            print("Damage applyer started, damageTimer Value:",damageTimer);
                            event:FireClient(plr,"damage_overlay",damageTimerMax-damageTimer,damageApplying);
                        end;
                        damageTimer+=dt;
                        if damageTimer>=damageTimerMax then
                            damageApplying=false;
                            print("Damage applyer ended, damageTimer Value:",damageTimer);
                            local damageTag=Instance.new('StringValue',h);
                            damageTag.Name="DeathTag";
                            damageTag.Value="drowned";
                            h:TakeDamage(h.MaxHealth);
                        end;
                    else
                        passedTime+=dt;
                        if not damageApplying and passedTime>=timeToDamage then
                            damageTimer+=dt;
                        end;
                    end;
                    --print("detected");
                else
                    if damageTimer>0 then
                        damageApplying=false;
                        if not recovering then
                            recovering=true;
                            print("Damage recoverer started, damageTimer Value:",damageTimer);
                            event:FireClient(plr,"damage_overlay",damageTimer,damageApplying);
                        end;
                        damageTimer-=dt;
                        if damageTimer<=0 then
                            recovering=false;
                            print("Damage recoverer ended, damageTimer Value:",damageTimer);
                            damageTimer=0;
                            passedTime=0;
                        end;
                    else
                        damageTimer=0;
                        passedTime=math.max(0,passedTime-(dt*(timeToDamage/damageTimerMax))); --AUTOSCALE! this basically means whatever the damage timer is is the time it takes to recover without drowning at max timer
                    end;
                end;
            end;
        end;
    end;
end;
