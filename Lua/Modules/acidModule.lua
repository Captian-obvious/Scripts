local dWalkspeed = 0;
local wsdb = true;
local touching = false;
local e = false;
local k = false;
local k2 = false;
local parts = {};
local tweenService = game:GetService("TweenService");
local timer = 0;
local db = false;
local maxTimer = 200;
local cycleLength=5;
local maxRandomVelocity=12;
local vel={maxRandomVelocity,maxRandomVelocity/2,maxRandomVelocity/3,-maxRandomVelocity/3,-maxRandomVelocity/2,-maxRandomVelocity};
local maxCycles=maxTimer/cycleLength;
function recursive(obj)
	local function findFirstDescendantWhichIsA(className, parent)
		for _, v in pairs(parent:GetDescendants()) do
			if v:IsA(className) then
				return v;
			end;
		end;
		return nil;
	end;
	task.spawn(function()
		if obj ~= workspace and not obj:IsA("Player") and not obj:IsA("Backpack") and not obj:FindFirstChildWhichIsA("Humanoid") and not findFirstDescendantWhichIsA('BasePart', obj) then
			local objParent = obj.Parent;
			if objParent~=nil and obj~=objParent then
				obj:Destroy();
				recursive(objParent);
			end;
		end;
	end);
end;
cs={};
local transparencyUnit = 1/maxCycles;
local dissolvingParts={};
local dissolvingHumanoids={};
function onTouchEnded(hitPart)
	local Character = (hitPart and hitPart.Parent:FindFirstChildWhichIsA("Humanoid")) and hitPart.Parent;
	local Humanoid = Character:FindFirstChildWhichIsA("Humanoid");
	if Character and Humanoid then
		local thehum=table.find(dissolvingHumanoids,Humanoid);
		if thehum then
			table.remove(dissolvingHumanoids,thehum);
			cs[Humanoid]:Disconnect();
			cs[Humanoid]=nil;
		end;
		touching = false;
		db = false;
	else
		touching = false;
		db = false;
	end;
end;
local parent=script.Parent.Parent.AcidDissolvedParts;
script.Parent.TouchEnded:Connect(onTouchEnded);
while script and script.Parent and script.Enabled==true do 
	task.wait(cycleLength);
	timer+=cycleLength;
	local randomVel=Vector3.new(vel[math.random(1,#vel)],-maxRandomVelocity,vel[math.random(1,#vel)]);
	for _,part in pairs(script.Parent:GetTouchingParts()) do
		if part:IsA("BasePart") and (not part:IsDescendantOf(script.Parent.Parent.Parent)) then
			task.spawn(function()
				local Humanoid=part.Parent:FindFirstChildOfClass("Humanoid");
				if Humanoid and not table.find(dissolvingHumanoids,Humanoid) then
					table.insert(dissolvingHumanoids,Humanoid)
					Humanoid:SetAttribute('FallImmune',false);
					cs[Humanoid]=Humanoid.Died:Connect(function()
						cs[Humanoid]:Disconnect();
						Humanoid.RootPart:Destroy();
						cs[Humanoid]=nil;
					end);
				end;
				part:ApplyImpulse(randomVel*part:GetMass());
				if part.Name~="HumanoidRootPart" and part.Name~="RootPart" and part.Name~="Root" then
					local dissolveTween=tweenService:Create(part,TweenInfo.new(cycleLength*(4/5),Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{Transparency=part.Transparency + transparencyUnit});
					dissolveTween:Play();
					dissolveTween.Completed:Connect(function(ps)
						if ps==Enum.PlaybackState.Completed then
							if part.Transparency >= 1 then
								local Model = part.Parent;
								local baseSize=part.Size.X;
								local disPos = (part.Position*Vector3.new(1,0,1))+((script.Parent.Position*Vector3.new(0,1,0))+script.Parent.Size*Vector3.new(0,.5,0));
								if part.Parent and not part.Parent:IsA("Accessory") then
									local newPart=Instance.new("Part");
									newPart.Size = Vector3.new(0.1,baseSize,baseSize);
									newPart.CFrame=CFrame.new(disPos)*CFrame.Angles(0,0,math.rad(90));
									newPart.Shape=Enum.PartType.Cylinder;
									newPart.BrickColor = part.BrickColor;
									newPart.TopSurface = Enum.SurfaceType.Smooth;
									newPart.BottomSurface = Enum.SurfaceType.Smooth;
									newPart.CastShadow=false;
									newPart.Anchored=true;
									newPart.Name="L-"..part.Name;
									newPart.Transparency=0.02;
									newPart.Parent=parent;
									local mult=(part.Size.Z>2) and part.Size.Z or 2;
									local expand=tweenService:Create(newPart,TweenInfo.new(0.4,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false,0),{Size=Vector3.new(0.1,baseSize*mult,baseSize*mult)});
									expand:Play();
									for _,v in pairs(parent:GetChildren()) do
										if v~=newPart then
											local NoCollisionConstraint=Instance.new("NoCollisionConstraint");
											NoCollisionConstraint.Part0=newPart;
											NoCollisionConstraint.Part1=v;
											NoCollisionConstraint.Parent=newPart;
										end;
									end;
									expand.Completed:Wait();
									newPart.Anchored=false;
								end;
								part:Destroy();
								k = false;
								recursive(Model);
								timer=0;
							end;
						end;
					end);
				end;
			end);
		end;
	end;
end;