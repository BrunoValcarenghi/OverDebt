move_speed = 2; 
gravity_strength = .3;
max_fall_speed = 5;
jump_speed = 7;
vsp = 0;
grounded = false;
coyote_frames = 12;
coyote_timer = 0;
aiming = false;
aim_angle = 0;
aim_limit = 15;
shoot_cooldown = 0;
shoot_rate = 30;

energy_max = 100
energy = energy_max 
energy_tempo = 90
alarm[1] = energy_tempo
damage_cooldown = 0
global.hit_particle_system = part_system_create_layer("Instances", false, ef_hit);

dir = 1
moviment = false

life_max = 20
life = life_max

morreu = false

reload = false

sucata = global.sucata

var _floor_layer = layer_get_id("tl_floor");
floor_tilemap = -1;
if (_floor_layer != -1) {
    floor_tilemap = layer_tilemap_get_id(_floor_layer);
}

if (floor_tilemap == -1) {
    show_debug_message("obj_player: layer tl_floor ou seu tilemap não foi encontrado nesta room.");
}


collision_left = sprite_get_bbox_left(sprite_index) - sprite_get_xoffset(sprite_index);
collision_right = sprite_get_bbox_right(sprite_index) - sprite_get_xoffset(sprite_index);
collision_top = sprite_get_bbox_top(sprite_index) - sprite_get_yoffset(sprite_index);
collision_bottom = sprite_get_bbox_bottom(sprite_index) - sprite_get_yoffset(sprite_index) - 5;
collision_body_bottom = collision_bottom + 5;
