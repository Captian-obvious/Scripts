local event = script:FindFirstChild('Keypress') or Instance.new('BindableEvent',script)
event.Name='Keypress'
local io = {
    Keypress = event.Event,
}

function io:Initialize()

end

function io:awaitKeypress(key)
    local plr,pressed = io.Keypress:Wait()
    if plr~=nil then
        if pressed==key then
            return plr,pressed
        else
            io:awaitKeypress(key)
        end
    end
end

return io
