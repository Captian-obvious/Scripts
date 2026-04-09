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
    if entityFolder then
        local entity=entityFolder:FindFirstChild(entityName);
        if not entity then return end;
        if entity:FindFirstChild("AI") then
            entity.AI.Main.Enabled=true;
        end;
        entity:PivotTo(cf);
    end;
end;

