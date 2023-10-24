local Players=game:GetService('Players')
local Replicated=game:GetService('ReplicatedStorage')
local plr = script.Player.Value
local score=0
function style(uielement,elStyle)
    if elStyle then
        if elStyle.CloseButton then
            local style=elStyle.CloseButton
            if style.Value==true then
                local button = Instance.new('TextButton',uielement)
                button.AnchorPoint=Vector2.new(1,0)
                button.Position=UDim2.new(1,0,0,0)
                button.Size=style.Size or UDim2.new(.1,0,.1,0)
                button.TextColor3=style.Color or Color3.new(1,0,0)
                button.Text='X'
                local clRatio = button:FindFirstChild('ratio') or Instance.new('UIAspectRatioConstraint',button)
                clRatio.Name='ratio'
                clRatio.AspectRatio=1
            end
        end
        if elStyle.Stroke then
            local style=elStyle.Stroke
            local uistr=Instance.new('UIStroke',uielement)
            uistr.Thickness=style.Thickness or 2
            uistr.ApplyStrokeMode=style.StrokeMode or Enum.ApplyStrokeMode.Border
            uistr.Color=style.Color or Color3.new(1,1,1)
            uistr.Transparency=style.Transparency or 0
            uistr.LineJoinMode=style.JoinMode or Enum.LineJoinMode.Round
        end
        if elStyle.AspectRatio then
            local style=elStyle.AspectRatio
            local aspectRatio = Instance.new('UIAspectRatioConstraint',uielement)
            aspectRatio.AspectRatio = style.Value or 1
            aspectRatio.AspectType = style.Type or Enum.AspectType.FitWithinMaxSize
            aspectRatio.DominantAxis = style.Axis or Enum.DominantAxis.X
        end
        if elStyle.Corner then
            local style=elStyle.Corner
            local corner=Instance.new('UICorner',uielement)
            corner.CornerRadius=UDim.new(style.Radius,0)
        end
    end
end
function display(ty,ti,configs)
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
        uielement.Name=configs.Name or 'WINDOW_'
        uielement.BackgroundTransparency=configs.BGTrans or 1
        uielement.BackgroundColor3=configs.BGC3 or Color3.new(1,1,1)
        uielement.Position=configs.Position or UDim2.new(0,0,0,0)
        uielement.AnchorPoint=configs.AnchorPoint or Vector2.new(0,0)
        if configs.elStyle then
            style(uielement,configs.elStyle)
        end
        if configs.childElements then
            buildElementTree(uielement,configs.childElements)
        end
    end
    if ty=='frame' then
        local uielement = Instance.new('Frame',baseui)
        uielement.Name=configs.Name or 'FRAME_'
        uielement.BackgroundTransparency=configs.BGTrans or 1
        uielement.BackgroundColor3=configs.BGC3 or Color3.new(1,1,1)
        uielement.Position=configs.Position or UDim2.new(0,0,0,0)
        uielement.AnchorPoint=configs.AnchorPoint or Vector2.new(0,0)
        if configs.elStyle then
            style(uielement,configs.elStyle)
        end
        if configs.childElements then
            buildElementTree(uielement,configs.childElements)
        end
    end
end
function start()
    score=0
    
end

