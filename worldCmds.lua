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
local server = {}
function server:Error(player,str,ti) -- error function
    local ts = game:GetService('TweenService')
    if ti ==nil then
        ti=1
    end
    local info = TweenInfo.new(
        0.5, -- tweeen time
        Enum.EasingStyle.Linear, -- style
        Enum.EasingDirection.Out, -- direction
        0, -- repeat count
        false, -- reverses?
        0 -- delay
    )
    local gui = script.Error:Clone()
    gui.Parent = player.PlayerGui
    gui.Frame.msg.Text = str
    local t = ts:Create(gui.Frame,info,{Position = UDim2.new(.5,0,.5,0),BackgroundTransparency = 0.3})
    t:Play()
    t.Completed:Connect(function(ps)
        if ps == Enum.PlaybackState.Completed then
            wait(ti)
            local t2 = ts:Create(gui.Frame,info,{Position = UDim2.new(.5,0,0,0),BackgroundTransparency = 0.9})
            t2:Play()
            t2.Completed:Connect(function(ps2)
                if ps2 == Enum.PlaybackState.Completed then
                    gui:Destroy()
                end
            end)
        end
    end)
end

function server:ProcessArguments(str,t)
    local args = str:split(server.StringSplitter)
    if args ~= nil then
        local referenceTable = t
        if (referenceTable) and (#referenceTable < #args) then
            for i=#referenceTable+1,#args do
                if args[i] then
                    args[#referenceTable]=args[#referenceTable]..' '..args[i]
                end
            end
        end
    end
    print("Processed args: ", args)
    return args
end

function server:ProcessCommand(player,message)
    local commands = message:split(server.Seperator)
    if commands then
        for _,msg in pairs(commands) do
            if msg~=nil then
                local command = server:GetCommand(msg:lower())
                if command~=nil then
                    local com = command.Command -- gives the server a reference back to the command table
                    local args = command.Args
                    if player:GetAttribute('Rank') >= com.Level then
                        local c = command.Command
                        local f = c.Function
                        local args = server:ProcessArguments(args,c.Args)
                        if args ~= nil then
                            f(player,args)
                        end
                    else
                        server:Error(player,'You do not have permission to run'..msg,5)
                    end
                end
            end
        end
    end
end
