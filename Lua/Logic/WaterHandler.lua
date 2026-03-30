local Services={
    Players=game:GetService('Players'),
    ReplicatedStorage=game:GetService("ReplicatedStorage"),
    Terrain=workspace.Terrain
};
local character=script.Parent;
local chat=require(script.SystemMessages);
if chat.Initialized~=true then
    chat:Initialize();
end;
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
local timeToDamage=120;
local passedTime=0;
local damageTimer=20;
local hasStartedSequence=false;
local damageApplying=false;
if character then
    character:SetAttribute('CanDrown',true);
    local plr=Services.Players:GetPlayerFromCharacter(character);
    local h=character:FindFirstChildOfClass('Humanoid');
    if h then
        task.spawn(function()
            while h and h.Health>0 do
                local dt=task.wait();
                local head=h.Parent:FindFirstChild('Head');
                if head then
                    if checkIfWater(head.Position) then
                        passedTime+=dt;
                        if passedTime>=timeToDamage and not hasStartedSequence then
                            hasStartedSequence=true;
                            local event=Services.ReplicatedStorage:FindFirstChild("DrownCallbackHandler");
                            if event then
                                event:FireClient(plr,"start_drown",20,hasStartedSequence);
                            end;
                            task.spawn(function()
                                damageApplying=true;
                                while damageTimer>0 and damageApplying do
                                    damageTimer-=task.wait();
                                end;
                                if damageApplying then
                                    h:TakeDamage(h.MaxHealth);
                                end;
                            end);
                        end;
                    else
                        damageApplying=false;
                        if passedTime>=timeToDamage and hasStartedSequence then
                            hasStartedSequence=false;
                            local event=Services.ReplicatedStorage:FindFirstChild("DrownCallbackHandler");
                            if event then
                                event:FireClient(plr,"start_drown",damageTimer,hasStartedSequence);
                            end;
                        end;
                        passedTime=0;
                    end;
                end;
            end;
        end);
        h.Died:Connect(function()
            local rootPart=h.RootPart;
            local head=h.Parent:FindFirstChild('Head');
            if rootPart then
                if checkIfWater(rootPart.Position) then
                    --print('Player is in water');
                    if character:GetAttribute('CanDrown')==true then
                        chat:MakeSystemMessage(plr.Name,{Text="You drowned!",Color=Color3.new(1,64/255,77/255),Font='Ubuntu'});
                    end;
                end;
            end;
        end);
    end;
end;