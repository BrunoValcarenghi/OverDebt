function player_combat() {
	if (shoot_cooldown > 0) shoot_cooldown -= 1;
	if (!aiming) return;

	var _forward_angle = (dir > 0) ? 0 : 180;
	var _mouse_angle = point_direction(x, y, mouse_x, mouse_y);
	var _aim_offset = angle_difference(_mouse_angle, _forward_angle);
	_aim_offset = clamp(_aim_offset, -aim_limit, aim_limit);
	aim_angle = _forward_angle + _aim_offset;
	if (point_distance(x, y, mouse_x, mouse_y) < 1) {
		aim_angle = _forward_angle;
	}

	if (mouse_check_button(mb_left) && shoot_cooldown <= 0) {
		var _muzzle_distance = 18;
		var _muzzle_x = x + lengthdir_x(_muzzle_distance, aim_angle);
		var _muzzle_y = y - 7 + lengthdir_y(_muzzle_distance, aim_angle);
		var _bullet = instance_create_layer(_muzzle_x, _muzzle_y, layer, obj_bullet);
		_bullet.shot_angle = aim_angle;
		_bullet.image_angle = aim_angle;
		shoot_cooldown = shoot_rate;
		energy -= 2
		play_audio_random(sfx_shoot)
		
	}
}
