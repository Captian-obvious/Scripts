local Players=game:GetService('Players')
local Replicated=game:GetService('ReplicatedStorage')
local io = fromurl('Scripts/Modules/io.lua')()
local plr = owner
local score=0
function createElement(parent,ty,configs)
    if ty=='frame' then
        local uielement = Instance.new('Frame',parent)
        uielement.Name=configs.Name or 'FRAME_'
        uielement.BackgroundTransparency=configs.BGTrans or 1
        uielement.BackgroundColor3=configs.BGC3 or Color3.new(1,1,1)
        uielement.Position=configs.Position or UDim2.new(0,0,0,0)
        uielement.AnchorPoint=configs.AnchorPoint or Vector2.new(0,0)
        uielement.Size = configs.Size or UDim2.new(0,100,0,100)
        if configs.elStyle then
            style(uielement,configs.elStyle)
        end
        if configs.childElements then
            buildElementTree(uielement,configs.childElements)
        end
        return uielement
    end
    if ty=='label_text' then
        local uielement = Instance.new('TextLabel',parent)
        uielement.Name=configs.Name or 'LTEXT_'
        uielement.BackgroundTransparency=configs.BGTrans or 1
        uielement.BackgroundColor3=configs.BGC3 or Color3.new(1,1,1)
        uielement.Position=configs.Position or UDim2.new(0,0,0,0)
        uielement.AnchorPoint=configs.AnchorPoint or Vector2.new(0,0)
        uielement.TextColor3=configs.TC3 or Color3.new(0,0,0)
        uielement.TextTransparency=configs.TT or 0
        uielement.TextSize=configs.TSize or 14
        uielement.Text = configs.Text or 'Label'
        uielement.RichText=configs.RT or true
        uielement.TextScaled=configs.TS or false
        if configs.elStyle then
            style(uielement,configs.elStyle)
        end
        if configs.childElements then
            buildElementTree(uielement,configs.childElements)
        end
        return uielement
    end
    if ty=='label_img' then
        local uielement = Instance.new('ImageLabel',parent)
        uielement.Name=configs.Name or 'LIMAGE_'
        uielement.BackgroundTransparency=configs.BGTrans or 1
        uielement.BackgroundColor3=configs.BGC3 or Color3.new(1,1,1)
        uielement.Position=configs.Position or UDim2.new(0,0,0,0)
        uielement.AnchorPoint=configs.AnchorPoint or Vector2.new(0,0)
        uielement.ImageColor3=configs.IC3 or Color3.new(0,0,0)
        uielement.ImageTransparency=configs.IT or 0
        uielement.Image = configs.Image or 'rbxasset://textures/imagePlaceholder.png'
        uielement.HoverImage = configs.HImage or ''
        uielement.PressedImage = configs.PImage or ''
        if configs.elStyle then
            style(uielement,configs.elStyle)
        end
        if configs.childElements then
            buildElementTree(uielement,configs.childElements)
        end
        return uielement
    end
    if ty=='button_text' then
        local uielement = Instance.new('TextLabel',parent)
        uielement.Name=configs.Name or 'BTEXT_'
        uielement.BackgroundTransparency=configs.BGTrans or 1
        uielement.BackgroundColor3=configs.BGC3 or Color3.new(1,1,1)
        uielement.Position=configs.Position or UDim2.new(0,0,0,0)
        uielement.AnchorPoint=configs.AnchorPoint or Vector2.new(0,0)
        uielement.TextColor3=configs.TC3 or Color3.new(0,0,0)
        uielement.TextTransparency=configs.TT or 0
        uielement.Text = configs.Text or 'Label'
        uielement.TextSize=configs.TSize or 14
        uielement.RichText=configs.RT or true
        uielement.TextScaled=configs.TS or false
        if configs.elStyle then
            style(uielement,configs.elStyle)
        end
        if configs.childElements then
            buildElementTree(uielement,configs.childElements)
        end
        return uielement
    end
    if ty=='button_img' then
        local uielement = Instance.new('ImageLabel',parent)
        uielement.Name=configs.Name or 'BIMAGE_'
        uielement.BackgroundTransparency=configs.BGTrans or 1
        uielement.BackgroundColor3=configs.BGC3 or Color3.new(1,1,1)
        uielement.Position=configs.Position or UDim2.new(0,0,0,0)
        uielement.AnchorPoint=configs.AnchorPoint or Vector2.new(0,0)
        uielement.ImageColor3=configs.IC3 or Color3.new(0,0,0)
        uielement.ImageTransparency=configs.IT or 0
        uielement.Image = configs.Image or 'rbxasset://textures/imagePlaceholder.png'
        uielement.HoverImage = configs.HImage or ''
        uielement.PressedImage = configs.PImage or ''
        if configs.elStyle then
            style(uielement,configs.elStyle)
        end
        if configs.childElements then
            buildElementTree(uielement,configs.childElements)
        end
        return uielement
    end
