-- number of available nuggets
number_of_nuggets = 0

-- number of nuggets awarded to player
AwardedNuggetCount = 0

-----------------------------------------------------------
-- OnPostSpawn
-----------------------------------------------------------
function OnPostSpawn()
    local spawn_dest_array = {}
    local cur_ent = nil
    local number_of_nuggets = 0

    for _, ent in pairs(ents.FindByClass("info_target")) do
        if ent:GetName() == EntityGroup[1]:GetName() then
            number_of_nuggets = number_of_nuggets + 1
            table.insert(spawn_dest_array, ent)
        end
    end

    -- Spawn the templates at the destination
    for i = 1, number_of_nuggets do
        local spawn_position = spawn_dest_array[i]
        
        -- Assuming EntityGroup[0] is the entity to spawn
        local entity = ents.Create(EntityGroup[0])  -- Create the entity from the template
        
        if IsValid(entity) then
            -- Position the entity at the spawn location
            entity:SetPos(spawn_position:GetPos())
            entity:Spawn()
        end
    end
end

-----------------------------------------------------------
-- This function gets called when a nugget trigger is touched
-----------------------------------------------------------
function AwardNugget()
    -- Increment the awarded nugget count
    AwardedNuggetCount = AwardedNuggetCount + 1

    local targetEntity = EntityGroup[2] -- The entity you are interacting with

    if IsValid(targetEntity) then
        targetEntity:SetKeyValue("settext", "You got " .. AwardedNuggetCount .. " of " .. number_of_nuggets .. " Aperture Incentivizing Nuggets!")
        targetEntity:Fire("display", "", 0) -- Trigger the "display" action
    end
end
