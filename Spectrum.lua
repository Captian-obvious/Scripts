local plr = script.Player.Value
function loadMessage()
    local printerScript = NLS([[
        print('Audio Spectrum v1.0.0 Loaded!')
    ]],plr.PlayerGui,false)
    printerScript.Enabled = true
    task.wait(1)
    printerScript:Destroy()
end
loadMessage()
--[[ Audio Spectrum Script Created by Fallen and Superduperdev2 --]]

