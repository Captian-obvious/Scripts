local plr = script.Player.Value
function loadMessage()
    local printerScript = NLS([[
        print('Audio Spectrum v1.0.0 Loaded!')
    ]],plr.PlayerGui,false)
    printerScript.Enabled=true
    task.wait(1)
    printerScript:Destroy()
end
loadMessage()
--[[ Audio Spectrum Script Created by Fallen and Superduperdev2 --]]
script.Parent = plr.Character --[[ put the script in the character to avoid it breaking on death--]]
script.Name='AudioSpectrum_Server'
local Character = plr.Character
local Humanoid = (Character and Character.Parent) and Character:FindFirstChildOfClass('Humanoid')
local sound = Instance.new('Sound',Humanoid.RootPart)
local event = Character:FindFirstChild('SpectrumMain') or Instance.new('RemoteEvent',Character)
event.Name='SpectrumMain'

function createVisualizer(radius,parent)
    
end


