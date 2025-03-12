
-- --------------------------------------------------------
function PrecacheContainerAnimations()
	RunConsoleCommand("fs_fios_prefetch_file_in_pack models/container_ride/finedebris_part1.ps3.ani")
	RunConsoleCommand("fs_fios_prefetch_file_in_pack models/container_ride/finedebris_part3.ps3.ani")
	RunConsoleCommand("fs_fios_prefetch_file_in_pack models/container_ride/finedebris_part5.ps3.ani")
	RunConsoleCommand("fs_fios_prefetch_file_in_pack models/container_ride/finedebris_part7.ps3.ani")
	RunConsoleCommand("fs_fios_prefetch_file_in_pack models/container_ride/finedebris_part9.ps3.ani")
	RunConsoleCommand("fs_fios_prefetch_file_in_pack models/container_ride/finedebris_part11.ps3.ani")
	RunConsoleCommand("fs_fios_prefetch_file_in_pack models/container_ride/finedebris_part12.ps3.ani")
	RunConsoleCommand("fs_fios_prefetch_file_in_pack models/container_ride/finedebris_part13.ps3.ani")

	RunConsoleCommand("fs_fios_prefetch_file_in_pack models/container_ride/container_lorez.ps3.ani")
	RunConsoleCommand("fs_fios_prefetch_file_in_pack models/container_ride/container_lolorez.ps3.ani")
end

function StartContainerAnimations()
    -- Set animation for container stacks
    EntFire("@container_stacks_1", "setanimation", "anim1", 0)
    EntFire("@container_stacks_2", "setanimation", "anim1", 0)
    EntFire("@container_stacks_2", "DisableDraw", "", 0)
    
    -- Loop through container stacks
    --for i = 1, 92 do
        -- Set parent attachment and animation
        --EntFire("container_stacked_" .. i, "setparentattachment", "vstattachment", 0)
        --EntFire("@container_stacked_" .. i, "setanimation", "container" .. i, 0)
        
        -- Disable drawing for containers above 56
        --if i > 56 then
            --EntFire("@container_stacked_" .. i, "DisableDraw", "", 0)
        --end
    --end
end

function ShowHiddenContainers()
    -- Enable drawing for container stack 2
    EntFire("@container_stacks_2", "EnableDraw", "", 0)
    
    -- Loop to enable drawing for containers above 56
    --for i = 57, 92 do
        --EntFire("@container_stacked_" .. i, "EnableDraw", "", 0)
    --end
end

function SetupContainerAttachments()
--	for(local i=1;i<=92;i+=1)
--	{
--		EntFire("container_stacked_" + i,"SetParentAttachmentMaintainOffset", "vstAttachment_noOrient", 0 )
--	}
end
