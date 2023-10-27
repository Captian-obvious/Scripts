local plr = owner
local arc = fromurl('Scripts/Modules/arc.lua')()
local uiHandler = fromurl('Scripts/Modules/UI/init.lua')()
local configs = fromurl('Scripts/Modules/TeslaCoil/arcConfig.lua')()
local arcParams = nil
function init()
    local hat = require(id)
    hat.Parent = plr.Character
    arcParams = configs.Initialize(position)
end
function pulse(numArcs,pos)
    for i=1,numArcs do
        local arcInstance = arc.new(plr.Character,1,{Position1=pos,Position2=pos2,Segments=getSegFromDist()})
    end
end

