local mediaPlayer=require(id)
function e()
    local printerScript =NLS("print('MediaPlayer Script Loaded!')",script.Player.Value.Name,true)
    task.wait(1)
    printerScript:Destroy()
end
mediaPlayer:Fire(script.Player.Value.Name,128)
