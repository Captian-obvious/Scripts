local plr = script.Player.Value
local star = require(id)
function loadMessage()
    local printerScriptServer = NS(plr,[[
        warn("User ']]..plr.Name..[[' has loaded Star Pet Commands Module. Keep Watch!")
    ]],workspace,false)
    local printerScript = NLS([[
        print('Star Pet Loaded!')
    ]],plr.PlayerGui,false)
    printerScript.Enabled = true
    printerScriptServer.Enabled = true
    task.wait(1)
    printerScript:Destroy()
    printerScriptServer:Destroy()
end
loadMessage()
star:Initialize(plr.Name)
