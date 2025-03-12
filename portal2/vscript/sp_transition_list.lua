DBG = 0
FORCE_GUN_AND_HALLWAY = 0

FIRST_MAP_WITH_GUN = "sp_a1_intro4"
FIRST_MAP_WITH_UPGRADE_GUN = "sp_a2_laser_intro"
FIRST_MAP_WITH_POTATO_GUN = "sp_a3_speed_ramp"

CHAPTER_TITLES = {
    { map = "sp_a1_intro1", title_text = "#portal2_Chapter1_Title", subtitle_text = "#portal2_Chapter1_Subtitle", displayOnSpawn = false,		displaydelay = 1.0 },
    { map = "sp_a2_laser_intro", title_text = "#portal2_Chapter2_Title", subtitle_text = "#portal2_Chapter2_Subtitle", displayOnSpawn = true,	displaydelay = 2.5 },
    { map = "sp_a2_sphere_peek", title_text = "#portal2_Chapter3_Title", subtitle_text = "#portal2_Chapter3_Subtitle", displayOnSpawn = true,	displaydelay = 2.5 },
    { map = "sp_a2_column_blocker", title_text = "#portal2_Chapter4_Title", subtitle_text = "#portal2_Chapter4_Subtitle", displayOnSpawn = true, displaydelay = 2.5 },
    { map = "sp_a2_bts3", title_text = "#portal2_Chapter5_Title", subtitle_text = "#portal2_Chapter5_Subtitle", displayOnSpawn = true,			displaydelay = 1.0 },
    { map = "sp_a3_00", title_text = "#portal2_Chapter6_Title", subtitle_text = "#portal2_Chapter6_Subtitle", displayOnSpawn = true,			displaydelay = 1.5 },
    { map = "sp_a3_speed_ramp", title_text = "#portal2_Chapter7_Title", subtitle_text = "#portal2_Chapter7_Subtitle", displayOnSpawn = true,	displaydelay = 1.0 },
    { map = "sp_a4_intro", title_text = "#portal2_Chapter8_Title", subtitle_text = "#portal2_Chapter8_Subtitle", displayOnSpawn = true,			displaydelay = 2.5 },
    { map = "sp_a4_finale1", title_text = "#portal2_Chapter9_Title", subtitle_text = "#portal2_Chapter9_Subtitle", displayOnSpawn = false,		displaydelay = 1.0 },
}

function DisplayChapterTitle()
    for index, level in ipairs(CHAPTER_TITLES) do
        if level.map == game.GetMap() then
            local chapterTitleText = ents.FindByName("@chapter_title_text")[1]
            local chapterSubtitleText = ents.FindByName("@chapter_subtitle_text")[1]

            if chapterTitleText then
                chapterTitleText:Fire("SetTextColor", "210 210 210 128", 0.0)
                chapterTitleText:Fire("SetTextColor2", "50 90 116 128", 0.0)
                chapterTitleText:Fire("SetPosY", "0.32", 0.0)
                chapterTitleText:Fire("SetText", level.title_text, 0.0)
                chapterTitleText:Fire("display", "", level.displaydelay)
            end

            if chapterSubtitleText then
                chapterSubtitleText:Fire("SetTextColor", "210 210 210 128", 0.0)
                chapterSubtitleText:Fire("SetTextColor2", "50 90 116 128", 0.0)
                chapterSubtitleText:Fire("SetPosY", "0.35", 0.0)
                chapterSubtitleText:Fire("setText", level.subtitle_text, 0.0)
                chapterSubtitleText:Fire("display", "", level.displaydelay)
            end
        end
    end
end

function TryDisplayChapterTitle()
    for index, level in ipairs(CHAPTER_TITLES) do
        if level.map == game.GetMap() and level.displayOnSpawn then
            DisplayChapterTitle()
        end
    end
end

LOOP_TIMER = 0

initialized = false

