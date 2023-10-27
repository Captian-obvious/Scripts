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
function pulse(numArcs,startpos)
    if isInitialized~=true then
        warn('SSTC: Module Not Initialized! Initialize the module before using its functions!')
    else
        for i=1,numArcs do
            local result = Raycast(startpos,dir,plr.Character)
            local arcInstance = arc.new(plr.Character,1,{Position1=pos,Position2=pos2,Segments=getSegFromDist()})
        end
    end
end
