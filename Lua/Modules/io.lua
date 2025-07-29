local event = script:FindFirstChild('Keypress') or Instance.new('BindableEvent',script)
event.Name='Keypress'
local io = {
    Initialized = false,
    Keypress = event.Event,
}

function io:Initialize()
    if io.Initialized~=true then
        io.Initialized = true
    else
        warn('IO Mod: Module already initialized!')
    end
end

function io:awaitKeypress(mouse,key)
    if io.Initialized~=true then
        warn('IO Mod: Module not initialized! Initialize the module before using its functions!')
    else
        mouse.KeyDown:Connect(function(k) 
            event:Fire(owner,k)
        end)
        local plr,pressed = io.Keypress:Wait()
        if plr~=nil then
            if pressed==key then
                return plr,pressed
            else
                io:awaitKeypress(key)
            end
        end
    end
end

return io
