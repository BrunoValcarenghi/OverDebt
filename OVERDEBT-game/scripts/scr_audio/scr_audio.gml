global.volume = 1

function play_audio_random(_som,  _vol = 1, _min = 0.8, _max = 1.2){
	
	if _som = sfx_damage
	or _som = sfx_enemy_dam
	or _som = sfx_jump{
		
		_vol =.5
		
	}

	
    if (!audio_is_playing(_som)){
		var _snd = audio_play_sound(_som, 1, false, global.volume * _vol);
	    var _tom = random_range(_min, _max);
	    audio_sound_pitch(_snd, _tom);
	}
}
