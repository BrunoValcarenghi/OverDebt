function text_border(_x, _y, _text, b_color, _text_color, _outline_width) {
    draw_set_color(b_color);
    
    draw_text(_x - _outline_width, _y - _outline_width, _text);
    draw_text(_x,                  _y - _outline_width, _text);
    draw_text(_x + _outline_width, _y - _outline_width, _text);
    draw_text(_x - _outline_width, _y,                  _text);
    draw_text(_x + _outline_width, _y,                  _text);
    draw_text(_x - _outline_width, _y + _outline_width, _text);
    draw_text(_x,                  _y + _outline_width, _text);
    draw_text(_x + _outline_width, _y + _outline_width, _text);
    
    draw_set_color(_text_color);
    draw_text(_x, _y, _text);
	
}