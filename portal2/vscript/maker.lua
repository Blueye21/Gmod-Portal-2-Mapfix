DBG = 0

function OnPostSpawn()
    -- object sizes as a table (instead of an enum)
    local size = {
        small = 1,
        normal = 2,
        large = 3
    }

    local cur_ent = nil

    -- loop to find info_target entities
    repeat
        -- find the next info_target
        cur_ent = ents.FindByClass("info_target")[1]  -- Assume the first one is the target
        
        if cur_ent and string.find(cur_ent:GetName(), "button") then
            if cur_ent:GetScriptScope().is_button_target then
                local butt_pos = string.find(cur_ent:GetName(), "button")
                local system_name = string.sub(cur_ent:GetName(), 1, butt_pos - 1)
                local butt_numb = string.sub(cur_ent:GetName(), butt_pos + 6)

                if DBG then
                    print("Button position: " .. tostring(butt_pos))
                    print("System name: " .. system_name)
                    print("Button number: " .. butt_numb)
                end

                print(EntityGroup[size.normal])  -- Assuming EntityGroup is a valid table

                -- switch statement for button size
                if cur_ent:GetScriptScope().button_size == size.small then
                    if DBG then print("Spawning button of small size") end
                    EntityGroup[size.small]:SpawnEntityAtEntityOrigin(cur_ent)
                elseif cur_ent:GetScriptScope().button_size == size.normal then
                    if DBG then print("Spawning button of normal size") end
                    EntityGroup[size.normal]:SpawnEntityAtEntityOrigin(cur_ent)
                elseif cur_ent:GetScriptScope().button_size == size.large then
                    if DBG then print("Spawning button of large size") end
                    EntityGroup[size.large]:SpawnEntityAtEntityOrigin(cur_ent)
                end

                -- find associated sign
                local sign = nil
                local cur_brush = nil

                repeat
                    cur_brush = ents.FindByClassWithin("func_brush", cur_ent:GetPos(), 1000)[1]

                    if cur_brush and cur_brush:GetScriptScope().is_sign then
                        if DBG then print("Found a brush: " .. tostring(cur_brush)) end
                        sign = cur_brush
                    end
                until not cur_brush

                if not sign then
                    if DBG then print("No sign for " .. tostring(cur_ent)) end
                    return
                end

                local sign_dest_name = system_name .. "sign" .. butt_numb
                if DBG then print("Sign position: " .. sign_dest_name) end

                local dest_sign = ents.FindByName(sign_dest_name)[1]
                if dest_sign then
                    sign:SetPos(dest_sign:GetPos())
                    sign:SetForwardVector(dest_sign:GetForwardVector())
                end
            end
        end
    until not cur_ent
end