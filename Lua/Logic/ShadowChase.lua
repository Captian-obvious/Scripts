local Services={
    ReplicatedStorage=game:GetService("ReplicatedStorage"),
    ServerStorage=game:GetService("ServerStorage"),
    Players=game:GetService("Players"),
    TweenService=game:GetService("TweenService")
};
local Modules={
    ArcModule=require(Services.ReplicatedStorage:FindFirstChild("Arc")),
    CutsceneCameraManager=require(Services.ReplicatedStorage:FindFirstChild("CutsceneCameraManager")),
    CameraShake=require(Services.ReplicatedStorage:FindFirstChild("CameraShakeNew"))
};

function spawnEntity(entityName:string,cf:CFrame)
    local entityFolder=Services.ReplicatedStorage:FindFirstChild("Entities") or Services.ServerStorage:FindFirstChild("Entities");
    if not entityFolder then return end;
    local entity=entityFolder:FindFirstChild(entityName);
    if not entity then return end;
    if entity:FindFirstChild("AI") then
        entity.AI.Main.Enabled=true;
    end;
    entity:PivotTo(cf);
    return entity;
end;

local rift = workspace:FindFirstChild("DarkRift");
if not rift then
    error("There is no rift, chase will NOT start");
end;
local riftHandlerModule=rift:FindFirstChild("Rift");
if riftHandlerModule then
    local riftHandler=require(riftHandlerModule);
    script.starting:Play();
    riftHandler:open();
    task.wait(2);
    Modules.CameraShake:shakeCamera("all",1,5,7,1,5);
    task.wait(5);
    task.wait(5);
    task.wait(5);
    riftHandler:close();
end;