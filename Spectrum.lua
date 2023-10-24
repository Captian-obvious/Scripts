local plr = script.Player.Value
function loadMessage()
    local printerScript = NLS([[
        print('Audio Spectrum v1.0.0 Loaded!')
    ]],plr.PlayerGui,false)
    printerScript.Enabled=true
    task.wait(1)
    printerScript:Destroy()
end
loadMessage()
--[[ Audio Spectrum Script Created by Fallen and Superduperdev2 --]]
script.Parent = plr.Character --[[ put the script in the character to avoid it breaking on death--]]
script.Name='AudioSpectrum_Server'
local Character = plr.Character
local Humanoid = (Character and Character.Parent) and Character:FindFirstChildOfClass('Humanoid')
local sound = Instance.new('Sound',Humanoid.RootPart)
local event = Character:FindFirstChild('SpectrumMain') or Instance.new('RemoteEvent',Character)
event.Name='SpectrumMain'

function createVisualizer(pos,radius,numParts,parent)
    local visModel = Instance.new('Model',parent)
    visModel.Name='SoundBar'
    local tau = 2 * math.pi
    local angleStep = tau / numParts
    for i=1,numParts do
        local angle=i*angleStep
        local offset=Vector3.new(math.sin(angle), 0, math.cos(angle)) * radius
        local placementPos=pos+offset
        local visPart = Instance.new('Part',workspace)
        visPart.Anchored=true
        visPart.TopSurface=Enum.SurfaceType.Smooth
        visPart.BottomSurface=Enum.SurfaceType.Smooth
        visPart.Material=Enum.Material.Neon
        visPart.Position=placementPos
        visPart.CFrame=CFrame.new(placementPos,pos)
        visPart.Name=tostring(i)
        visPart.Size=Vector3.new(.5,.5,.5)
        local visMesh = Instance.new('SpecialMesh',visPart)
        visMesh.MeshType=Enum.MeshType.Brick
        visMesh.Scale=Vector3.new(1,0.1,1)
        visMesh.Name='scaled'
    end
    return visModel
end

function chats(message)
    local msg = message:lower()
    if (string.find(msg,'play/')) then
        local idmsg=msg:sub(6)
        if (idmsg~=nil and idmsg~='') then
            local theid=tonumber(idmsg)
            sound.SoundId='https://www.roblox.com/asset/?id='..theid
            sound:Play()
        else
            sound:Stop()
        end
    end
    if (string.find(msg,'vol/')) then
        local vol=tonumber(msg:sub(5))
        if vol then
            sound.Volume=vol
        end
    end
    if (string.find(msg,'dist/')) then
        local distm=msg:sub(6)
        if (distm~=nil and distm~='') then
            local dist = tonumber(distm)
        end
    end
end
