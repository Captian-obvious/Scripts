--!ahsl
local killParts=PartIndexing.GetPartsWithIndex(5);
local spinParts=PartIndexing.GetPartsWithIndex(6);

for i=1,#killParts do
    local part=killParts[i];
    part.Touched:Connect(function(hit)
        if hit.Parent and GetChildOfClass(hit.Parent,"Humanoid") then
            local humanoid=GetChildOfClass(hit.Parent,"Humanoid");
            humanoid.Health=0;
        end;
    end);
end;

for i=1,#spinParts do
    local part=spinParts[i];
    part.Touched:Connect(function(hit)
        if hit.Parent and GetChildOfClass(hit.Parent,"Humanoid") then
            local humanoid=GetChildOfClass(hit.Parent,"Humanoid");
            humanoid.PlatformStand=true;
            wait(0.5);
            humanoid.PlatformStand=false;
        end;
    end);
    task.spawn(function()
        while PartIndexing.GetPartsWithIndex(6)[1] do
            --AHSL workaround for tweens because TweenService is not available in AHSL
            RunAdonisCommand(":rotatepart 6 relative 0,90,0 5 Linear Out")
            task.wait(5);
            if not running then
                break;
            end;
        end;
    end);
end;