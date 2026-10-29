if active{

	active = false
	out = layer_sequence_create(
		"transition", 
		camera_get_view_x(view_camera[0]),
		camera_get_view_y(view_camera[0]), 
		global.transition_out
	);

}

if out != -1 and layer_sequence_is_finished(out) {
	
	room_goto(global.transition_room)
	layer_sequence_destroy(out);
	
}

if in != -1 and layer_sequence_is_finished(in) {
	
	layer_sequence_destroy(in);
	in = -1
	
}
