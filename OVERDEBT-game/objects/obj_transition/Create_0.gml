active = false

out = -1
in =-1

global.transition_room = -1
global.transition_out = -1
out = -1

if global.transition_in = -1 and in != -1{

	layer_sequence_destroy(in);
	
}

if global.transition_in != -1{
	
	layer_depth("transition", -10000);
	
	in = layer_sequence_create(
		"transition", 
		obj_cam.x - obj_cam.camw/2,
		obj_cam.y - obj_cam.camh/2, 
		global.transition_in
	);
	global.transition_in = -1

}
