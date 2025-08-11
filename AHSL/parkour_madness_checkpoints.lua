--!ahsl (Uses AHSL library)
local checkpoints={};
local playerStatuses={};

function HandleCheckpoint(player, checkpoint:{num:number,part:BasePart})
    if not checkpoints[player] then
        playerStatuses[player]={
            lastCheckpoint=checkpoint,
            checkpointsPassed=1,
            checkpointReached=os.time()
        };
    else
        local status=playerStatuses[player];
        if checkpoint.num > status.lastCheckpoint.num then
            status.lastCheckpoint=checkpoint;
            status.checkpointsPassed=status.checkpointsPassed+1;
            status.checkpointReached=os.time();
        end;
    end;
end;