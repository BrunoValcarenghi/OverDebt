global.transition_room = -1
global.transition_out = -1
global.transition_in = -1

function transition(_room, _saida, _entrada){
	
	global.transition_room = _room
	global.transition_out = _saida
	global.transition_in = _entrada
	
	obj_transition.active = true

}
