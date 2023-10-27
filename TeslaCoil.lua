local plr = owner
local arc = fromurl('Scripts/Modules/arc.lua')()
local uiHandler = fromurl('Scripts/Modules/UI/init.lua')()
local configs = fromurl('Scripts/Modules/TeslaCoil/arcConfig.lua')()
local arcParams = nil
local isInitialized = false
function init()
    local hat = require(id).Hat:Clone()
    hat.Parent = plr.Character
    local tl = hat:FindFirstChild('topload')
    if tl then
        local pos = tl.Position
        arcParams = configs.Initialize(pos)
    end
end
function pulse(numArcs,pos)
    for i=1,numArcs do
        local result = Raycast(pos,
        local arcInstance = arc.new(plr.Character,1,{Position1=pos,Position2=pos2,Segments=getSegFromDist()})
    end
end

