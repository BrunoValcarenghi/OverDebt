if distance_to_object(obj_player) < 10 {
	
	if keyboard_check(ord("E")) {
		
		with(obj_player){
			
			reload = true
			if energy < energy_max energy +=.05
			play_audio_random(sfx_reload)
			
		}
		
	}
	else obj_player.reload = false
	image_index = 1
	
}
else image_index = 0