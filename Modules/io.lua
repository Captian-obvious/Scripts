local event = script:FindFirstChild('Keypress') or Instance.new('BindableEvent',script)
event.Name='Keypress'
local io = {
    Keypress = event.Event
}

function io:awaitKeypress(plr,key)
    local keyPressed = io.Keypress:Wait()
end

return io
