script.Parent=workspace;
script.Name="Gate";
local msg = require(10638367095)
local cameraShake = require(11958971616)
function makeHint()
    local timerHint = Instance.new('ScreenGui', script)
    timerHint.Name = 'h'
    local hintFrame = Instance.new('Frame', timerHint)
    hintFrame.Size = UDim2.new(1,0,0.04,0)
    hintFrame.Position = UDim2.new(0.5,0,0,0)
    hintFrame.AnchorPoint = Vector2.new(0.5,0)
    hintFrame.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
    hintFrame.BackgroundTransparency = 0.7
    hintFrame.Name = 'f'
    local h = Instance.new('TextLabel', hintFrame)
    h.Size = UDim2.new(1,-10,1,-10)
    h.Position = UDim2.new(0.5,0,0.5,0)
    h.AnchorPoint = Vector2.new(0.5,0.5)
    h.TextColor3 = Color3.new(1,1,1)
    h.TextScaled = true
    h.BackgroundTransparency = 1
    h.Name = 't'
    return timerHint
end
function makeSound(id,vol,loop,name, pitch)
    pitch = pitch or 1
    local folder = workspace:FindFirstChild('Sounds') or Instance.new('Folder',workspace)
    folder.Name = 'Sounds'
    local s = Instance.new('Sound', folder)
    s.SoundId = id
    s.Volume = vol
    s.Looped = loop
    s.Pitch = pitch
    s.Name = name
    return s
end
function finale()
    local dynamicExplosion = require(11380416673)
    local music = makeSound('rbxassetid://1839246711',1.5,false,'finale')
    local tenToZero = makeSound('rbxassetid://15487574881',1.5,false,'tentozero')
    local kaboom = makeSound('rbxassetid://131026234',1.5,false,'kaboom')
    music:Play()
    task.wait(13)
    tenToZero:Play()
    task.wait(12)
    local r = 2000
    cameraShake:shakeCamera(10,35)
    kaboom:Play()
    local e=dynamicExplosion.new(workspace, {BaseSize=Vector3.new(2,2,2),Position=Vector3.new(0,0,0),Material=Enum.Material.Neon, ExplosionColor3=Color3.new(1,0.5,0),ExplosionOpacity=0.5,DestroyJointRadiusPercent=1,BlastRadius = r, BlastPressure = 60})
    task.wait(65)
    if e~=nil and e.Parent~=nil then
        e:Destroy()
    end
    msg:MakeSystemMessage("all", {Text = [[[Ending]: Reactor exploded, thanks for playing!]], Color = Color3.new(1,0,0), Font = Enum.Font.SourceSansBold,})
