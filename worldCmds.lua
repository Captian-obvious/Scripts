local plr = script.Player.Value
local Replicated = game:GetService('ReplicatedStorage')
local connection = nil
function loadMessage()
    local printerScript = NLS([[
        print('InsertWorld Command System Loaded!')
    ]],plr.PlayerGui,false)
    printerScript.Enabled = true
    task.wait(1)
    printerScript:Destroy()
end
loadMessage()
--[[ Basic Commands idk why I made this. --]]
