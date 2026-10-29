var _dx = lengthdir_x(shot_speed, shot_angle);
var _dy = lengthdir_y(shot_speed, shot_angle);
var _steps = max(1, ceil(max(abs(_dx), abs(_dy))));
var _step_x = _dx / _steps;
var _step_y = _dy / _steps;

repeat (_steps) {
    var _next_x = x + _step_x;
    var _next_y = y + _step_y;

    var _enemy = instance_place(_next_x, _next_y, obj_enemy_parent);
    if (_enemy != noone) {
        if (variable_global_exists("hit_particle_system") && part_system_exists(global.hit_particle_system)) {
            part_particles_burst(global.hit_particle_system, _enemy.x, _enemy.y, ef_hit);
			shake(5)
			play_audio_random(sfx_enemy_dam)
        }
        with (_enemy) {
            enemy_health -= other.bullet_damage;
            if (enemy_health <= 0) {
				instance_destroy();
				play_audio_random(sfx_explosion)
				
				if (variable_global_exists("hit_particle_system") && part_system_exists(global.hit_particle_system)) {
					part_particles_burst(global.hit_particle_system, x, y, ef_death);
				}
				
				var _qnt = 3 + irandom(sucatas)
				for(var i = 0; i < _qnt; i++){

					instance_create_layer(x, y, "itens", obj_sucata)

				}	
				
			}
        }
        instance_destroy();
        exit;
    }

    if (floor_tilemap != -1 && scr_tilemap_point_solid(floor_tilemap, _next_x, _next_y)) {
        instance_destroy();
        exit;
    }

    x = _next_x;
    y = _next_y;
}

life -= 1;
if (life <= 0) instance_destroy();
