local cam=workspace.CurrentCamera;
local plr=game.Players.LocalPlayer;
local isViewing=false;
local fp=false;
local plrChar=plr.Character;
local RunServ=game:GetService("RunService");
local TweenService=game:GetService("TweenService");
function raycast(he,ignore)
    local cf = he.CFrame * CFrame.new(0,0,-2);
    local direction = (he.CFrame.Position-cf.Position);
    local params = RaycastParams.new();
    params.FilterType = Enum.RaycastFilterType.Exclude;
    params.IgnoreWater = true;
    params.FilterDescendantsInstances = ignore;
    local result = workspace:Raycast(cf.Position,direction,params);
    if result and result.Instance then
        return result.Instance;
    else
        return nil;
    end;
end;
function unblocked(part)
    if part:FindFirstChild('RightCollarAttachment') or part:FindFirstChild('LeftCollarAttachment') then
        return true;
    else
        return false;
    end;
end;
function GetBlockingAccessories(plr)
    local c = plr.Character;
    if c then
        local he = c:FindFirstChild('Head');
        if he then
            local accessories = {};
            local blockage = raycast(he,accessories);
            local run = true;
            if blockage then
                while run do
                    blockage = raycast(he,accessories);
                    if blockage~=nil and blockage~=he then
                        table.insert(accessories,blockage);
                        run = true;
                    else
                        run = false;
                    end;
                end;
            end;
            return accessories;
        end;
    end;
    
end;
if RunServ:IsClient() then
    print("Better First Person Cam Script loaded! Press V to toggle First Person");
    warn("Warning!\nThis script may cause motion sickness if in First Person when being flung around!")
    local parts=plrChar:GetDescendants();
    local h=plrChar:FindFirstChildOfClass("Humanoid");
    RunServ.RenderStepped:Connect(function(deltaTime)
        local head=plrChar:FindFirstChild("Head");
        parts=plrChar:GetDescendants();
        fp=(cam.Focus.Position-cam.CFrame.Position).Magnitude<=0.6;
        if h then
            h.CameraOffset=(not fp) and Vector3.new(0,0,0) or Vector3.new(0,-0.2,-0.9);
        end;
        if fp and head then
            cam.FieldOfView=90;
            for _,d in pairs(parts) do
                if d:IsA("BasePart") then
                    task.spawn(function()
                        if d.LocalTransparencyModifier ~= 0 and not d.Parent:IsA('Accoutrement') then
                            d.LocalTransparencyModifier = 0;
                        elseif d.Parent:IsA('Accoutrement') then
                            if d.LocalTransparencyModifier ~= 1 then
                                d.LocalTransparencyModifier = 1;
                            end;
                        end;
                    end);
                end;
            end;
            for _,acc in pairs(GetBlockingAccessories(plr)) do
                if acc:IsA('BasePart') and acc.Parent:IsA('Accoutrement') then
                    task.spawn(function()
                        if acc.LocalTransparencyModifier~=1 and acc:IsDescendantOf(Character) and unblocked(acc)~=true then
                            acc.LocalTransparencyModifier = 1;
                        end;
                    end);
                end;
            end;
        else
            cam.FieldOfView=70;
        end;
    end);
else
    warn("Better First Person Cam Script is meant to be run on the client side!");
end;