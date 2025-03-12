local ElevatorMotifs =
{
	{ map = "sp_a1_intro1", speed = 200 },
	{ map = "sp_a1_intro2", speed = 200 },	-- this is what we do for continual elevator shafts
	{ map = "sp_a1_intro3", speed = 200 },	-- this is what we do for continual elevator shafts
	{ map = "sp_a1_intro5", speed = 200 },	-- this is what we do for continual elevator shafts
	{ map = "sp_a1_intro6", speed = 200 },	-- this is what we do for continual elevator shafts
	{ map = "sp_a2_bridge_intro", speed = 200  },
--	{ map = "sp_a2_laser_over_goo", speed = 300, motifs = [ "@shaft_stoppage_1", "transition", ] },
	{ map = "sp_a2_column_blocker", speed = 200 },
	{ map = "sp_a2_trust_fling", speed = 300 },


	{ map = "sp_a2_intro", speed = 125 },	
	{ map = "sp_a2_laser_intro", speed = 200 },
	{ map = "sp_a2_laser_stairs", speed = 200 },
	{ map = "sp_a2_dual_lasers", speed = 200 },
	{ map = "sp_a2_catapult_intro", speed = 200 },
	{ map = "sp_a2_pit_flings", speed = 200 },
--	{ map = "sp_a2_fizzler_intro", speed = 200 },
	{ map = "sp_a2_sphere_peek", speed = 200 },
	{ map = "sp_a2_ricochet", speed = 200 },
	{ map = "sp_a2_bridge_the_gap", speed = 200},
	{ map = "sp_a2_turret_intro", speed = 200 },
	{ map = "sp_a2_laser_relays", speed = 200 },
	{ map = "sp_a2_turret_blocker", speed = 200 },
	{ map = "sp_a2_laser_vs_turret", speed = 200 },
	{ map = "sp_a2_pull_the_rug", speed = 200 },
	{ map = "sp_a2_ring_around_turrets", speed = 200 },
	{ map = "sp_a2_laser_chaining", speed = 200 },
	{ map = "sp_a2_triple_laser", speed = 200 },
	{ map = "sp_a3_jump_intro", speed = 120 },
	{ map = "sp_a3_bomb_flings", speed = 120 },
	{ map = "sp_a3_crazy_box", speed = 120 },
	{ map = "sp_a3_speed_ramp", speed = 120 },
	{ map = "sp_a3_speed_flings", speed = 120 },
	{ map = "sp_a4_intro", speed = 200 },
	{ map = "sp_a4_tb_intro", speed = 200 },
	{ map = "sp_a4_tb_trust_drop", speed = 200 },
	{ map = "sp_a4_tb_wall_button", speed = 200 },
	{ map = "sp_a4_tb_polarity", speed = 200 },
	{ map = "sp_a4_tb_catch", speed = 100 },
	{ map = "sp_a4_stop_the_box", speed = 200 },
	{ map = "sp_a4_laser_catapult", speed = 200 },
	{ map = "sp_a4_speed_tb_catch", speed = 200 },
	{ map = "sp_a4_jump_polarity", speed = 200 },
}

function StartMoving()
    if not self then
        print("Error: 'self' is not defined in the current context.")
        return
    end

    local foundLevel = false
    
    -- Iterate through ElevatorMotifs
    for index, level in ipairs(ElevatorMotifs) do
        -- Check if the current map matches and has a speed value
        if level.map == game.GetMap() and level.speed then
            print("Starting elevator " .. self:GetName() .. " with speed " .. level.speed)
            
            -- Find the elevator entity by its name
            local elevator = ents.FindByName(self:GetName())[1]
            
            -- Ensure the elevator is valid before proceeding
            if IsValid(elevator) then
                elevator:Fire("SetSpeedReal", level.speed, 0.0)
            else
                print("Error: Elevator not found or invalid.")
            end
            foundLevel = true
        end
    end
    
    -- If no matching level was found, use a default speed
    if not foundLevel then
        print("Using default elevator speed 300")
        local elevator = ents.FindByName(self:GetName())[1]
        
        -- Ensure the elevator is valid before proceeding
        if IsValid(elevator) then
            elevator:Fire("SetSpeedReal", "300", 0.0)
        else
            print("Error: Elevator not found or invalid.")
        end
    end
end

function ReadyForTransition()
    PrepareTeleport()
end

function FailSafeTransition()
    local transitionFromMap = ents.FindByName("@transition_from_map")[1]
    if IsValid(transitionFromMap) then
        transitionFromMap:Fire("Trigger", "", 0.0)
    end
    
    local transitionWithSurvey = ents.FindByName("@transition_with_survey")[1]
    if IsValid(transitionWithSurvey) then
        transitionWithSurvey:Fire("Trigger", "", 0.0)
    end
end

function PrepareTeleport()   
    local foundLevel = false
        
    if TransitionFired == 1 then
        return
    end

    for index, level in ipairs(ElevatorMotifs) do
        if level.map == game.GetMap() then
            if level.motifs then
                print("Trying to connect to motif " .. level.motifs[MotifIndex])

                if level.motifs[MotifIndex] == "transition" then
                    local transition = ents.FindByName("@transition_with_survey")[1]
                    if IsValid(transition) then
                        transition:Fire("Trigger", "", 0.0)
                    end

                    local transitionMap = ents.FindByName("@transition_from_map")[1]
                    if IsValid(transitionMap) then
                        transitionMap:Fire("Trigger", "", 0.0)
                    end
                    return
                else
                    local elevator = ents.FindByName(self:GetName())[1]
                    if IsValid(elevator) then
                        elevator:Fire("SetRemoteDestination", level.motifs[MotifIndex], 0.0)
                    end

                    if MotifIndex == 0 then
                        local departureElevator = ents.FindByName("departure_elevator-elevator_1")[1]
                        if IsValid(departureElevator) then
                            departureElevator:Fire("Stop", "", 0.05)
                        end
                    end
                end
                foundLevel = true
            else
                if TransitionReady == 1 then
                    TransitionFired = 1
                    local transitionMap = ents.FindByName("@transition_from_map")[1]
                    if IsValid(transitionMap) then
                        transitionMap:Fire("Trigger", "", 0.0)
                    end

                    local transitionSurvey = ents.FindByName("@transition_with_survey")[1]
                    if IsValid(transitionSurvey) then
                        transitionSurvey:Fire("Trigger", "", 0.0)
                    end
                end
                return
            end
        end
    end
    
    if not foundLevel then
        TransitionFired = 1
        local transitionSurvey = ents.FindByName("@transition_with_survey")[1]
        if IsValid(transitionSurvey) then
            transitionSurvey:Fire("Trigger", "", 0.0)
        end

        local transitionMap = ents.FindByName("@transition_from_map")[1]
        if IsValid(transitionMap) then
            transitionMap:Fire("Trigger", "", 0.0)
        end
        print("Level not found in elevator_motifs, defaulting to transition")
        return
    end
    
    local elevator = ents.FindByName(self:GetName())[1]
    if IsValid(elevator) then
        elevator:Fire("Enable", "", 0.0)
    end
    MotifIndex = MotifIndex + 1
end

hook.Add("PlayerSpawn", "OnPlayerPostSpawn", function(player)
    MotifIndex = 0
    TransitionReady = 0
    TransitionFired = 0
end)