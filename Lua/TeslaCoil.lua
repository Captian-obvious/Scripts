local plr = owner
local arc = fromurl('Scripts/Lua/Modules/arc.lua')()
local io = fromurl('Scripts/Lua/Modules/io.lua')()
--local uiHandler = fromurl('Scripts/Modules/UI/init.lua')()
--local configs = fromurl('Scripts/Modules/TeslaCoil/arcConfig.lua')()
local arcParams = nil
local isInitialized = false
local arcLifetime = .05
local dmg = 8
function Raycast(pos,direction,ignore)
    local params = RaycastParams.new()
    params.FilterType=Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances=ignore or {}
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
    return data
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
function targetArc(startpos,range,ogPos)
    local dir = (ogPos - startpos).Unit * range
    local result = Raycast(startpos,dir,{plr.Character})
    local pos = result.Position
    local dist = result.Distance
    local hit = result.Instance
    if hit~=nil then
        local h = hit.Parent:FindFirstChildOfClass('Humanoid')
        if h~=nil then
            h:TakeDamage(dmg)
        end
    end
    local arcInstance = arc.new(plr.Character,1,{ArcColor3=Color3.new(0.0352941, 0.537255, 0.811765),Segments=getSegFromDist(dist),Offset=getOfsFromDist(dist),Position0=startpos,Position1=pos,ignoreParts={plr.Character}})
    spawn(function()
        task.wait(arcLifetime)
        arcInstance:Destroy()
    end)
end
function pulse(startpos,range,numArcs)
    if isInitialized~=true then
        warn('SSTC: Module Not Initialized! Initialize the module before using its functions!')
    else
        if (findTarget(startpos,range,{plr.Character})~=nil) then
            local targetData = findTarget(startpos,range,{plr.Character})
            if targetData.part~=nil then
                local ogPos = targetData.part.Position
                targetArc(startpos,range,ogPos)
            elseif targetData.hum ~= nil and targetData.part~=nil and targetData.char~=nil then
                local ogPos = targetData.part.Position
                targetArc(startpos,range,ogPos)
            else
                normArc(startpos,range,numArcs)
            end
        else
            normArc(startpos,range,numArcs)
        end
    end
end
local sstc = {}
function sstc:Init()
    if isInitialized~=true then
        local function weld(Part0, Part1)
    		local C1 = Part1.CFrame:inverse()*CFrame.new(Part0.Position)
    		local C0 = Part0.CFrame:inverse()*CFrame.new(Part0.Position)
    		local Weld = Instance.new("ManualWeld", Part0)
    		Weld.Part0 = Part0
    		Weld.Part1 = Part1
    		Weld.C0 = C0
    		Weld.C1 = C1
    	end
        local hat = require(15189106230).Hat:Clone()
        hat.Parent = plr.Character
        local cf = plr.Character.Head.CFrame * CFrame.new(0,2.225,0)
        hat:SetPrimaryPartCFrame(cf)
        weld(hat.root,plr.Character.Head)
        isInitialized = true
    else
        warn('SSTC: Module Already Initialized!')
    end
end
function sstc:pulseOutput(range,damage)
    if isInitialized~=true then
        warn('SSTC: Module Not Initialized! Initialize the module before using its functions!')
    else
        dmg = damage or 8
        range = range or 12
        local hat = plr.Character:FindFirstChild('hat')
        if hat~=nil then
            local Topload = hat:WaitForChild('tower'):FindFirstChild('topload')
            if Topload then
                b = Topload:FindFirstChild('breakout')
                if b~=nil then
                    local pos = b.WorldPosition
                    pulse(pos,range,math.random(3,4))
                end
            end
        end
    end
end
function sstc:cWave(range,ti,dps)
    if isInitialized~=true then
        warn('SSTC: Module Not Initialized! Initialize the module before using its functions!')
    else
        local deltaTime=0
        local st=0
        local thedmg=0
        while deltaTime<ti do
            t=task.wait()
            deltaTime=deltaTime+t
            st=st+t
            if st>1 then
                thedmg=dps
                st=0
            end
            if deltaTime<ti then 
                sstc:pulseOutput(range,thedmg)
            end
        end
        deltaTime=0
    end
end
function sstc:fire(ty,configs)
    if isInitialized~=true then
        warn('SSTC: Module Not Initialized! Initialize the module before using its functions!')
    else
        if ty=='pulsed' then
            local ti = configs.TBP or .15
            local times = configs.Times or 20
            local damage = configs.Damage or 8
            local range=configs.Range or 20
            for i=1,times do
                sstc:pulseOutput(range,damage)
                wait(ti)
            end
        elseif ty=='constant' then
            local ti=configs.Time or 10
            local dps=configs.Damage or 8
            local range=configs.Range or 20
            sstc:cWave(range,ti,dps)
        end
    end
end
return sstc
