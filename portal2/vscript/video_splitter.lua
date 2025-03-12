function Precache()
    if _G.PrecachedVideos ~= nil then
        -- Don't do anything if videos have already been cached
        return
    else
        -- Mark the videos as cached to prevent reprecaching
        _G.PrecachedVideos = 1 

        local mapName = game.GetMap()

        -- Iterate through ElevatorVideos table (ensure it's defined somewhere else in your code)
        for index, level in pairs(ElevatorVideos) do
            if level.map == mapName then
                local movieName = nil

                -- Handle additional movie
                if level.additional ~= nil and level.additional ~= "" then
                    movieName = "media/" .. level.additional
                    -- Precache the movie (you may need a custom method for videos in Garry's Mod)
                    PrecacheMovie(movieName)
                end

                -- Handle arrival movie
                if level.arrival ~= nil and level.arrival ~= "" then
                    movieName = "media/"
                    if OVERRIDE_VIDEOS == 1 then
                        movieName = movieName .. "entry_emergency.bik"
                    else
                        movieName = movieName .. level.arrival
                    end
                    -- Precache the movie (you may need a custom method for videos in Garry's Mod)
                    PrecacheMovie(movieName)
                end

                -- Handle departure movie
                if level.departure ~= nil and level.departure ~= "" then
                    movieName = "media/"
                    if OVERRIDE_VIDEOS == 1 then
                        movieName = movieName .. "exit_emergency.bik"
                    else
                        movieName = movieName .. level.departure
                    end
                    PrecacheMovie(movieName)
                end
            end
        end
    end
end

function PrecacheMovie(moviePath)
    resource.AddFile(moviePath)
    print("Pre-caching movie: " .. moviePath)
end
--============================
function StopDepartureVideo(width, height)
    EntFire("@departure_video_master", "Disable", "", 0)
    EntFire("@departure_video_master", "killhierarchy", "", 1.0)
    StopVideo(DEPARTURE_VIDEO, width, height)
end