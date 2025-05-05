local tool=script.Parent;
local Services={
    Players=game:GetService("Players"),
    ServerStorage=game:GetService("ServerStorage"),
    TweenService=game:GetService("TweenService"),
    InsertService=game:GetService("InsertService"),
    ReplicatedStorage=game:GetService("ReplicatedStorage")
};
function doFinal(plr:Player)
    if plr.Character then
        local h:Humanoid=plr.Character:FindFirstChildOfClass("Humanoid");
    end;
end;
function spawnCage(cf:CFrame)
    local box_obj={
        maxSize=300,
        timer=420,
        shrinkTime=30,
        killSize=40,
    };
    local thebox=Instance.new("Model",workspace);
    thebox.Name="divine_dominance_trap";
    local thebox_meshpart=Services.InsertService:CreateMeshPartAsync("the soon to be box meshid");
    thebox_meshpart.Parent=thebox;
    thebox_meshpart.Name="box_of_doom";
    thebox_meshpart.Material=Enum.Material.ForceField;
    thebox_meshpart.Color=Color3.fromRGB(255,200,0);
    thebox_meshpart.Size=Vector3.new(1,1,1);
    box_obj.Instance=thebox;
    function box_obj.start(self)
        local expandinfo=TweenInfo.new(2,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out,0,false,0);
        local expandTween=Services.TweenService:Create(thebox_meshpart,expandinfo,{Size=Vector3.new(self.maxSize,self.maxSize,self.maxSize)});
        expandTween:Play();
    end;
    function box_obj.GetPlayersInsideTrap(self):{Player}
        -- will implement soon
    end;
    function box_obj.timer_finished(self)
        -- plays a chain sound and then starts shrinking
        -- thebox_meshpart.TimeCount:Play()
        local shrinkinfo=TweenInfo.new(self.shrinkTime,Enum.EasingStyle.Exponential,Enum.EasingDirection.In,0,false,0);
        local shrinkTween=Services.TweenService:Create(thebox_meshpart,shrinkinfo,{Size=Vector3.new(self.killSize,self.killSize,self.killSize)});
        shrinkTween:Play();
        shrinkTween.Completed:Connect(function(playbackState)
            if playbackState==Enum.PlaybackState.Completed then
                self:final();
            end;
        end);
    end;
    function box_obj.final(self)
        local playersTrapped=self:GetPlayersInsideTrap();
        for i,plr in pairs(playersTrapped) do
            if plr.Character then
                local h=plr.Character:FindFirstChildOfClass("Humanoid");
                if h then
                    h.Health=0;
                end;
            end;
        end;
        local finalTween=Services.TweenService:Create(thebox_meshpart,TweenInfo.new(0.2,Enum.EasingStyle.Exponential,Enum.EasingDirection.In,0,false,0),{Size=Vector3.new(.1,,.1.,1)});
        finalTween:Play();
    end;
    return box_obj;
end;

tool.Activated:Connect(function()
    local plr=Services.Players:GetPlayerFromCharacter(tool.Parent);
    if plr then
        local mouse=plr:GetMouse();
        if mouse then
            local the_cframe=CFrame.new(mouse.Hit.Position);
            local theboxobj=spawnCage(the_cframe);
            theboxobj:start();
        end;
    end;
end);