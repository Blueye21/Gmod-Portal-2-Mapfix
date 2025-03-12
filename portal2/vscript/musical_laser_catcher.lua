-- set up global counter
if GlobalMusicalCatcherCount == nil then
    GlobalMusicalCatcherCount = 0
end


-- increment the count
GlobalMusicalCatcherCount = (GlobalMusicalCatcherCount or 0) + 1


-- set up global containing currently active catchers
if GlobalMusicalCatcherPowered == nil then
    GlobalMusicalCatcherPowered = 0
end

-- connect to catcher entity IO
function onPostSpawn(self)
	self:Fire("AddOutput", "OnPowered", "CatcherPowerOn", 0)
	self:Fire("AddOutput", "OnUnPowered", "CatcherPowerOff", 0)
end

-----------------------------------------------------------
-- called when catcher becomes powered
-----------------------------------------------------------
function CatcherPowerOn(self)
    GlobalMusicalCatcherPowered = (GlobalMusicalCatcherPowered or 0) + 1
    ent = ents.FindByName(self:GetName() .. "_music_" .. GlobalMusicalCatcherPowered)[1]
    if IsValid(ent) then
        ent:Fire("PlaySound", "", 0)
    end
    QueueAdd()
end

-----------------------------------------------------------
-- called when catcher becomes unpowered
-----------------------------------------------------------
function CatcherPowerOff(self)
    GlobalMusicalCatcherPowered = (GlobalMusicalCatcherPowered or 1) - 1
    for _, ent in ipairs(ents.FindByName(self:GetName() .. "_music_*")) do
        if IsValid(ent) then
            ent:Fire("StopSound", "", 0)
        end
    end

    RemoveSelfFromQueue()
    RefreshMusicPlaylist()
end

function RefreshMusicPlaylist()
    for index, val in ipairs(GlobalCatcherPlayList) do
        local expectedSong = val.catcher .. "_music_" .. (index + 1)

        if val.song ~= expectedSong then
            for _, ent in ipairs(ents.FindByName(val.catcher .. "_music_*")) do
                if IsValid(ent) then
                    ent:Fire("StopSound", "", 0)
                end
            end
            local correctSoundEnt = ents.FindByName(expectedSong)[1]
            if IsValid(correctSoundEnt) then
                correctSoundEnt:Fire("PlaySound", "", 0)
            end
            GlobalCatcherPlayList[index].song = expectedSong
        end
    end
end

----------------------------------------------------------------------------------------------------------------
--Queue Functions
----------------------------------------------------------------------------------------------------------------
GlobalCatcherPlayList = GlobalCatcherPlayList or {}

function OnPostSpawn()
    if next(GlobalCatcherPlayList) == nil then
        QueueInitialize()
    end
end

--Initialize the queue
function QueueInitialize()
    GlobalCatcherPlayList = {} -- Clears the table by reinitializing it as an empty table
end

--Add a scene to the queue
function QueueAdd(self)
    local entry = {
        catcher = self:GetName(),
        song = self:GetName() .. "_music_" .. GlobalMusicalCatcherPowered
    }

    table.insert(GlobalCatcherPlayList, entry)
end

--Display the queue
function QueueDisplay()
    if DBG then
        for index, val in ipairs(GlobalCatcherPlayList) do
            print("===== " .. index .. " - " .. val.catcher .. "   |Music - " .. val.song)
        end
    end
end

function QueueLen()
    return #GlobalCatcherPlayList
end

--Returns number of items in the queue

--Delete a single item by index from the queue
function QueueDelete(index)
    if QueueLen() == 0 then
        return false
    end
    
    -- Remove from queue
    table.remove(GlobalCatcherPlayList, index)
end

--Sort through queue and remove self if found
function RemoveSelfFromQueue(self)
    local catchername = self:GetName()

    if QueueLen() == 0 then
        return false
    end
    
    for index, val in ipairs(GlobalCatcherPlayList) do
        if catchername == val.catcher then
            if DBG then
                print("====== removing #" .. index .. " named: " .. val.catcher)
            end
            table.remove(GlobalCatcherPlayList, index)
            return true
        end
    end

    return false
end
