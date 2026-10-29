if (feedback_timer > 0) feedback_timer -= 1;

if (instance_exists(obj_player) && distance_to_object(obj_player) < 40 && mouse_check_button_pressed(mb_left)) {
	var _cx = obj_cam.x;
	var _cy = y - 50;
	var _base_cost = [15, 20, 18, 15, 15, 16, 18, 20];
	var _max_levels = [100, 100, 100, 100, 10, 100, 9, 100];
	var _levels = global.upgrade_levels;

	for (var _i = 0; _i < 8; _i++) {
		var _col = _i mod 4;
		var _row = _i div 4;
		var _card_x = _cx - 150 + _col * 75;
		var _card_y = _cy - 15 + _row * 33;

		if (mouse_x >= _card_x && mouse_x <= _card_x + 72
			&& mouse_y >= _card_y - 12 && mouse_y <= _card_y + 12) {
			if (_levels[_i] >= _max_levels[_i]) {
				feedback_text = "MAX LEVEL";
				feedback_timer = room_speed;
				break;
			}

			var _cost = _base_cost[_i] * (_levels[_i] + 1);
			var _player = instance_find(obj_player, 0);

			if (_player.sucata < _cost) {
				feedback_text = "NOT ENOUGH SCRAP";
				feedback_timer = room_speed;
				shake(2);
				play_audio_random(sfx_enemy_dam);
			} else {
				_player.sucata -= _cost;
				global.sucata = _player.sucata;
				_levels[_i] += 1;
				global.upgrade_levels = _levels;

				switch (_i) {
					case 0:
						_player.jump_speed += 0.6;
						feedback_text = "JUMP HEIGHT +0.6";
						break;
					case 1:
						_player.bullet_damage += 1;
						_player.shot_energy_cost += 1;
						feedback_text = "DAMAGE +1  |  SHOT COST +1";
						break;
					case 2:
						_player.life_max += 5;
						_player.life += 5;
						feedback_text = "HEALTH +5";
						break;
					case 3:
						_player.energy_max += 20;
						_player.energy = min(_player.energy + 20, _player.energy_max);
						_player.energy_tempo = max(35, _player.energy_tempo - 5);
						_player.alarm[1] = _player.energy_tempo;
						feedback_text = "ENERGY +20  |  FASTER DRAIN";
						break;
					case 4:
						_player.aim_limit += 3;
						_player.shot_energy_cost += 1;
						feedback_text = "SHOT ANGLE +3  |  SHOT COST +1";
						break;
					case 5:
						_player.move_speed += 0.2;
						_player.energy_tempo = max(35, _player.energy_tempo - 3);
						_player.alarm[1] = _player.energy_tempo;
						feedback_text = "SPEED +0.2  |  FASTER DRAIN";
						break;
					case 6:
						_player.shoot_rate = max(5, _player.shoot_rate - 3);
						_player.shot_energy_cost += 1;
						feedback_text = "FIRE RATE UP  |  SHOT COST +1";
						break;
					case 7:
						_player.invincibility_frames += 6;
						feedback_text = "INVINCIBILITY +6 FRAMES";
						break;
				}

				feedback_timer = room_speed * 2;
				play_audio_random(sfx_upgrade);
			}
			break;
		}
	}
}

if (distance_to_object(obj_player) < 10) image_index = 1;
else image_index = 0;
