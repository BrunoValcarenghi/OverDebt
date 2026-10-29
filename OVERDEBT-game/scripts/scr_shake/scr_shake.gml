global.shake_amount = 0;

function shake(_strength){
    if (_strength > global.shake_amount) {
        global.shake_amount = _strength;
    }
}
