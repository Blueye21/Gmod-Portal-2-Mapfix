---------------------------------------------------------------------------------
-- This file specifies which icons are going to show up on the lightboard at the 
-- beginning of the level if you need to add a new icon, you must add the actual 
-- icon to the end of the texture sheet AND add it to g_pszLightboardIcons in 
-- vgui_mp_lobby_screen
---------------------------------------------------------------------------------


lightboard_startup_sequences = {
    Startups = {
        normal_flicker = {
            flicker_rate_min = 0.2,
            flicker_rate_max = 0.65,
            flicker_quick_min = 0.02,
            flicker_quick_max = 0.12,
            bg_flicker_length = 0.75,
            level_number_delay = 0.80,
            icon_delay = 1.0,
            progress_delay = 1.65,
        },
        dirty_flicker = {
            flicker_rate_min = 0.2,
            flicker_rate_max = 0.65,
            flicker_quick_min = 0.02,
            flicker_quick_max = 0.12,
            bg_flicker_length = 0.75,
            level_number_delay = 0.80,
            icon_delay = 1.0,
            progress_delay = 1.65,
        },
        broken_flicker = {
            flicker_rate_min = 0.5,
            flicker_rate_max = 0.8,
            flicker_quick_min = 0.1,
            flicker_quick_max = 0.5,
            bg_flicker_length = 5.00,
            level_number_delay = 4.5,
            icon_delay = 3.0,
            progress_delay = 2.8,
        }
    }
}
