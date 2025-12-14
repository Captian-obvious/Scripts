local ToFind="BlowerAndMotor";
local blowers={};
local blowerHandler={};
for i,object in pairs(workspace:GetDescendants()) do
    if object.Name==ToFind and object:IsA("Model") then
        table.insert(blowers,object);
    end;
end;

local function SetBlowerState(blowerModel,state)
    local blower=blowerModel:FindFirstChild("Blower");
    if blower then
        blower.isOn.Value=state;
    end;
end;

function blowerHandler:SetAllBlowers(state)
    for i,blowerModel in pairs(blowers) do
        SetBlowerState(blowerModel,state);
    end;
end;

return blowerHandler;