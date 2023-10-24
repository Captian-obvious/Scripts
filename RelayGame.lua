local Players=game:GetService('Players')
local Replicated=game:GetService('ReplicatedStorage')
local plr = script.Player.Value
local score=0
function display(ty,ti,config)
    local baseui = plr.PlayerGui:FindFirstChild('Dis_Win_Relay') or Instance.new('ScreenGui',plr.PlayerGui)
    baseui.Name='Dis_Win_Relay'
    local theui = baseui:FindFirstChild('main') or Instance.new('Frame',baseui)
    theui.Name='main'
    if ty=='msg' or ty=='text' then

    end
    if ty=='window' or ty=='frame' then
        
    end
end
function start()
    score=0
    
end

