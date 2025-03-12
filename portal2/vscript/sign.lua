DBG = 1

-- door search range
local FIND_DOOR_RANGE = 200


my_door = null
is_sign = true

-----------------------------------------------------------
-- OnPostSpawn
-----------------------------------------------------------
function OnPostSpawn()
    local cur_ent = nil
    local my_door = nil
    local FIND_DOOR_RANGE = 1000  -- You can adjust this as needed (in Hammer units)

    -- Loop to find the nearby "func_door" entities
    repeat
        -- Find the next "func_door" entity within range of the current entity's origin
        cur_ent = ents.FindInSphere(self:GetPos(), FIND_DOOR_RANGE)

        -- Check if the entity exists and is a "func_door"
        for _, ent in ipairs(cur_ent) do
            if ent:GetClass() == "func_door" then
                if DBG then
                    print(self:GetName() .. " " .. ent:GetName())
                end

                -- Check if the door is a portal door (custom property is set in script scope)
                if ent:GetNWBool("is_portal_door", false) then
                    my_door = ent
                    if DBG then
                        print(self:GetName() .. " found a door " .. ent:GetName())
                    end
                end
            end
        end
    until not cur_ent or my_door

    -- If no door was found
    if not my_door then
        if DBG then
            print(self:GetName() .. ": Did not find a nearby door.")
        end
        return
    end

    -- Increment the total buttons for the door
    if my_door then
        local totalButtons = my_door:GetNWInt("total_buttons", 0)
        my_door:SetNWInt("total_buttons", totalButtons + 1)
    end
end

-----------------------------------------------------------
-- fires when OnUser1 is triggered, which is any time the
-- button gets pressed
-----------------------------------------------------------
function OnUser1Output()
    if DBG then 
        print("Attempting to open nearby door with door.nut") 
    end

    -- Close the button on the door (assuming my_door is already defined)
    my_door:GetScriptScope().CloseButton()

    -- Find nearby info_target that is sign target and fire its user1 output
    local cur_ent = nil
    
    -- Search for "info_target" entities within a radius of 8 units from the current entity's position
    local nearby_targets = ents.FindInSphere(self:GetPos(), 8)
    
    -- Loop through found entities
    for _, ent in ipairs(nearby_targets) do
        if ent:GetClass() == "info_target" then
            -- Check if this info_target has the 'is_sign_target' property (using networked bools here)
            if ent:GetNWBool("is_sign_target", false) then
                if DBG then
                    print("Found info_target: " .. ent:GetName())
                end

                -- Fire the 'user1' output
                ent:Fire("user1")
            end
        end
    end
end
-----------------------------------------------------------
-- fires when OnUser1 is triggered, which is any time the
-- button gets unpressed
-----------------------------------------------------------
function OnUser2Output()
    if DBG then
        print("Closing door")
    end

    -- Open the button on the door (assuming my_door is already defined)
    my_door:GetScriptScope().OpenButton()

    -- Find nearby info_target that is sign target and fire its user2 output
    local cur_ent = nil
    
    -- Search for "info_target" entities within a radius of 8 units from the current entity's position
    local nearby_targets = ents.FindInSphere(self:GetPos(), 8)
    
    -- Loop through found entities
    for _, ent in ipairs(nearby_targets) do
        if ent:GetClass() == "info_target" then
            -- Check if this info_target has the 'is_sign_target' property (using networked bools here)
            if ent:GetNWBool("is_sign_target", false) then
                if DBG then
                    print("Found info_target: " .. ent:GetName())
                end

                -- Fire the 'user2' output
                ent:Fire("user2")
            end
        end
    end
end