function player_sprite(){

	image_xscale = dir
	if (aiming) {
		troca_sprite(spr_player_shoot)
		return;
	}
	
	if !grounded{
	
		if vsp < 0 or alarm[0] < 0 troca_sprite(spr_player_jump1)
		if sprite_index = spr_player_jump1 and image_index >= 4 image_index = 4
	
	}
	else {
		if moviment{
	
			if sprite_index != spr_player_run_start and sprite_index != spr_player_run troca_sprite(spr_player_run_start)
			else if image_index >= 1 troca_sprite(spr_player_run)
	
		}
		else {
	
			if sprite_index != spr_player_run_stop and sprite_index != spr_player_idle troca_sprite(spr_player_run_stop)
			else if image_index >= 1 troca_sprite(spr_player_idle)
		}
	}
	
	
	
}

function troca_sprite(_spr){

	if sprite_index != _spr {
		image_index = 0
		sprite_index = _spr
	}

}
