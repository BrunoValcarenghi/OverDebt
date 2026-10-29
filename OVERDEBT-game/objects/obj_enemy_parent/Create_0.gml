move_dir = choose(-1, 1);
patrol_speed = 1;
patrol_range = 96;
patrol_start_x = x;
patrol_left = x - patrol_range;
patrol_right = x + patrol_range;
contact_damage = 10;
enemy_health = 2;
contact_cooldown = 0;
enemy_vsp = 0;
enemy_gravity = 0.3;
enemy_max_fall_speed = 5;
enemy_flying = false;
enemy_fly_speed = 1.2;
enemy_fly_home_y = y;
vision_range = 240;
vision_height = 72;
chasing_player = false;
sight_memory_frames = 24;
sight_memory = 0;
enemy_explodes_on_contact = false;
enemy_shoots = false;
enemy_shoot_cooldown = 0;
enemy_shoot_rate = 90;
enemy_bullet_speed = 6;
enemy_bullet_damage = 8;
enemy_shoot_range = 320;

collision_left = sprite_get_bbox_left(sprite_index) - sprite_get_xoffset(sprite_index);
collision_right = sprite_get_bbox_right(sprite_index) - sprite_get_xoffset(sprite_index);
collision_top = sprite_get_bbox_top(sprite_index) - sprite_get_yoffset(sprite_index);
collision_bottom = sprite_get_bbox_bottom(sprite_index) - sprite_get_yoffset(sprite_index) - 5;
collision_body_bottom = collision_bottom + 5;

var _floor_layer = layer_get_id("tl_floor");
enemy_tilemap = -1;
if (_floor_layer != -1) {
    enemy_tilemap = layer_tilemap_get_id(_floor_layer);
}

sucatas = 1;
