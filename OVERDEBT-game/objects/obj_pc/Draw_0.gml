draw_self();

if (instance_exists(obj_player) && distance_to_object(obj_player) < 40) {
	var _cx = obj_cam.x;
	var _cy = y - 50;
	var _labels = ["JUMP HEIGHT", "DAMAGE", "HEALTH", "ENERGY", "SHOT ANGLE", "SPEED", "FIRE RATE", "INVINCIBILITY"];
	var _icons = [1, 6, 4, 5, 3, 2, 7, 0];
	var _base_cost = [15, 20, 18, 15, 15, 16, 18, 20];
	var _max_levels = [100, 100, 100, 100, 10, 100, 9, 100];
	var _levels = global.upgrade_levels;

	draw_sprite_ext(spr_seta, 0, x, y - 6, 1, 1, 0, #EBEDE9, 1);
	draw_set_colour(#090A14);
	draw_rectangle(_cx - 160, _cy - 44, _cx + 160, _cy + 44, false);
	draw_sprite_ext(spr_slot, 0, _cx, _cy, 20, 5.5, 0, #EBEDE9, 1);
	draw_set_colour(#EBEDE9);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(f_secundaria);
	draw_text_transformed(_cx, _cy - 36, "UPGRADES  |  SCRAP: " + string(obj_player.sucata), 0.7, 0.7, 0);

	for (var _i = 0; _i < 8; _i++) {
		var _col = _i mod 4;
		var _row = _i div 4;
		var _card_x = _cx - 150 + _col * 75;
		var _card_y = _cy - 15 + _row * 33;
		var _cost = _base_cost[_i] * (_levels[_i] + 1);
		var _at_max = _levels[_i] >= _max_levels[_i];
		var _hover = mouse_x >= _card_x && mouse_x <= _card_x + 72
			&& mouse_y >= _card_y - 12 && mouse_y <= _card_y + 12;
		var _scale = _hover ? 1.1 : 1;

		draw_sprite_ext(spr_icon, _icons[_i], _card_x + 8, _card_y, 0.32 * _scale, 0.32 * _scale, 0, #EBEDE9, 1);
		draw_set_colour(#EBEDE9);
		draw_set_halign(fa_left);
		draw_text_transformed(_card_x + 17, _card_y - 7, _labels[_i], 0.55 * _scale, 0.55 * _scale, 0);
		draw_text_transformed(_card_x + 17, _card_y + 1, _at_max ? "MAX LEVEL" : string(_cost) + " SCRAP", 0.42 * _scale, 0.42 * _scale, 0);
		draw_text_transformed(_card_x + 17, _card_y + 8, "LVL " + string(_levels[_i]), 0.42 * _scale, 0.42 * _scale, 0);
		draw_set_halign(fa_center);
	}

	draw_set_colour(#EBEDE9);
	draw_set_halign(fa_center);
	var _footer = (feedback_timer > 0) ? feedback_text : "CLICK TO PURCHASE";
	draw_text_transformed(_cx, _cy + 36, _footer, 0.55, 0.55, 0);
}

if (distance_to_object(obj_player) < 10) image_index = 1;
else image_index = 0;
