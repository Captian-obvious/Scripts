local module={}
function module:Init()
    if (module.Initialized~=true) then
        module.Initialized=true
    else
        warn('RBXAUDIO: Module already initialized!')
    end
end
return module
