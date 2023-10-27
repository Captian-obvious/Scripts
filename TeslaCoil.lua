local plr = owner
local arc = fromurl('Scripts/Modules/arc.lua')()
local uiHandler = fromurl('Scripts/Modules/UI/init.lua')()
local configs = fromurl('Scripts/Modules/TeslaCoil/arcConfig.lua')()
local arcParams = nil
local isInitialized = false
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
function pulse(numArcs,startpos,range)
    if isInitialized~=true then
        warn('SSTC: Module Not Initialized! Initialize the module before using its functions!')
    else
        for i=1,numArcs do
            local dir = Vector3.new(math.random(-180,180),math.random(0,90),math.random(-180,180)).Unit * range
            local result = Raycast(startpos,dir,{plr.Character})
            local pos = result.Position
            local dist = result.Distance
            local arcInstance = arc.new(plr.Character,1,{ArcColor3=electricBlue,Position1=startpos,Position2=pos,Segments=getSegFromDist(dist),Offset=getOfsFromDist(dist)})
            spawn(function()
                task.wait(arcLifetime)
                arcInstance:Destroy()
            end)
        end
    end
end
