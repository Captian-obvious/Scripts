local mod={
    AcidConfiguredParts={},
};
export type AcidConfiguration={
    PartMaxTimer:number, --how long (in seconds) that a part in the acid can last
    CycleLength:number, --how often (in seconds) damage is applied
    DamagePerCycle:number, --how much damage is applied each cycle (default: 0)
    DebounceTime:number, --how long (in seconds) before the part can take damage again (default: 0)
    StorageFolder:Instance?, --the folder where acid parts are stored (default: part.Parent:FindFirstChild("AcidDissolvedParts"))
};

function mod:GetConfigured(part:BasePart)
    return self.AcidConfiguredParts[part];
end;

function mod:SetConfigured(part:BasePart,config:AcidConfiguration)
    self.AcidConfiguredParts[part]=config;
end;

function mod:ClearConfigured(part:BasePart)
    self.AcidConfiguredParts[part]=nil;
end;

function mod:ClearAllConfigured()
    self.AcidConfiguredParts={};
end;

function mod:HasConfigured(part:BasePart)
    return self.AcidConfiguredParts[part]~=nil;
end;

function mod:AddConfiguredParts(parts:{BasePart},config:AcidConfiguration)
    for _,part in parts do
        self:SetConfigured(part,config);
        task.spawn(function()
            
        end);
    end;
end;

return mod;