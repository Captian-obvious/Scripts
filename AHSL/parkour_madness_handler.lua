--!ahsl
local killParts=PartIndexing.GetPartsWithIndex(5);
local spinParts=PartIndexing.GetPartsWithIndex(6);

for i=1,#killParts do
    local part=killParts[i];
    part.Touched:Connect(function(hit)
        if hit.Parent and hit.Parent.FindFirstChild("Humanoid") then
            local humanoid=hit.Parent.Humanoid;
            humanoid.Health=0;
        end
    end);
end;

for i=1,#spinParts do
    local part=spinParts[i];
    part.Touched:Connect(function(hit)
        if hit.Parent and hit.Parent.FindFirstChild("Humanoid") then
            local humanoid=hit.Parent.Humanoid;
            humanoid.PlatformStand=true;
            wait(0.5);
            humanoid.PlatformStand=false;
        end;
    end);
    task.spawn(function()
        while PartIndexing.GetPartsWithIndex(6)[1]; do
            --AHSL workaround for tweens because TweenService is not available in AHSL
            local t=Tween.Create(part,TweenInfo.new(3,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{CFrame=math.multiply(part.CFrame,CFrame.Angles(0,math.rad(90),0))});
            t:Play();
            t.Completed:Wait();
            if not running then
                break;
            end;
        end;
    end);
end;