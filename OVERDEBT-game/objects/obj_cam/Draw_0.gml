var _uiy = y-camh/2 + 24
var _energy = obj_player.energy/obj_player.energy_max * 28
var _life = obj_player.life - 3
if obj_player.life <= 5 _life = obj_player.life/2

draw_set_halign(0)
draw_set_valign(1)
draw_set_font(f_principal)

if room != rm_central{

	var _uix = x - camw/2 + 5

	text_border(_uix, _uiy, "LIFE", #090a14, #ebede9, 2)
	draw_sprite_ext(spr_life_bar, 0, _uix + 30 , _uiy, obj_player.life_max/4, 1, 0, image_blend, 1)
	draw_sprite_ext(spr_life, 0, _uix + 36, _uiy, _life, 1, 0, image_blend, 1)

	draw_sprite_ext(spr_batery, 0, _uix, _uiy + 16, 1, 5.5, 0, image_blend, 1)
	draw_sprite_ext(spr_batery_colum, 0, _uix + 4, _uiy + 28 + 167, 1, _energy, 0, image_blend, 1)

	
}
else var _uix = x - camw/2 - 25

draw_set_font(f_numero)
draw_sprite(spr_sucata, 0, _uix + 43, _uiy + 200)
text_border(_uix + 55, _uiy + 200, obj_player.sucata, #090a14, #ebede9, 2)

