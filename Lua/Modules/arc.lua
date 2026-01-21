local arc = {}
--h
function intToOffset(int)
    local multiplier = 1000
    local minmath = -int * multiplier
    local maxmath = int * multiplier
    local e = math.random(minmath,maxmath)
    local e2 = math.random(minmath,maxmath)
    local e3 = math.random(minmath,maxmath)
    local v = Vector3.new(e/multiplier,e2/multiplier,e3/multiplier)
    return v
end


function distToWidth(dist)
    local multipler = dist / 1000
    local width = 3 * multipler
    return width
end

function arc.new(parent,n1,props)
    local n2 = props.Segments
    local pos1 = props.Position0
    local pos2 = props.Position1
    local arcDist = (pos2-pos1).magnitude
    local arcWidth = props.ArcWidth or distToWidth(arcDist)
    local id=props.HitSoundId or '5501819954'
    local color = props.ArcColor3 or Color3.new(0.035294, 0.537254, 0.811764)
    local soundId = 'rbxassetid://'..id
    local arcGroup = Instance.new('Model', parent)
    arcGroup.Name = 'ArcInstance'
    if pos2~=nil then
        local direction = (pos2-pos1).Unit * arcDist
        local ray = Ray.new(pos1,direction)
        local ignoreList = {}
        if props.ignoreParts then
            ignoreList = props.ignoreParts
        end
        table.insert(ignoreList,arcGroup)
        local hitPart,pos = workspace:FindPartOnRayWithIgnoreList(ray,ignoreList)
        local func = props.Hit
        if hitPart and hitPart.Parent then
            if func then
                func(hitPart)
            end
        end
        arcDist = (pos - pos1).magnitude
        local gl = Instance.new('Part')
        gl.Name = 'center'
        gl.Parent = arcGroup
        gl.Transparency = 1
        gl.Anchored = true
        gl.CanCollide = false
        gl.Color = Color3.new(0,0,0)
        P = gl
        local Hit = CFrame.new(pos)
        local oldHit
        if arcDist > 2048 then
            gl.Size = Vector3.new(1,1,2048)
            gl.CFrame = CFrame.new(pos1,pos) * CFrame.new(0, 0, -arcDist/2)
        else
            gl.Size = Vector3.new(1,1,arcDist)
            gl.CFrame = CFrame.new(pos,pos1) * CFrame.new(0, 0, -arcDist/2)
        end
        local Place0 = CFrame.new(pos1)
        local function getEmitterSize()
            local mag1 = (Place0.p - Hit.Position).magnitude
            if mag1 > 10 then
                return mag1/2
            else
                return 10
            end
        end
        local sfx = Instance.new('Sound', P)
        sfx.EmitterSize = getEmitterSize()
        sfx.SoundId = soundId
        sfx.Name = 'Spark'
        sfx.Volume = 2
        sfx:Play()
        spawn(function()
            for c1 = 1, n1 do
                oldHit = CFrame.new(pos1)
                for count = 1, math.floor(n2) do
                    local dist = (P.Size.z < 2048) and P.Size.z or arcDist
                    val1 = intToOffset(props.Offset or 1)
                    val2 = dist / n2
                    val3 = P.CFrame.lookVector * -1
                    val4 = count * val2
                    val5 = val4 * val3
                    val6 = pos1
                    Hit = CFrame.new(val5 + val1 + val6)
                    local s = Instance.new('Beam')
                    s.Name = 'ArcPart'..count
                    s.Parent = arcGroup
                    local Place0 = oldHit
                    local m2 = (Place0.p - Hit.p).magnitude
                    s.Width0=arcWidth
                    s.Width1=arcWidth
                    s.FaceCamera = true
                    s.LightInfluence = 0
                    s.Brightness = 10
                    local attach1 = Instance.new('Attachment',gl)
                    attach1.WorldCFrame = Hit
                    attach1.Name = 'A1_'..count
                    local attach2 = Instance.new('Attachment',gl)
                    attach2.WorldCFrame = Place0
                    attach2.Name = 'A0_'..count
                    s.Attachment0=attach2
                    s.Attachment1=attach1
                    s.Color = ColorSequence.new(color)
                    s.Transparency = NumberSequence.new(0)
                    --[[s.TopSurface = Enum.SurfaceType.Smooth
                    s.BottomSurface = Enum.SurfaceType.Smooth
                    s.Size = Vector3.new(arcWidth,arcWidth,m2)
                    s.CFrame = CFrame.new((Place0.p + Hit.p)/2,Place0.p)
                    s.Color = color
                    s.Parent = arcGroup
                    s.Material = Enum.Material.Neon
                    s.Anchored = true
                    s.CanCollide = false
                    --]]
                    oldHit = Hit
                end
                Hit = oldHit
                local Place0 = CFrame.new(pos)
                local s = Instance.new('Beam')
                s.Name = 'ArcPartEND'
                local m2 = (Place0.p - Hit.p).magnitude
                s.Parent = arcGroup
                s.Width0=arcWidth
                s.Width1=arcWidth
                s.LightInfluence = 0
                s.Brightness = 10
                s.FaceCamera = true
                local attach1 = Instance.new('Attachment',gl)
                attach1.WorldCFrame = Hit
                attach1.Name = 'A1_END'
                local attach2 = Instance.new('Attachment',gl)
                attach2.WorldCFrame = Place0
                attach2.Name = 'A0_END'
                s.Attachment0=attach2
                s.Attachment1=attach1
                s.Color = ColorSequence.new(color)
                s.Transparency = NumberSequence.new(0)
                --s.TopSurface = Enum.SurfaceType.Smooth
                --s.BottomSurface = Enum.SurfaceType.Smooth
                --s.Size = Vector3.new(arcWidth,arcWidth,m2)
                --s.CFrame = CFrame.new((Place0.p + Hit.p)/2,Place0.p)
                --s.Parent = arcGroup
                --s.Color = color
                --s.Material = Enum.Material.Neon
                --s.Anchored = true
                --s.CanCollide = false
          
                wait(0.3)
            end
        end)
    end
    return arcGroup
end

return arc
