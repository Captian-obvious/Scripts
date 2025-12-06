local cam=workspace.CurrentCamera;
local plr=owner;
local isViewing=false;
local fp=false;
local plrChar=plr.Character;
local RunServ=game:GetService("RunService");
local UserInputServ=game:GetService("UserInputService");
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
    print("slideCam Script loaded! Press V to toggle First Person");
    warn("Warning!\nThis script may cause motion sickness if in First Person when being flung around!")
    UserInputServ.InputBegan:Connect(function(input,gpe)
        if not gpe then
            if input.KeyCode==Enum.KeyCode.V then
                isViewing=not isViewing;
                if isViewing then
                    print("First Person View Enabled");
                    local fovTween=TweenService:Create(cam,TweenInfo.new(.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out,0,false,0),{FieldOfView=1});
                    fovTween:Play();
                    fovTween.Completed:Wait();
                    cam.FieldOfView=90;
                    fp=true;
                else
                    print("First Person View Disabled");
                    cam.FieldOfView=1;
                    fp=false;
                    local fovTween=TweenService:Create(cam,TweenInfo.new(.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out,0,false,0),{FieldOfView=70});
                    fovTween:Play();
                    fovTween.Completed:Wait();
                end;
            end;
        end;
    end);
    RunServ.RenderStepped:Connect(function(deltaTime)
        local head=plrChar:FindFirstChild("Head");
        if fp and head then
            cam.CameraType=Enum.CameraType.Scriptable;
            cam.CFrame=head.CFrame*CFrame.new(0,0,-0.5);
            local parts=plrChar:GetDescendants();
            for _,d in pairs(parts) do
				if d:IsA("BasePart") then
					task.spawn(function()
						if d.LocalTransparencyModifier ~= d.Transparency and not d.Parent:IsA('Accoutrement') then
							d.LocalTransparencyModifier = d.Transparency;
						elseif d.Parent:IsA('Accoutrement') then
							local isBlocked = a:IsBlockedAccessory(d.Parent);
							--local isTrans = a:IsTransAccessory(d.Parent)
							if d.LocalTransparencyModifier ~= d.Transparency and isBlocked~=true then
								d.LocalTransparencyModifier = d.Transparency;
							elseif isBlocked == true and d.LocalTransparencyModifier ~= 1 then
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
            cam.CameraType=Enum.CameraType.Custom;
            for _,d in pairs(parts) do
				if d:IsA("BasePart") then
					task.spawn(function()
						d.LocalTransparencyModifier = 0;
					end);
				end;
			end;
        end;
    end);
else
    warn("The slideCam script is meant to be run on the client side!");
end;