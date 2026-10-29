camw = 426
camh = 240

if instance_exists(obj_player) flw = obj_player
else flw = noone

if flw != noone{

	if (flw.x > camw/2 and flw.x < room_width  - camw/2) {x = flw.x}
	if (flw.y > camh/2 and flw.y < room_height - camh/2) {y = flw.y}

}
else{

	x = room_width/2
	y = room_height/2
	
}

xt = x
yt = y
