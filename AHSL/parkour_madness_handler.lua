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
        while true do
            part.CFrame=part.CFrame*CFrame.Angles(0,math.rad(5),0);
            task.wait(0.1);
        end;
    end);
end;