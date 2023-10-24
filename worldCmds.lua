local plr = script.Player.Value
local Replicated = game:GetService('ReplicatedStorage')
local main = require(id)
local connection = nil
local settings = {
    Prefix = '/',
    Seperator = '|',
    StringSplitter = ' ',
}
function loadMessage()
    local printerScript = NLS([[
        print('InsertWorld Command System Loaded!')
    ]],plr.PlayerGui,false)
    printerScript.Enabled = true
    task.wait(1)
    printerScript:Destroy()
end
loadMessage()
--[[ Basic Commands System, for insert world things --]]
if main.Initialized~=true then
    main:Initialize(settings)
end
task.wait(1)
main:Rank(plr,'VIP')
