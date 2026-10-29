aiming = mouse_check_button(mb_right) && grounded;
if (damage_cooldown > 0) damage_cooldown -= 1;
image_alpha = (damage_cooldown > 0 && (damage_cooldown div 3) mod 2 == 0) ? 0.25 : 1;
if (aiming) {
	moviment = false;
} else {
	move();
}
if (aiming && mouse_x != x) {
	dir = sign(mouse_x - x);
}
jump(!aiming);
if (!grounded) aiming = false;
player_combat();
player_sprite();

if (life <= 0 or energy <= 0) and !morreu{

	morreu = true
	play_audio_random(sfx_death)
	transition(rm_central, sq_vertical_out, sq_vertical_in)
	global.scrap_lost = sucata;
	global.scrap_loss_timer = room_speed * 3;
	global.sucata = 0
	
}

if morreu image_alpha = 0

if room = rm_central and energy < 10 energy = energy_max
