DoorCloseDist = 125
DidPlayerExitRoom = false
PlayerDist = 0

-- Precache sounds we will emit
function Precache()
    util.PrecacheSound("sound/portal/elevator_ding.wav")
    util.PrecacheSound("sound/portal/button_up.wav")
end

function OnPostSpawn(entity)
    
    if entity:IsValid() then
        hook.Add("OnFullyOpen", entity, function()
            OnDoorFullyOpened(entity)
        end)

        hook.Add("OnFullyClosed", entity, function()
            OnDoorFullyClosed(entity)
        end)
    end
end

function OnDoorFullyOpened()
    PlayDoorOpenSound()	
end

function OnDoorFullyClosed()
    if not DidPlayerExitRoom then
        PlayDoorCloseSound()
    end
end

-----------------------------------------------------------
-- fires when player teleports to portal
-----------------------------------------------------------
function OnPlayerTeleportToMeOutput()
    DidPlayerExitRoom = false
end

function OnPlayerTeleportFromMeOutput()
    DidPlayerExitRoom = true
end

function PlayDoorOpenSound(entity)
    self:EmitSound("portal/elevator_ding.wav")
end

function PlayDoorCloseSound(entity)
    self:EmitSound("portal/button_up.wav")
end
