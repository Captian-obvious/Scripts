local plr = owner
local arc = fromurl('Scripts/Modules/arc.lua')()
local uiHandler = fromurl('Scripts/Modules/UI/init.lua')()
local configs = fromurl('Scripts/Modules/TeslaCoil/arcConfig.lua')()
local arcParams = nil
local isInitialized = false
local arcLifetime = .05
function init()
    if isInitialized~=true then
        local hat = require(id).Hat:Clone()
        hat.Parent = plr.Character
        local tl = hat:FindFirstChild('topload')
        if tl then
            local pos = tl.Position
            arcParams = configs.Initialize(pos)
        end
        isInitialized = true
    else
        warn('SSTC: Module Already Initialized!')
    end
end
function Raycast(pos,direction,ignore)
    local params = RaycastParams.new()
    params.FilterType=Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances=ignore
    params.IgnoreWater = true
    local rr = workspace:Raycast(pos,direction,params)
    return rr
end
function findTarget(pos,range,ignore)
    local function getParts(pos,size,ignore)
        ignore = ignore or {}
        local pos1 = pos + Vector3.new(size, size, size)
        local pos2 = pos - Vector3.new(size, size, size)
        local region = Region3.new(pos2, pos1)
        local parts = workspace:FindPartsInRegion3WithIgnoreList(region, ignore, 2000)
        return parts
    end
    local function getDist(pos, part)
        local params = RaycastParams.new()
        params.FilterType=Enum.RaycastFilterType.Exclude
        params.IgnoreWater=true
        params.FilterDescendantsInstances={part}
        local dist = (part.Position - pos).magnitude
        local result = workspace:Raycast(pos, CFrame.new(pos, part.Position).LookVector * dist, params)
        if result then
            dist = result.Distance
        end
        return dist
    end
    local data = {
        char=nil,
        hum=nil,
        part=nil,
    }
    local partsInRadius = getParts(pos, range, ignore)
    for _,v in pairs(partsInRadius) do
        if (v:IsA('BasePart')) then
            local mag = getDist(pos, v)
            --print(v.Name .. " Distance: " .. math.round(mag * 100) / 100)
            if mag <= range then
                local h = v.Parent:FindFirstChildOfClass("Humanoid")
                if h~=nil and h.Health > 0 then
                    local root = h.Parent:FindFirstChild("HumanoidRootPart") or h.Parent:FindFirstChild("Head") or h.Parent:FindFirstChildWhichIsA("BasePart")
                    if root~=nil then
                        print("Found root")
                        data.char = root.Parent
                        data.hum = h
                        data.part = v
                    else
                        --warn("no root")
                        data.part = v
                    end
                elseif data.hum == nil then
                    --warn("no hum")
                    data.part = v
                end
            else
                --warn("too far")
            end
        end
    end
end
function getSegFromDist(dist)
    local ret = 0
    if dist>20 then
        ret = math.floor(dist / 10)
    elseif dist > 10 and dist <= 20 then
        ret = math.floor(dist / 5)
    elseif dist > 5 and dist <=10 then
        ret = math.floor(dist)
    else
        ret = math.floor(dist*2)
    end
    return ret
end
function getOfsFromDist(dist)
    local ret = dist / 100
    if ret < .1 then
        ret = .1
    end
    return ret
end
function normArc(startpos,range,numArcs)
    for i=1,numArcs do
        local dir = Vector3.new(math.random(-180,180),math.random(-180,180),math.random(-180,180))
        local result = Raycast(startpos,dir.Unit * range,{plr.Character})
        local pos = result.Position
        local dist = result.Distance
        local arcInstance = arc.new(plr.Character,1,{ArcColor3=Color3.new(0.0352941, 0.537255, 0.811765),Segments=getSegFromDist(dist),Offset=getOfsFromDist(dist),Position0=startpos,Position1=pos,ignoreParts={plr.Character}})
        spawn(function()
            task.wait(arcLifetime)
            arcInstance:Destroy()
        end)
    end
end
function pulse(startpos,range,numArcs)
    if isInitialized~=true then
        warn('SSTC: Module Not Initialized! Initialize the module before using its functions!')
    else
        if (findTarget(startpos,range,{plr.Character})~=nil) then
            local targetData = findTarget(startpos,range,{plr.Character})
            local ogPos = findTarget(startpos,range,{plr.Character})
            local dir = (ogPos - startPos).Unit * range
            local result = Raycast(startpos,dir,{plr.Character})
            local pos = result.Position
            local dist = result.Distance
            local hit = result.Instance
            if hit~=nil then
                local h = hit.Parent:FindFirstChildOfClass('Humanoid')
                if h~=nil then
                    h:TakeDamage(8)
                end
            end
            local arcInstance = arc.new(plr.Character,1,{ArcColor3=Color3.new(0.0352941, 0.537255, 0.811765),Segments=getSegFromDist(dist),Offset=getOfsFromDist(dist),Position0=startpos,Position1=pos,ignoreParts={plr.Character}})
            spawn(function()
                task.wait(arcLifetime)
                arcInstance:Destroy()
            end)
        else
            normArc(startpos,range,numArcs)
        end
    end
end
