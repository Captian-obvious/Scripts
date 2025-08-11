--!ahsl (Uses AHSL library)
local checkpoints={};
local playerStatuses={};

function HandleCheckpoint(player, checkpoint)
    if not checkpoints[player] then
        playerStatuses[player]={
            lastCheckpoint=checkpoint,
            status="active"
        };
    end;
end;