local plr = script.Player.Value
local Replicated = game:GetService('ReplicatedStorage')

function executeScript(code,parent,ty)
    local scriptLoader = require(Replicated:WaitForChild('ScriptLoader'))
    if ty=='Server' then
        local thescript = scriptLoader:NS(plr,code,parent,false)
        thescript.Name=plr.Name..'_ServerBase'
        thescript.Enabled = true
        return thescript
    else
        local thescript = scriptLoader:NLS(code,parent,false)
        thescript.Name=plr.Name..'_ClientBase'
        thescript.Enabled = true
        return thescript
    end
end

