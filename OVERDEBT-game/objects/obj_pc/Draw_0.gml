draw_self()

if distance_to_object(obj_player) < 40{

	draw_sprite_ext(spr_slot, 0, obj_cam.x, y - 50, 20, 5.5, 0, image_blend, 1)
	draw_sprite(spr_seta, 0, x, y-6)
	
	draw_set_colour(#EBEDE9)
	draw_set_halign(0)
	draw_set_valign(1)
	draw_set_font(f_secundaria)

}