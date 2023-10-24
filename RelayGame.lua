local Players=game:GetService('Players')
local Replicated=game:GetService('ReplicatedStorage')
local plr = script.Player.Value
local score=0
function display(ty,ti,config)
    local baseui = plr.PlayerGui:FindFirstChild('Dis_Win_Relay') or Instance.new('ScreenGui',plr.PlayerGui)
    baseui.Name='Dis_Win_Relay'
    local theui = baseui:FindFirstChild('main') or Instance.new('Frame',baseui)
    theui.Name='main'
    theui.BackgroundTransparency=1
    local clButton = theui:FindFirstChild('Close') or Instance.new('TextButton',theui)
    clButton.AnchorPoint=Vector2.new(1,0)
    clButton.Size=UDim2.new(.1,0,.1,0)
    clButton.Position=UDim2.new(1,0,0,0)
    clButton.Text='X'
    clButton.BackgroundTransparency=1
    local clRatio = clButton:FindFirstChild('ratio') or Instance.new('UIAspectRatioConstraint',clButton)
    clRatio.Name='ratio'
    clRatio.AspectRatio=1
    if ty=='msg' or ty=='text' then

    end
    if ty=='window' then
        local uielement = Instance.new('Frame',baseui)
        uielement.Name=config.Name or 'WINDOW_'
        uielement.BackgroundTransparency=configs.BGTrans or 1
        uielement.BackgroundColor3=configs.BGC3 or Color3.new(1,1,1)
        uielement.Position=configs.Position or UDim2.new(0,0,0,0)
        uielement.AnchorPoint=configs.AnchorPoint or Vector2.new(0,0)
        if configs.elStyle then
            if configs.Stroke then
                local style=configs.Stroke
                local uistr=Instance.new('UIStroke',uielement)
                uistr.Thickness=style.Thickness
                uistr.ApplyStrokeMode=style.Mode
                uistr.Color=style.Color
            end
        end
    end
end
function start()
    score=0
    
end

