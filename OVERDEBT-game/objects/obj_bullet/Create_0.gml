shot_angle = 0;
shot_speed = 10;
bullet_damage = 1;
life = 90;
image_speed = 0;

var _floor_layer = layer_get_id("tl_floor");
floor_tilemap = -1;
if (_floor_layer != -1) {
    floor_tilemap = layer_tilemap_get_id(_floor_layer);
}
