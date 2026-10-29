if room = rm_central {
	image_alpha = 0
	if place_meeting(x, y, obj_player) {
		transition(rm_map, sq_vertical_out, sq_vertical_in)
	}
}

else{

	if distance_to_object(obj_player) < 10 {
	
		if keyboard_check_pressed(ord("E")) {
			global.sucata = obj_player.sucata 
			transition(rm_central, sq_vertical_out, sq_vertical_in)
		}
	
	}
	else{
	
		saiu = true
	
	}

	if obj_player.y >= 450 and obj_player.y <= 460 and !saiu and !tremeu {
		tremeu = true
		shake(5)
		play_audio_random(sfx_explosion)
	}

}