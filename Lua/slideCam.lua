local cam=workspace.CurrentCamera;
local plr=owner;
local isViewing=false;
local fp=false;
local plrChar=plr.Character;
local RunServ=game:GetService("RunService");
local UserInputServ=game:GetService("UserInputService");
local TweenService=game:GetService("TweenService");
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
        else
            cam.CameraType=Enum.CameraType.Custom;
        end;
    end);
else
    warn("The slideCam script is meant to be run on the client side!");
end;