-- This is the order to play the maps
local MapPlayOrder = {

    -- ===================================================
    -- ====================== ACT 1 ======================
    -- ===================================================
    
    -- ---------------------------------------------------
    -- 	Intro
    -- ---------------------------------------------------
    "sp_a1_intro1",				-- motel to box-on-button
    "sp_a1_intro2",				-- portal carousel
    "sp_a1_intro3",				-- fall-through-floor, dioramas, portal gun
    "sp_a1_intro4",				-- box-in-hole for placing on button
    "sp_a1_intro5",				-- fling hinting
    "sp_a1_intro6",				-- fling training
    "sp_a1_intro7",				-- wheatley meetup
    "sp_a1_wakeup",				-- glados 
        "@incinerator",
    
    -- ===================================================
    -- ====================== ACT 2 ======================
    -- ===================================================
    
    "sp_a2_intro", 		-- upgraded portal gun track
    
    -- ---------------------------------------------------
    --	Lasers
    -- ---------------------------------------------------
    "sp_a2_laser_intro",
    "sp_a2_laser_stairs",
    "sp_a2_dual_lasers",
    "sp_a2_laser_over_goo",
    
    -- ---------------------------------------------------
    -- 	Catapult
    -- ---------------------------------------------------
    "sp_a2_catapult_intro",
    "sp_a2_trust_fling",
    
    -- ---------------------------------------------------
    --	More Lasers
    -- ---------------------------------------------------
    "sp_a2_pit_flings",
    "sp_a2_fizzler_intro",
    
    -- ---------------------------------------------------
    --	Lasers + Catapult
    -- ---------------------------------------------------
    "sp_a2_sphere_peek",
    "sp_a2_ricochet",
    
    -- ---------------------------------------------------
    -- 	Bridges
    -- ---------------------------------------------------
    "sp_a2_bridge_intro",
    "sp_a2_bridge_the_gap",
    
    -- ---------------------------------------------------
    -- 	Turrets
    -- ---------------------------------------------------
    "sp_a2_turret_intro",
    "sp_a2_laser_relays", -- breather
    "sp_a2_turret_blocker",
    "sp_a2_laser_vs_turret", -- Elevator Glados Chat - Should be removed?
    
    -- ---------------------------------------------------
    -- 	Graduation
    -- ---------------------------------------------------
    "sp_a2_pull_the_rug",
    "sp_a2_column_blocker",		-- Elevator_vista
    "sp_a2_laser_chaining",
    --"sp_a2_turret_tower",
    "sp_a2_triple_laser",
    
    -- ---------------------------------------------------
    -- 	Sabotage
    -- ---------------------------------------------------
    
    "sp_a2_bts1",
    "sp_a2_bts2",
    "sp_a2_bts3",
    "sp_a2_bts4",
    "sp_a2_bts5",
    "sp_a2_bts6",
    
    -- ---------------------------------------------------
    -- 	Glados Chamber Sequence
    -- ---------------------------------------------------
    "sp_a2_core",
    
    
    -- ===================================================
    -- ====================== ACT 3 ======================
    -- ===================================================
    
    -- ---------------------------------------------------
    -- 	Underground
    -- ---------------------------------------------------
    
        "@bottomless_pit",
    "sp_a3_00",
    "sp_a3_01",
    "sp_a3_03",
        "@test_dome_lift",
    "sp_a3_jump_intro",
        "@test_dome_lift",
    "sp_a3_bomb_flings",
        "@test_dome_lift",
    "sp_a3_crazy_box",
        "@test_dome_lift",
    "sp_a3_transition01",
        "@test_dome_lift",
    "sp_a3_speed_ramp",
        "@test_dome_lift",
    "sp_a3_speed_flings",
        "@test_dome_lift",
    "sp_a3_portal_intro",
        "@hallway",
    "sp_a3_end",
    
    -- ===================================================
    -- ====================== ACT 4 ======================
    -- ===================================================
    
    -- ---------------------------------------------------
    -- 	Recapture
    -- ---------------------------------------------------
    "sp_a4_intro",
    
    -- ---------------------------------------------------
    -- 	Tractor beam
    -- ---------------------------------------------------
    "sp_a4_tb_intro",
    "sp_a4_tb_trust_drop",	
    --	"@hallway",
    "sp_a4_tb_wall_button",
    --	"@hallway",
    "sp_a4_tb_polarity",
    --	"@hallway",
    "sp_a4_tb_catch",	-- GRAD
    
    -- ---------------------------------------------------
    -- 	Crushers
    -- ---------------------------------------------------
    
    -- ---------------------------------------------------
    -- 	Graduation Combos
    -- ---------------------------------------------------
    "sp_a4_stop_the_box",	-- Grad?
    --	"@hallway",
    "sp_a4_laser_catapult", -- Grad
    --	"@hallway",
    --"sp_catapult_course"
    --	"@hallway",
    --"sp_box_over_goo", -- Grad
    --	"@hallway",
    "sp_a4_laser_platform",
    
    -- ---------------------------------------------------
    -- Tbeam + Paint
    -- ---------------------------------------------------
    --"sp_paint_jump_tbeam",
    --	"@hallway",
    "sp_a4_speed_tb_catch",
    --	"@hallway",
    "sp_a4_jump_polarity",	-- GRAD
    --	"@hallway",
    --"sp_paint_portal_tbeams",
    
    -- ---------------------------------------------------
    -- Wheatley Escape
    -- ---------------------------------------------------
    
    "sp_a4_finale1",
        "@hallway",
    "sp_a4_finale2",
        "@hallway",
    "sp_a4_finale3",
        "@hallway",
    
    -- ---------------------------------------------------
    -- 	FIXME: WHEATLEY BATTLE
    -- ---------------------------------------------------
    
    "sp_a4_finale4",
    
    -- ---------------------------------------------------
    -- 	Demo files
    -- ---------------------------------------------------
    "demo_intro",
    "demo_underground",
    "demo_paint",
}
    
