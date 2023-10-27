local plr = owner
local arc = fromurl('Scripts/Modules/Arc.lua')()
local uiHandler = fromurl('Scripts/Modules/UI/init.lua')()
local arcParams = fromurl('Scripts/Modules/TeslaCoil/arcConfig.lua')()
function init()
    local hat = require(id)
    hat.Parent = plr.Character
end
function pulse()
    local arcInstance = arc.new(plr.Character,arcParams)
end
