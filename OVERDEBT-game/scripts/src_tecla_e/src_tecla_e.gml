function tecla_e(){
	
	if distance_to_object(obj_player) >= 11 {
		
		_a = 0
		_b = 0.1
		
	}
	else{
		
		_a += .05
		if _b < 5 _b += .5
		
	}
	
	if distance_to_object(obj_player) < 10{
	
		draw_sprite_ext(spr_e, 0, x+sprite_width/2, obj_player.y-_b-25, 1, 1, 0, c_white, _a);
	}
	
	draw_set_alpha(1)

}