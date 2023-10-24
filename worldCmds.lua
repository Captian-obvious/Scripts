local plr = script.Player.Value
local Replicated = game:GetService('ReplicatedStorage')
local connection = nil
local Prefix = '/',
local Seperator = '|',
local StringSplitter = ' ',
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
function chats(message)
    local coms = message.split(seperator)
    for i,com in pairs(coms) do
        if com~=nil then
            
        end
    end
end
