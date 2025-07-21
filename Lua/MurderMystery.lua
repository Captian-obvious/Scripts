--[[ Murder Mystery Game Script
    This script manages the game flow, including starting rounds, handling special rounds,
    and updating player states.
    * The newest entry to my ever growing list of Insert Wars Remade scripts
]]
local main=require(18433326237);
local thegame={
    gameCount=0,
    hasFirstSpecialOccured=false,
    specialRound=false,
    randomGamemodes={
        "Juggernaut",
        "Massacre",
        "Shootout",
        "Mimic",
    },
    roundsToSpecial=math.random(5,7), -- Randomly set rounds to special between 5 and 7 (initialized)
    roundLength=180, -- Length of each round in seconds
    Gamemode="",
    round={}, -- Round state would end up here
};
local Players=game:GetService("Players");
--[[ Starts the game and will change the gamemode if special round
* @return: None
]]
function thegame:Start()
    if not main.endedStatus then
        return;
    end;
    self.gameCount+=1;
    --[[ For testing, this triggers the first special round after 3 games.
         * In the actual game, this will be triggered after 5-7 games.
         * This is to ensure that the first special round occurs in a reasonable time frame for testing purposes.
         ]]
    if (gameCount>2 and not self.hasFirstSpecialOccured) or (gameCount>self.roundsToSpecial) then
        self.specialRound=true;
        self.roundsToSpecial=math.random(5,7); -- Reset rounds to special for the next cycle
        self.gameCount=0; -- Reset game count after a special round
        if not self.hasFirstSpecialOccured then
            self.hasFirstSpecialOccured=true;
        end;
        local chosenGamemode=self.randomGamemodes[math.random(1,#randomGamemodes)];
        self.Gamemode=chosenGamemode; -- Set the chosen gamemode for the special round
        if chosenGamemode=="Juggernaut" then
            main:StartJugGame(false);
        elseif chosenGamemode=="Massacre" then
            main:StartMasGame(false);
        elseif chosenGamemode=="Shootout" then
            main:StartShoGame(false);
        elseif chosenGamemode=="Mimic" then
            main:StartMimGame(false);
        end;
    end;
    if not self.specialRound then
        self.Gamemode="Normal"; -- Set the gamemode to Normal if not a special round
        main:StartGame(false);
    end;
    self:Timer(); -- Start the game timer
end;
--[[
Initializes the game timer.
    * This function is called to start the game timer and manage the game flow.
    * It handles the special rounds and normal rounds based on the game count.
    * @return: None
]]
function thegame:Timer()
    if main.endedStatus then
        return;
    end;
    for i=1,self.roundLength do
        task.wait(1); -- Wait for 1 second
        local timeLeft=self.roundLength-i; -- Calculate the time left in the round
        self.round.timeLeft=timeLeft; -- Update the round state with the time left
        if self.specialRound then
            self.round.isSpecial=true; -- Mark the round as special
        end;
        self.round.Gamemode=self.Gamemode; -- Update the round state with the current gamemode
        if not self.Gamemode or self.Gamemode=="" then
            self.Gamemode="Normal"; -- Default to Normal gamemode if not set
        end;
        self.round.Roles={};
        for _,player in pairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                local aliveStatus=player.Character:FindFirstChild("isAlive");
                if aliveStatus then
                    table.insert(self.round.Roles, {
                        Name=player.Name,
                        Role=main:GetRole(player),
                        IsAlive=true,
                    });
                else
                    table.insert(self.round.Roles, {
                        Name=player.Name,
                        Role=main:GetRole(player),
                        IsAlive=false,
                    });
                end;
            end;
        end;
        self:updateTimer(timeLeft); -- Update player states and timer UI
        if main.endedStatus then
            break; -- Exit if the game has ended
        end;
        if timeLeft<=0 then
            self:End("Times Up!"); -- End the game if time runs out
            break;
        end;
    end;
end;
--[[ Updates the game state
    * This function checks if the game has ended and updates player states accordingly.
    * It also handles the alive check for players in the game.
    * If the game is a Free For All (FFA) mode, it checks for the alive status of players.
    * its called every second during a round
    * @param timeLeft: The time left in the current round.
    * @return: None
]]
function thegame:updateTimer(timeLeft:number)
    if main.endedStatus then
        return;
    end;
    if not main.Gamemode:lower():find("ffa") then
        main:aliveCheck(not self.isSpecialRound);
    else
        local text="murderer";
        if self.Gamemode=="Shootout" then
            text="sheriff";
        end;
        main:ffaAliveCheck(false,text);
    end;
    self.round.Roles={};
    for _,player in pairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            local aliveStatus=player.Character:FindFirstChild("isAlive");
            if aliveStatus then
                table.insert(self.round.Roles, {
                    Name=player.Name,
                    Role=main:GetRole(player),
                    IsAlive=true,
                });
            else
                table.insert(self.round.Roles, {
                    Name=player.Name,
                    Role=main:GetRole(player),
                    IsAlive=false,
                });
            end;
            local humanoid=player.Character.Humanoid;
            if humanoid.Health<=0 then
                if player:FindFirstChild("PlayerGui") and v.PlayerGui:FindFirstChild("Timer") then
                    player.PlayerGui.Timer.main.timeLeft.Text="You are dead!"; -- Update the timer UI for dead players
                end;
            else
                if player:FindFirstChild("PlayerGui") and v.PlayerGui:FindFirstChild("Timer") then
                    player.PlayerGui.Timer.main.timeLeft.Text="Time Left: "..timeLeft.." seconds"; -- Update the timer UI for alive players
                end;
            end;
        end;
    end;
end;

--[[ Ends the game and resets the game state
    * This function is called to end the game and reset the game state.
    * It handles the cleanup of player states and resets the game variables.
    * It also cleans up any leftover ragdolls or dropped guns from the game.
    * @param msg: The message to display when ending the game (optional).
    * @return: None
]]
function thegame:End(msg:string)
    if not main.endedStatus then
        main:EndGame(msg or "Game Over");
    end;
    self.specialRound=false; -- Reset special round status
    self.Gamemode=""; -- Reset gamemode
    for i,v in pairs(workspace:GetChildren()) do
        if v:IsA("Model") and v.Name=="_" then
            v:Destroy(); -- Clean up any leftover ragdolls from the game
        elseif v:IsA("Model") and v.Name=="DroppedGun" then
            v:Destroy(); -- Clean up the leftover dropped gun from the game
        end;
    end;
    if workspace:FindFirstChild("Map") then
        workspace.Map:Destroy(); -- Clean up the map if it exists
    end;
end;

--[[ Returns the game state
    * This function returns the current game state, including the game count,
    * special round status, and gamemode.
    * @return: A table containing the game state.
]]
function thegame:GetState()
    return {
        gameCount=self.gameCount,
        hasFirstSpecialOccured=self.hasFirstSpecialOccured,
        specialRound=self.specialRound,
        Gamemode=self.Gamemode,
    };
end;
--[[ Returns the round state
    * This function returns the current round state, including the time left,
    * gamemode, and player roles.
    * @return: A table containing the current round state.
]]
function thegame:GetRoundState()
    return self.round; -- Return the current round state
end;

return thegame; -- Return the game module