end
local startingSound = makeSound('rbxassetid://1846931927',2,false,'meltdownStarting')
local ann1 = makeSound('rbxassetid://1474008656',2,false,'evacatonce')
local ann2 = makeSound('rbxassetid://159445410',2,false,'overheat')
local evac = makeSound('rbxassetid://147296378',2,false,'evac')
local alarm = makeSound('rbxassetid://2451364019',2,true,'alarm')
local ann3 = makeSound('rbxassetid://168877716',2,false,'critical')
local ann4 = makeSound('rbxassetid://147296324',2,false,'safeguards')
local music = makeSound('rbxassetid://1837079563',1.5,false,'music')
local metalexplosion = makeSound('rbxassetid://178962800', 0.5, false, 'metalexplosion')
local shockwave = makeSound('rbxassetid://610327604', 0.5, false, 'shockwave')
local music2 = makeSound('rbxassetid://1838617832',1.5,false,'music2')
local ann5 = makeSound('rbxassetid://5125748780',2,false,'explosion4Minutes')
local music3 = makeSound('rbxassetid://9047520056',1.5,false,'music3')
local ann6 = makeSound('rbxassetid://5125750186', 2, false, 'destroyed')
local ann7 = makeSound('rbxassetid://2807893638', 2, false, 'selfdestruct')
startingSound:Play()
task.wait(55)
ann1:Play()
msg:MakeSystemMessage("all", {Text = [[[DANGER]: Reactor Meltdown, EVACUATE AT ONCE!]], Color = Color3.new(1,0,0), Font = Enum.Font.SourceSansBold,})
task.wait(15)
ann1:Play()
msg:MakeSystemMessage("all", {Text = [[[DANGER]: Reactor Meltdown, EVACUATE AT ONCE!]], Color = Color3.new(1,0,0), Font = Enum.Font.SourceSansBold,})
task.wait(15)
ann2:Play()
msg:MakeSystemMessage("all", {Text = [[[Warning]: Core Overheating, Nuclear Meltdown Imminent.]], Color = Color3.new(1,0,0), Font = Enum.Font.SourceSansBold,})
task.wait(15)
ann2:Play()
msg:MakeSystemMessage("all", {Text = [[[Warning]: Core Overheating, Nuclear Meltdown Imminent.]], Color = Color3.new(1,0,0), Font = Enum.Font.SourceSansBold,})
task.wait(15)
evac:Play()
msg:MakeSystemMessage("all", {Text = [[[Warning]: Please prepare for emergency evacuation.]], Color = Color3.new(1,0,0), Font = Enum.Font.SourceSansBold,})
alarm:Play()
task.wait(10)
alarm:Stop()
task.wait(15)
ann3:Play()
msg:MakeSystemMessage("all", {Text = [[[Warning]: Reactor Core is at critical temp^@%*]], Color = Color3.new(1,0,0), Font = Enum.Font.SourceSansBold,})
task.wait(15)
ann4:Play()
msg:MakeSystemMessage("all", {Text = [[[Warning]: All Reactor Core Safeguards are now nonfunctional, Please prepare for reactor core meltdown.]], Color = Color3.new(1,0,0), Font = Enum.Font.SourceSansBold,})
task.wait(5)
msg:MakeSystemMessage("all", {Text = [[{MELTDOWN IMMINENT}]], Color = Color3.new(1,0,0), Font = Enum.Font.SourceSansBold,})
task.wait(2)
evac:Play()
msg:MakeSystemMessage("all", {Text = [[[Warning]: Please prepare for emergency evacuation.]], Color = Color3.new(1,0,0), Font = Enum.Font.SourceSansBold,})
alarm:Play()
task.wait(10)
alarm:Stop()
task.wait(15)
ann1:Play()
msg:MakeSystemMessage("all", {Text = [[[DANGER]: Reactor Meltdown, EVACUATE AT ONCE!]], Color = Color3.new(1,0,0), Font = Enum.Font.SourceSansBold,})
task.wait(30)
music:Play()
task.wait(30)
ann1:Play()
msg:MakeSystemMessage("all", {Text = [[[DANGER]: Reactor Meltdown, EVACUATE AT ONCE!]], Color = Color3.new(1,0,0), Font = Enum.Font.SourceSansBold,})
task.wait(10)
metalexplosion:Play()
cameraShake:shakeCamera(3,35)
task.wait(1)
shockwave:Play()
task.wait(9)
evac:Play()
msg:MakeSystemMessage("all", {Text = [[[Warning]: Please prepare for emergency evacuation.]], Color = Color3.new(1,0,0), Font = Enum.Font.SourceSansBold,})
task.wait(10)
alarm:Play()
task.wait(10)
alarm:Stop()
task.wait(10)
ann3:Play()
msg:MakeSystemMessage("all", {Text = [[[Warning]: Reactor Core is at critical temp^@w6]], Color = Color3.new(1,0,0), Font = Enum.Font.SourceSansBold,})
task.wait(30)
evac:Play()
msg:MakeSystemMessage("all", {Text = [[[Warning]: Please prepare for emergency evacuation.]], Color = Color3.new(1,0,0), Font = Enum.Font.SourceSansBold,})
alarm:Play()
task.wait(10)
alarm:Stop()
task.wait(19)
music2:Play()
task.wait(15)
ann1:Play()
msg:MakeSystemMessage("all", {Text = [[[DANGER]: Reactor Meltdown, EVACUATE AT ONCE!]], Color = Color3.new(1,0,0), Font = Enum.Font.SourceSansBold,})
task.wait(15)
evac:Play()
msg:MakeSystemMessage("all", {Text = [[[Warning]: Please prepare for emergency evacuation.]], Color = Color3.new(1,0,0), Font = Enum.Font.SourceSansBold,})
task.wait(5)
ann5:Play()
msg:MakeSystemMessage("all", {Text = [[[Warning]: Reactor Explosion in 4 Minutes.]], Color = Color3.new(1,0,0), Font = Enum.Font.SourceSansBold,})
task.wait(5)
evac:Play()
msg:MakeSystemMessage("all", {Text = [[[Warning]: Please prepare for emergency evacuation.]], Color = Color3.new(1,0,0), Font = Enum.Font.SourceSansBold,})
task.wait(5)
alarm:Play()
task.wait(10)
alarm:Stop()
task.wait(10)
ann3:Play()
msg:MakeSystemMessage("all", {Text = [[[Warning]: Reactor Core is at critical temp^@w6]], Color = Color3.new(1,0,0), Font = Enum.Font.SourceSansBold,})
task.wait(73)
shockwave:Play()
cameraShake:shakeCamera(3,35)
music3:Play()
task.wait(5)
evac:Play()
msg:MakeSystemMessage("all", {Text = [[[Warning]: Please prepare for emergency evacuation.]], Color = Color3.new(1,0,0), Font = Enum.Font.SourceSansBold,})
task.wait(5)
alarm:Play()
task.wait(10)
alarm:Stop()
task.wait(10)
ann3:Play()
msg:MakeSystemMessage("all", {Text = [[[Warning]: Reactor Core is at critical temp^@w6]], Color = Color3.new(1,0,0), Font = Enum.Font.SourceSansBold,})
task.wait(38)
ann6:Play()
msg:MakeSystemMessage("all", {Text = [[[Warning]: Reactor Explosion timer !DESTROYED!]], Color = Color3.new(1,0,0), Font = Enum.Font.SourceSansBold,})
task.wait(5)
ann7:Play()
msg:MakeSystemMessage("all", {Text = [[[Warning]: Reactor Explosion Uncertainty Emergency Preemption Protocol initiated, this facility will self destruct in 2 minutes.]], Color = Color3.new(1,0,0), Font = Enum.Font.SourceSansBold,})
task.wait(7)
local timer = 120
local timerHint = makeHint()
timerHint.f.t.Text ='Explosion in: '..timer
for _,plr in pairs(game:GetService('Players'):GetPlayers()) do
    if plr then
        local gui = timerHint:Clone()
        gui.Parent = plr.PlayerGui
        game:GetService('Debris'):AddItem(gui, 0.99)
    end
end
for i=1,timer do
    local ct = timer - i
    timerHint.f.t.Text ='Explosion in: '..ct
    if ct == 24 or timerHint.f.t.Text == 'Explosion in: 24' then
        music3:Stop()
        task.spawn(function()
            finale()
        end)
    end
    for _,plr in pairs(game:GetService('Players'):GetPlayers()) do
        if plr then
            local gui = timerHint:Clone()
            gui.Parent = plr.PlayerGui
            game:GetService('Debris'):AddItem(gui, 0.99)
        end
    end
    if ct == 10 or timerHint.f.t.Text == 'Explosion in: 10' then
        break
    end
    task.wait(1)
end;