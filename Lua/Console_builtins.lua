local cmds={
    isInitialized=false,
};

function cmds.initialize(self)
    if not self.isInitialized then
        self.isInitialized=true;

    end;
end;

function cmds.getcmd(self,msg:string)
    local cmd=nil;
    local args=nil;
    local function getCommand(valid,str:string)
        for i,v in pairs(valid) do
            if v and v.Prefix then
                for c,com in pairs(v.Commands) do
                    local cmd = string.split(msg,server.StringSplitter);
                    if cmd[1] and cmd[1] == v.Prefix..com:lower() then
                        thecommand = v;
                        table.remove(cmd, 1);
                        args = table.concat(cmd, server.StringSplitter);
                        warn("Command detected (" .. com .. ")");
                    else
                    --warn("Command not detected (" .. com .. ")")
                    end;
                end;
            else
                warn("Command is nil (" .. i .. " | Cmd Table: " .. tostring(v) .. " | Pre: " .. tostring(v.Prefix) .. ")")
            end;
        end;
    end;
    if msg:sub(1,2):find("/e") then
        msg=msg:sub(3);
    end;
    return cmd,args;
end;

return cmds;
