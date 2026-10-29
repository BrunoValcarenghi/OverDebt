function move(){
	var _move_x = keyboard_check(vk_right) + keyboard_check(ord("D"))
	            - keyboard_check(vk_left) - keyboard_check(ord("A"));
	_move_x = clamp(_move_x, -1, 1);
	
	if _move_x != 0 {
		dir = _move_x
		moviment = true
	}
	else{
		moviment = false
	}
	
	
	var _h_amount = _move_x * move_speed;
	var _h_steps = max(1, ceil(abs(_h_amount)));
	var _h_step = _h_amount / _h_steps;

	if (_h_amount != 0 && floor_tilemap != -1) {
	    repeat (_h_steps) {
	        var _next_x = x + _h_step;
	        var _probe_x = (_h_step > 0) ? _next_x + collision_right : _next_x + collision_left;
	        var _blocked_x = false;

	        for (var _py = floor(y + collision_top); _py <= ceil(y + collision_bottom); _py += 2) {
	            if (scr_tilemap_point_solid(floor_tilemap, _probe_x, _py)) {
	                _blocked_x = true;
	                break;
	            }
	        }

	        if (_blocked_x) break;
	        x = _next_x;
	    }
	} else {
	    x += _h_amount;
	}
}

function jump(_allow_jump){
	var _jump_pressed = keyboard_check_pressed(vk_space)
	                 || keyboard_check_pressed(vk_up)
	                 || keyboard_check_pressed(ord("W"));

	grounded = false;
	if (floor_tilemap != -1 && vsp >= 0) {
	    for (var _gx = floor(x + collision_left); _gx <= ceil(x + collision_right); _gx += 2) {
	        if (scr_tilemap_point_solid(floor_tilemap, _gx, y + collision_body_bottom + 1)) {
	            grounded = true;
	            break;
	        }
	    }
	    if (!grounded) {
	        grounded = scr_tilemap_point_solid(floor_tilemap, x + collision_right, y + collision_body_bottom + 1);
	    }
	}

	if (grounded) {
	    coyote_timer = coyote_frames;
	    alarm[0] = 20;
	}

	if (_allow_jump && _jump_pressed && (grounded || coyote_timer > 0)) {
	    vsp = -jump_speed;
	    grounded = false;
	    coyote_timer = 0;
		play_audio_random(sfx_jump)
	}
	
	if (!grounded && coyote_timer > 0) {
	    coyote_timer -= 1;
	}

	vsp = min(vsp + gravity_strength, max_fall_speed);
	var _v_steps = max(1, ceil(abs(vsp)));
	var _v_step = vsp / _v_steps;

	repeat (_v_steps) {
	    var _next_y = y + _v_step;
	    var _probe_y = (_v_step > 0) ? _next_y + collision_body_bottom : _next_y + collision_top;
	    var _blocked_y = false;

	    if (floor_tilemap != -1) {
	        for (var _px = floor(x + collision_left); _px <= ceil(x + collision_right); _px += 2) {
	            if (scr_tilemap_point_solid(floor_tilemap, _px, _probe_y)) {
	                _blocked_y = true;
	                break;
	            }
	        }

	        if (!_blocked_y && scr_tilemap_point_solid(floor_tilemap, x + collision_right, _probe_y)) {
	            _blocked_y = true;
	        }
	    }

	    if (_blocked_y) {
	        if (_v_step > 0) grounded = true;
	        vsp = 0;
	        break;
	    }
		
	    y = _next_y;
	}
}