local mediaPlayer=require(10569850047)
function e()
    local printerScript =NLS("print('MediaPlayer Script Loaded!')",script.Player.Value.Name,true)
    task.wait(1)
    printerScript:Destroy()
end
e()
mediaPlayer:Fire(owner.Name,128)
