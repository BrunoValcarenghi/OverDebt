var _dx = lengthdir_x(shot_speed, shot_angle);
var _dy = lengthdir_y(shot_speed, shot_angle);
var _steps = max(1, ceil(max(abs(_dx), abs(_dy))));
var _step_x = _dx / _steps;
var _step_y = _dy / _steps;

repeat (_steps) {
    var _next_x = x + _step_x;
    var _next_y = y + _step_y;

    var _player = instance_place(_next_x, _next_y, obj_player);
    if (_player != noone) {
        if (_player.damage_cooldown <= 0) {
            if (variable_global_exists("hit_particle_system") && part_system_exists(global.hit_particle_system)) {
                part_particles_burst(global.hit_particle_system, _player.x, _player.y, ef_hit);
                shake(8);
            }
            with (_player) {
                energy = max(0, energy - other.bullet_damage);
                life = max(0, life - other.bullet_damage);
                damage_cooldown = invincibility_frames;
                play_audio_random(sfx_damage);
            }
        }
        instance_destroy();
        exit;
    }

    var _floor_layer = layer_get_id("tl_floor");
    if (_floor_layer != -1) {
        var _floor_tilemap = layer_tilemap_get_id(_floor_layer);
        if (_floor_tilemap != -1 && scr_tilemap_point_solid(_floor_tilemap, _next_x, _next_y)) {
            instance_destroy();
            exit;
        }
    }

    x = _next_x;
    y = _next_y;
}

life -= 1;
if (life <= 0) instance_destroy();