end
function buildElementTree(parent,ch)
    if parent~=nil and (ch~=nil and ch~={}) then
        for c,v in pairs(ch) do
            if v~=nil then
                task.spawn(function()
                    createElement(parent,v.ElementType,v.Config)
                end)
            end
        end
    end
end
function style(uielement,elStyle)
    if elStyle then
        if uielement.Name:find('WINDOW') and elStyle.CloseButton then
            local style=elStyle.CloseButton
            if style.Value==true then
                local button = Instance.new('TextButton',uielement)
                button.AnchorPoint=Vector2.new(1,0)
                button.Position=UDim2.new(1,0,0,0)
                button.Size=style.Size or UDim2.new(.1,0,.1,0)
                button.TextColor3=style.Color or Color3.new(1,0,0)
                button.Text='X'
                button.Name='Close'
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
    clButton.TextScaled=true
    clButton.RichText=true
    clButton.BackgroundTransparency=1
    clButton.MouseButton1Click:Connect(function()
        if baseui and baseui.Parent then
            baseui:Destroy()
        end
    end)
    local clRatio = clButton:FindFirstChild('ratio') or Instance.new('UIAspectRatioConstraint',clButton)
    clRatio.Name='ratio'
    clRatio.AspectRatio=1
    if ty=='msg' or ty=='text' then
        
    elseif ty=='window' then
        local uielement = Instance.new('Frame',baseui)
        uielement.Name=configs.Name or 'WINDOW_'
        uielement.BackgroundTransparency=configs.BGTrans or 1
        uielement.BackgroundColor3=configs.BGC3 or Color3.new(1,1,1)
        uielement.Position=configs.Position or UDim2.new(0,0,0,0)
        uielement.AnchorPoint=configs.AnchorPoint or Vector2.new(0,0)
        uielement.Size=configs.Size or UDim2.new(0,100,0,100)
        if configs.elStyle then
            style(uielement,configs.elStyle)
        end
        if configs.childElements then
            buildElementTree(uielement,configs.childElements)
        end
        return uielement
    else
        local uielement = createElement(theui,ty,configs)
        return uielement
    end
end
function Initialize()
    window=display('window',1,
        {
            Name='WINDOW_MAIN',
            BGTrans=0,
            BGC3 = Color3.fromRGB(85,0,0),
            Position = UDim2.new(.5,0,.5,0),
            AnchorPoint = Vector2.new(.5,.5),
            Size=UDim2.new(1,-2,1,-2),
            elStyle={
                Stroke={
                    Color=Color3.new(1,0,0),
                    Thickness=4,
                    JoinMode=Enum.LineJoinMode.Bevel,
                },
            },
            childElements={
                {
                    ElementType='frame',
                    Config = {
                        Name='WINDOW_HUD',
                        BGTrans=0,
                        BGC3 = Color3.fromRGB(85,0,0),
                        Position = UDim2.new(.5,0,.5,0),
                        AnchorPoint = Vector2.new(.5,.5),
                        Size=UDim2.new(.3,-2,.3,-2),
                        elStyle={
                            Stroke={
                                Color=Color3.new(1,0,0),
                                Thickness=4,
                                JoinMode=Enum.LineJoinMode.Round,
                            },
                            AspectRatio={
                                Value=1/2,
                            },
                        },
                        childElements={
                            {
                                ElementType='button_text',
                                Config={
                                    Name='',
                                },
                            },
                        },
                    },
                },
                {
                    ElementType='label_text',
                    Config = {
                        Name='Title',
                        BGTrans=1,
                        BGC3 = Color3.fromRGB(85,0,0),
                        Position = UDim2.new(0,0,0,0),
                        AnchorPoint = Vector2.new(0,0),
                        Size=UDim2.new(1,-2,.1,0),
                        TC3=Color3.new(1,0,0),
                        TSize=20,
                        Text='Relay Replacer',
                        TS=true,
                        RT=true,
                    },
                },
            },
        }
    )
end
function level1()
    score=0
    relays=5
    broken=10
    replaced=0
    shipmentTine=20
    while broken>0 do
        keypress=io.awaitKeypress()
        if (keypress==true) then
            --[[ print('Relay replaced!')--]]
            score=score+1
            replaced=replaced+1
            
        end
    end
end
function start()
    score=0
    
end

