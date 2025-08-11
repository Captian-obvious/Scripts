--!ahsl (Uses AHSL library)
local checkpoints={};
local playerStatuses={};
local characterAddedChecks={};
local baseIndex=130;

function HandleCheckpoint(player, checkpoint:{num:number,part:BasePart})
    if not checkpoints[player] then
        playerStatuses[player]={
            lastCheckpoint=checkpoint,
            checkpointsPassed=1,
            checkpointReached=os.time()
        };
        characterAddedChecks[player]=player.CharacterAdded:Connect(function(character)
            if character and character:IsA("Model") then
                local humanoid=character:FindFirstChildOfClass("Humanoid");
                if humanoid then
                    if playerStatuses[player] then
                        local theCheckpoint=playerStatuses[player].lastCheckpoint;
                        if theCheckpoint and theCheckpoint.part then
                            local part=theCheckpoint.part;
                            if part:IsA("BasePart") then
                                local newPosition=part.Position + Vector3.new(0, 5, 0);
                                character:MoveTo(newPosition);
                                humanoid.Health=humanoid.MaxHealth;
                                playerStatuses[player].checkpointReached=os.time();
                            end;
                        end;
                    end;
                end;
            end;
        end);
    else
        local status=playerStatuses[player];
        if checkpoint.num > status.lastCheckpoint.num then
            status.lastCheckpoint=checkpoint;
            status.checkpointsPassed=status.checkpointsPassed+1;
            status.checkpointReached=os.time();
        else
            -- Player has returned to a previous checkpoint, do nothing
            print("Player " .. player.Name .. " returned to a previous checkpoint: " .. checkpoint.num);
        end;
    end;
end;

for i=1,3 do
    local theindex=baseIndex + i;
    local checkpointPart=PartIndexing.GetPartsWithIndex(theindex)[1];
    if checkpointPart then
        checkpoints[checkpointPart] = {
            num=i,
            part=checkpointPart
        };
        checkpointPart.Touched:Connect(function(hit)
            local player=game.Players:GetPlayerFromCharacter(hit.Parent);
            if player then
                HandleCheckpoint(player, checkpoints[checkpointPart]);
            end;
        end);
    else
        warn("Checkpoint part with index " .. theindex .. " not found.");
    end;
end;