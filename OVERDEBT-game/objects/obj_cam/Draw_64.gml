if (variable_global_exists("scrap_loss_timer") && global.scrap_loss_timer > 0) {
	var _gui_w = display_get_gui_width();
	var _gui_h = display_get_gui_height();
	var _cx = _gui_w * 0.5;
	var _cy = _gui_h * 0.5;
	var _panel_w = min(_gui_w * 0.56, 720);
	var _panel_h = min(_gui_h * 0.2, 144);
	var _text_scale = min(_gui_w / 426 * 0.75, 2);

	draw_set_colour(#090A14);
	draw_rectangle(_cx - _panel_w * 0.5, _cy - _panel_h * 0.5, _cx + _panel_w * 0.5, _cy + _panel_h * 0.5, false);
	draw_sprite_ext(spr_slot, 0, _cx, _cy, _panel_w / 16, _panel_h / 16, 0, #EBEDE9, 1);
	draw_set_colour(#EBEDE9);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(f_secundaria);
	draw_text_transformed(_cx, _cy - _panel_h * 0.15, "DEATH COST", _text_scale, _text_scale, 0);
	draw_text_transformed(_cx, _cy + _panel_h * 0.15, string(global.scrap_lost) + " SCRAP LOST", _text_scale, _text_scale, 0);
}
