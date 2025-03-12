-- sp_a2_intro
sound.Add({
    name = "music.sp_a2_intro_01",
    channel = CHAN_STATIC,
    soundlevel = SNDLVL_NONE,
    volume = 0.65,
    sound = {
	"*music/sp_a2_intro.wav"
	"npc/xray/beep.wav"
	"common/null.wav"
	},
    soundentry_version = 2,
    operator_stacks = {
        update_stack = {
            import_stack = "update_music_stereo",
            volume_fade_in = {
                input_max = 0.0
            },
            volume_fade_out = {
                input_max = 0.0
            }
        }
    }
})