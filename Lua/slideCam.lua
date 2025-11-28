local cam=workspace.CurrentCamera;
local plr=owner;
local isViewing=false;
local plrChar=plr.Character;
local RunServ=game:GetService("RunService");
local UserInputServ=game:GetService("UserInputService");
if RunServ:IsClient() then
    UserInputServ.InputBegan:Connect(function(input,gpe)
        if not gpe then
            if input.KeyCode==Enum.KeyCode.V then
                isViewing=not isViewing;
            end;
        end;
    end);
    RunServ.RenderStepped:Connect(function(deltaTime)
        local head=plrChar:FindFirstChild("Head");
        if isViewing and head then
            cam.CameraType=Enum.CameraType.Scriptable;
            cam.CFrame=head.CFrame*CFrame.new(0,0,-0.5);
            cam.FieldOfView=90;
        else
            cam.CameraType=Enum.CameraType.Custom;
            cam.FieldOfView=70;
        end;
    end);
else
    warn("The slideCam script is meant to be run on the client side!");
end;