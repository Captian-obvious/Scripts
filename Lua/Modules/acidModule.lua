local mod={
    AcidConfiguredParts={},
};
export type AcidConfiguration={
    MaxTimer:number,
    CycleLength:number,
    DamagePerCycle:number,
    DebounceTime:number,
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
    end;
end;

return mod;