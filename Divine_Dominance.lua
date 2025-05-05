local tool=script.Parent;
local Services={
    Players=game:GetService("Players"),
    ServerStorage=game:GetService("ServerStorage"),
    TweenService=game:GetService("TweenService"),
    ReplicatedStorage=game:GetService("ReplicatedStorage")
};
function doFinal(plr:Player)
    if plr.Character then
        local h:Humanoid=plr.Character:FindFirstChildOfClass("Humanoid");
    end;
end;
function spawnCage(cf:CFrame)
    local thebox=Instance.new("Model",workspace);
    thebox.Name="box_of_doom";
end;

tool.Activated:Connect(function()
    local plr=Services.Players:GetPlayerFromCharacter(tool.Parent);
    if plr then
        -- logic for actually placing a box down that grows and traps the other players
    end;
end);