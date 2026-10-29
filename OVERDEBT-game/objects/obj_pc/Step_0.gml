if (instance_exists(obj_player) && distance_to_object(obj_player) < 40 && mouse_check_button_pressed(mb_left)) {
	var _cx = obj_cam.x;
	var _cy = y - 50;
	var _base_cost = [15, 20, 18, 15, 15, 16, 18, 20];
	var _levels = global.upgrade_levels;

	for (var _i = 0; _i < 8; _i++) {
		var _col = _i mod 4;
		var _row = _i div 4;
		var _card_x = _cx - 150 + _col * 75;
		var _card_y = _cy - 15 + _row * 33;

		if (mouse_x >= _card_x && mouse_x <= _card_x + 72
			&& mouse_y >= _card_y - 12 && mouse_y <= _card_y + 12) {
			var _cost = _base_cost[_i] * (_levels[_i] + 1);
			if (obj_player.sucata >= _cost) {
				obj_player.sucata -= _cost;
				global.sucata = obj_player.sucata;
				_levels[_i] += 1;
				global.upgrade_levels = _levels;

				var _player = instance_find(obj_player, 0);
				switch (_i) {
					case 0: _player.jump_speed += 0.6; break;
					case 1: _player.bullet_damage += 1; break;
					case 2:
						_player.life_max += 5;
						_player.life += 5;
						break;
					case 3:
						_player.energy_max += 20;
						_player.energy += 20;
						break;
					case 4: _player.aim_limit += 3; break;
					case 5: _player.move_speed += 0.2; break;
					case 6: _player.shoot_rate = max(5, _player.shoot_rate - 3); break;
					case 7: _player.invincibility_frames += 6; break;
				}

				play_audio_random(sfx_upgrade);
			} else {
				shake(2);
				play_audio_random(sfx_damage);
			}
			break;
		}
	}
}

if (distance_to_object(obj_player) < 10) image_index = 1;
else image_index = 0;
