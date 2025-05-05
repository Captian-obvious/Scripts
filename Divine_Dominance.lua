local tool=script.Parent;
local Services={
    Players=game:GetService("Players"),
    ServerStorage=game:GetService("ServerStorage"),
    TweenService=game:GetService("TweenService"),
    InsertService=game:GetService("InsertService"),
    ReplicatedStorage=game:GetService("ReplicatedStorage")
};
function spawnCage(cf:CFrame)
    local box_obj={
        maxSize=300,
        timer=420,
        currentSize=0,
        changedConnection=nil,
        shrinkTime=30,
        killSize=40,
    };
    local thebox=Instance.new("Model",workspace);
    thebox.Name="divine_dominance_trap";
    local thebox_meshpart=Services.InsertService:CreateMeshPartAsync("the soon to be box meshid");
    thebox_meshpart.Parent=thebox;
    thebox_meshpart.Material=Enum.Material.ForceField;
    thebox_meshpart.Color=Color3.fromRGB(255,200,0);
    thebox_meshpart.Size=Vector3.new(1,1,1);
    thebox_meshpart.Name="box_of_doom";
    box_obj.Instance=thebox;
    function box_obj.start(self)
        local expandinfo=TweenInfo.new(2,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out,0,false,0);
        local expandTween=Services.TweenService:Create(thebox_meshpart,expandinfo,{Size=Vector3.new(self.maxSize,self.maxSize,self.maxSize)});
        expandTween:Play();
        self.changedConnection=thebox_meshpart.Changed:Connect(function(prop)
            if prop=="Size" then
                self.currentSize=thebox_meshpart.Size.X;
            end;
        end);
    end;
    function box_obj.GetPlayersInsideTrap(self):{Player}
        local trappedPlayers={};
        local region=Region3.new(
            thebox_meshpart.Position - Vector3.new(self.currentSize / 2, self.currentSize / 2, self.currentSize / 2),
            thebox_meshpart.Position + Vector3.new(self.currentSize / 2, self.currentSize / 2, self.currentSize / 2)
        );
        local parts=workspace:FindPartsInRegion3(region, nil, math.huge);
        for _,part in pairs(parts) do
            local char=part.Parent;
            local plr=Services.Players:GetPlayerFromCharacter(char);
            if plr and char:FindFirstChildOfClass("Humanoid") then
                table.insert(trappedPlayers,plr);
            end;
        end;
        return trappedPlayers;
    end;
    function box_obj.timer_finished(self)
        -- plays a chain sound and then starts shrinking
        -- thebox_meshpart.TimeCount:Play()
        local shrinkinfo=TweenInfo.new(self.shrinkTime,Enum.EasingStyle.Linear,Enum.EasingDirection.In,0,false,0);
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
        if self.changedConnection then
            self.changedConnection:Disconnect();
            self.changedConnection=nil;
        end;
        thebox_meshpart.CanCollide=false;
        local finalTween=Services.TweenService:Create(thebox_meshpart,TweenInfo.new(0.2,Enum.EasingStyle.Exponential,Enum.EasingDirection.In,0,false,0),{Size=Vector3.new(.1,.1.,1)});
        finalTween:Play();
        finalTween.Completed:Connect(function(playbackState)
            if playbackState==Enum.PlaybackState.Completed then
                thebox:Destroy();
            end;
        end);
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
            task.spawn(function()
                task.wait(theboxobj.timer);
                theboxobj:timer_finished();
            end);
        end;
    end;
end);