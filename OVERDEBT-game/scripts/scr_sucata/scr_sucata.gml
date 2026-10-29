function magnet(){

	if distance_to_object(obj_player) < 20{
	
		direction = point_direction(x, y, obj_player.x, obj_player.y)
		speed = .25
	
	}
	else{speed = 0}

}

function bounce(){
	
	timer += 0.1;
	y += sin(timer) / 3;

}