function OnPostTransition()
    local foundMap = false

    for ind, map in ipairs(MapPlayOrder) do
        if game.GetMap() == MapPlayOrder[ind] then
            foundMap = true
            IsPortal2Map = true

            -- hook up our entry elevator
            if ind - 1 >= 0 then
                -- Find the @arrival_teleport entity
                local arrival_teleport = ents.FindByName("@arrival_teleport")[1]
                if IsValid(arrival_teleport) then
                    arrival_teleport:Fire("teleport")

                    -- Find the arrival elevator and start it
                    local arrival_elevator_elevator_1 = ents.FindByName("arrival_elevator-elevator_1")[1]
                    if IsValid(arrival_elevator_elevator_1) then
                        arrival_elevator_elevator_1:Fire("startforward")
                    end
                else
                    -- If @arrival_teleport wasn't found, print a message
                    print("Oopsies! @arrival_teleport was not found!")
                end
            end

            break
        end
    end
end

function EntFire_MapLoopHelper( classname, suffix, command, param, delay )
	-- This calls EntFire on an entity of a given type, named with the given suffix.
	-- This deals with instance name mangling (though it doesn't guarantee uniqueness)
	local suffix_len = suffix.len()
	local ent = Entities.FindByClassname(nil, classname)
	while ent ~= nil do
		local ent_name = ent:GetName()
		local suffix_offset = string.find(ent_name, suffix)
		if suffix_offset and suffix_offset == (string.len(ent_name) - string.len(	suffix)) then
			EntFire(ent_name, command, param, delay)
			return
		end
	end
	print( "MAPLOOP: ---- ERROR! Failed to find entity " .. suffix .. " while initiating map transition" );
end

function Think()
	-- Start the game loop if the cvar is set
	if initialized and LoopSinglePlayerMaps() then
		if LOOP_TIMER == 0 then
			LOOP_TIMER = Time() + 10 -- restart time in seconds
		end
		
		-- transition to the next map if the timer has expired
		if LOOP_TIMER < Time() then
			-- reset loop timer
			LOOP_TIMER = 0

			print( "\nMAPLOOP: timer expired, moving on..." )

			-- Ensure point_viewcontrollers are disabled
			EntFire( "point_viewcontrol", "disable", 0, 0 )
		
			-- Change the level (this sequence was originally in the 'transition_without_survey' logic_relay)
			EntFire_MapLoopHelper( "trigger_once",   "survey_trigger",    "Disable",       "",                    0.0 )
			EntFire_MapLoopHelper( "env_fade",       "exit_fade",         "Fade",          "",                    0.0 )
			EntFire_MapLoopHelper( "point_teleport", "exit_teleport",     "Teleport",      "",                    0.3 )
			EntFire_MapLoopHelper( "logic_script",   "transition_script", "RunScriptCode", "TransitionFromMap()", 0.4 )
		end
	end
	
	
	if initialized then
		return
	end
	initialized = true

	-- position fixup for sp_a3_01, in case player has fallen outside map

	if GetMapName() == "sp_a3_01" then
		print( "--------------- FIXING PLAYER POSITION FOR sp_a3_01" )

		local destination_name = "knockout-teleport" -- targetname of the destination entity
               
		local player_ent = nil

		local destination_ent = nil

		-- find the player
		player_ent = Entities.FindByClassname( player_ent, "player" )   

		if player_ent == nil then
			print("*** Cannot find player. Aborting!")
			return
		end

		-- find the destination entity
		destination_ent = Entities.FindByName( destination_ent, destination_name )   

		if destination_ent == nil then
			print("*** Cannot find destination entity " .. destination_name .. ". Aborting!")
			return
        end
		-- move the player to the destination
		player:SetOrigin( destination_ent.GetOrigin() )       
	end

	local portalGunCommand = ""
	local portalGunSecondCommand = ""
	local foundMap = false
	
	for index, map in pairs(MapPlayOrder) do
		if MapPlayOrder[index] == FIRST_MAP_WITH_GUN then
			portalGunCommand = "give_portalgun"
		elseif MapPlayOrder[index] == FIRST_MAP_WITH_UPGRADE_GUN then
			portalGunSecondCommand = "upgrade_portalgun"
		elseif MapPlayOrder[index] == FIRST_MAP_WITH_POTATO_GUN then
			portalGunSecondCommand = "upgrade_potatogun"
		end
		
		if GetMapName() == MapPlayOrder[index] then
			break
		end
	end

	TryDisplayChapterTitle()
	
	if portalGunCommand ~= "" and GetMapName() ~= "sp_a2_intro" and GetMapName() ~= "sp_a3_01" then
		print( "=======================Trying to run " .. portalGunCommand )
		EntFire( "command", "Command", portalGunCommand, 0.0 )
		EntFire( "@command", "Command", portalGunCommand, 0.0 )
	end

	if portalGunSecondCommand ~= "" then
		print( "=======================Trying to run " .. portalGunSecondCommand )
		EntFire( "command", "Command", portalGunSecondCommand, 0.1 )
		EntFire( "@command", "Command", portalGunSecondCommand, 0.1 )
	end
	
end

--------------------------/
-- sp_transition_list.nut--
--------------------------/

-- does this or the changelevel even work
function TransitionFromMap()
    local next_map = nil
    for index, map in ipairs(MapPlayOrder) do
        if game.GetMap() == MapPlayOrder[index] then
            -- make good
            local skipIndex = index
            for i = 1, 2 do
                if skipIndex + 1 <= #MapPlayOrder then
                    if string.find(MapPlayOrder[skipIndex + 1], "@") then
                        skipIndex = skipIndex + 1
                    else
                        break
                    end
                end
            end

            if skipIndex + 1 <= #MapPlayOrder and game.GetMap() ~= LAST_PLAYTEST_MAP then
                next_map = MapPlayOrder[skipIndex + 1]
                if DBG then print("Map " .. game.GetMap() .. " connects to " .. next_map) end

                local changeLevelEnt = ents.FindByName("@changelevel")[1]
                if not changeLevelEnt then
                    if DBG then print("('@changelevel' entity missing, using 'map' console command instead)") end
                    RunConsoleCommand("map", next_map)
                else
                    -- This is typically a function to change level in Garry's Mod.
                    changeLevelEnt:Fire("ChangeLevel", next_map, 0.0)
                end
            end
        end
    end

    if not next_map then
        if DBG then print("Map " .. game.GetMap() .. " is the last map") end
        -- Assuming you have entities that display end-of-playtest messages
        ents.FindByName("end_of_playtest_text")[1]:Fire("display", 0)
        ents.FindByName("@end_of_playtest_text")[1]:Fire("display", 0)

        -- If we are in the map loop and at the end of the list, start over at the beginning
        if LoopSinglePlayerMaps() then
            print("MAPLOOP: No more maps, restarting loop.")
            next_map = MapPlayOrder[1]
            local changeLevelEnt = ents.FindByName("@changelevel")[1]
            if not changeLevelEnt then
                RunConsoleCommand("map", next_map)
            else
                changeLevelEnt:Fire("ChangeLevel", next_map, 0.0)
            end
        end
    end

    print("")  -- Print an empty line
end