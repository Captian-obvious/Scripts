local Players=game:GetService('Players')
local Replicated=game:GetService('ReplicatedStorage')
local plr = script.Player.Value
local score=0
function display(ty,ti,config)
    local baseui = plr.PlayerGui:FindFirstChild('Dis_Win_Relay') or Instance.new('ScreenGui',plr.PlayerGui)
    baseui.Name='Dis_Win_Relay'
    local theui = baseui:FindFirstChild('main') or Instance.new('Frame',baseui)
    theui.Name='main'
    local clButton = theui:FindFirstChild('Close') or Instance.new('TextButton',theui)
    clButton.AnchorPoint=Vector2.new(1,0)
    clButton.Size=UDim2.new(.1,0,.1,0)
    clButton.Position=UDim2.new(1,0,0,0)
    clButton.Text='X'
    local clRatio = clButton:FindFirstChild('ratio') or Instance.new('UIAspectRatioConstraint',clButton)
    clRatio.Name='ratio'
    clRatio.AspectRatio=1
    if ty=='msg' or ty=='text' then

    end
    if ty=='window' or ty=='frame' then
        
    end
end
function start()
    score=0
    
end

