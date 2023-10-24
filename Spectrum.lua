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
local light=nil

function toboolean(val)
    if val:lower()=='t' or val:lower()=='true' or val:lower()=='tr' or val:lower()=='tru' or tonumber(val)==1 then
        return true
    else
        return false
    end
end

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
    if (string.sub(msg,1,5):find('play/')) then
        local theid=tonumber(msg:sub(6))
        if (theid~=nil) then
            sound.SoundId='https://www.roblox.com/asset/?id='..theid
            sound:Play()
        else
            sound:Stop()
        end
    end
    if (string.sub(msg,1,4):find('vol/')) then
        local vol=tonumber(msg:sub(5))
        if (vol~=nil) then
            sound.Volume=vol
        end
    end
    if (string.sub(msg,1,7):find('height/')) then
        local dist = tonumber(msg:sub(8))
        if (dist~=nil) then
            maxHeight = dist
        end
    end
    if (string.sub(msg,1,6):find('style/')) then
        local styleflag = msg:sub(7)
        if (string.sub(styleflag,1,4):find('mat/')) then
            local material = styleflag:sub(5)
            if Enum.Material[material] then
                visMaterial = Enum.Material[material]
            else
                
            end
        end
    end
    if (string.sub(msg,1,6):find('light/')) then
        local flag = msg:sub(7)
        if (toboolean(flag)==true) then
            light = Instance.new('PointLight',Humanoid.RootPart)
            light.Range=20
            light.Brightness=1
            light.Color=Color3.fromRGB(255,245,204)
            light.Shadows = true --[[ Dynamic lights bc yes --]]
            light.Name='VisualizerLight'
        else
            light = Humanoid.RootPart:FindFirstChild('VisualizerLight')
            if light then
                light:Destroy()
                light = nil
            end
        end
    end
end
