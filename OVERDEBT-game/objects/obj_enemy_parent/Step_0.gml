var _player = noone;
var _visible = false;

if (instance_exists(obj_player)) {
    _player = instance_find(obj_player, 0);

    var _distance = point_distance(x, y, _player.x, _player.y);
    if (_distance <= vision_range && abs(_player.y - y) <= vision_height) {
        var _sight_steps = max(1, ceil(_distance / 8));
        var _clear_sight = true;

        if (enemy_tilemap != -1) {
            for (var _i = 1; _i < _sight_steps; _i++) {
                var _t = _i / _sight_steps;
                var _sight_x = lerp(x, _player.x, _t);
                var _sight_y = lerp(y, _player.y, _t);
                if (scr_tilemap_point_solid(enemy_tilemap, _sight_x, _sight_y)) {
                    _clear_sight = false;
                    break;
                }
            }
        }

        _visible = _clear_sight;
    }
}

if (_visible) {
    chasing_player = true;
    sight_memory = sight_memory_frames;
} else if (chasing_player) {
    sight_memory = max(0, sight_memory - 1);
    if (sight_memory == 0) chasing_player = false;
}

if (enemy_shoot_cooldown > 0) enemy_shoot_cooldown -= 1;
if (enemy_shoots && _player != noone && _visible && enemy_shoot_cooldown <= 0
    && point_distance(x, y, _player.x, _player.y) <= enemy_shoot_range) {
    var _forward_angle = (move_dir > 0) ? 0 : 180;
    var _target_angle = point_direction(x, y, _player.x, _player.y);
    var _shot_angle = _forward_angle + clamp(angle_difference(_target_angle, _forward_angle), -30, 30);
    var _muzzle_x = x + lengthdir_x(14, _shot_angle);
    var _muzzle_y = y - 6 + lengthdir_y(14, _shot_angle);
    var _enemy_bullet = instance_create_layer(_muzzle_x, _muzzle_y, layer, obj_enemy_bullet);
    _enemy_bullet.shot_angle = _shot_angle;
    _enemy_bullet.image_angle = _shot_angle;
    _enemy_bullet.shot_speed = enemy_bullet_speed;
    _enemy_bullet.bullet_damage = enemy_bullet_damage;
    enemy_shoot_cooldown = enemy_shoot_rate;
}
var _chasing = chasing_player && _player != noone;

if (_chasing) {
    var _target_dx = _player.x - x;
    if (abs(_target_dx) > 4) move_dir = sign(_target_dx);
} else {
    if (x <= patrol_left) move_dir = 1;
    if (x >= patrol_right) move_dir = -1;
}

var _touching_player = _chasing && place_meeting(x, y, obj_player);
var _h_amount = _touching_player ? 0 : move_dir * patrol_speed;
var _h_steps = max(1, ceil(abs(_h_amount)));
var _h_step = _h_amount / _h_steps;

repeat (_h_steps) {
    var _next_x = x + _h_step;
    var _probe_x = (_h_step > 0) ? _next_x + collision_right : _next_x + collision_left;
    var _blocked_x = false;

    if (enemy_tilemap != -1) {
        for (var _py = floor(y + collision_top); _py <= ceil(y + collision_bottom); _py += 2) {
            if (scr_tilemap_point_solid(enemy_tilemap, _probe_x, _py)) {
                _blocked_x = true;
                break;
            }
        }
    }

    if (_blocked_x) {
        if (!_chasing) move_dir *= -1;
        break;
    }

    x = _next_x;
}
image_xscale = move_dir;

if (enemy_flying) {
    var _fly_target_y = _chasing ? _player.y : enemy_fly_home_y;
    var _fly_delta = clamp(_fly_target_y - y, -enemy_fly_speed, enemy_fly_speed);
    if (abs(_fly_delta) > 0) {
        var _fly_steps = max(1, ceil(abs(_fly_delta)));
        var _fly_step = _fly_delta / _fly_steps;

        repeat (_fly_steps) {
            var _next_fly_y = y + _fly_step;
            var _probe_fly_y = (_fly_step > 0) ? _next_fly_y + collision_body_bottom : _next_fly_y + collision_top;
            var _blocked_fly_y = false;

            if (enemy_tilemap != -1) {
                for (var _fly_x = floor(x + collision_left); _fly_x <= ceil(x + collision_right); _fly_x += 2) {
                    if (scr_tilemap_point_solid(enemy_tilemap, _fly_x, _probe_fly_y)) {
                        _blocked_fly_y = true;
                        break;
                    }
                }
            }

            if (_blocked_fly_y) break;
            y = _next_fly_y;
        }
    }
} else {
    var _enemy_grounded = false;
    if (enemy_tilemap != -1 && enemy_vsp >= 0) {
        for (var _gx = floor(x + collision_left); _gx <= ceil(x + collision_right); _gx += 2) {
            if (scr_tilemap_point_solid(enemy_tilemap, _gx, y + collision_body_bottom + 1)) {
                _enemy_grounded = true;
                break;
            }
        }
        if (!_enemy_grounded) {
            _enemy_grounded = scr_tilemap_point_solid(enemy_tilemap, x + collision_right, y + collision_body_bottom + 1);
        }
    }

    if (_enemy_grounded) {
        enemy_vsp = 0;
    } else {
        enemy_vsp = min(enemy_vsp + enemy_gravity, enemy_max_fall_speed);
        var _v_steps = max(1, ceil(abs(enemy_vsp)));
        var _v_step = enemy_vsp / _v_steps;

        repeat (_v_steps) {
            var _next_y = y + _v_step;
            var _probe_y = _next_y + collision_body_bottom;
            var _blocked_y = false;

            if (enemy_tilemap != -1) {
                for (var _px = floor(x + collision_left); _px <= ceil(x + collision_right); _px += 2) {
                    if (scr_tilemap_point_solid(enemy_tilemap, _px, _probe_y)) {
                        _blocked_y = true;
                        break;
                    }
                }
                if (!_blocked_y && scr_tilemap_point_solid(enemy_tilemap, x + collision_right, _probe_y)) {
                    _blocked_y = true;
                }
            }

            if (_blocked_y) {
                enemy_vsp = 0;
                break;
            }

            y = _next_y;
        }
    }
}

if (_player != noone && contact_cooldown > 0) contact_cooldown -= 1;
if (_player != noone && contact_cooldown <= 0 && place_meeting(x, y, obj_player)) {
    if (_player.damage_cooldown <= 0) {
        if (variable_global_exists("hit_particle_system") && part_system_exists(global.hit_particle_system)) {
            part_particles_burst(global.hit_particle_system, _player.x, _player.y, ef_hit);
			shake(10)
        }
        with (_player) {
            energy = max(0, energy - other.contact_damage);
            life = max(0, life - other.contact_damage);
            damage_cooldown = invincibility_frames;
			play_audio_random(sfx_damage)
        }
        contact_cooldown = 30;
    }
}

if (enemy_explodes_on_contact && _player != noone && place_meeting(x, y, obj_player)) {
    if (variable_global_exists("hit_particle_system") && part_system_exists(global.hit_particle_system)) {
        part_particles_burst(global.hit_particle_system, x, y, ef_death);
    }
    play_audio_random(sfx_explosion);
    instance_destroy();
}
