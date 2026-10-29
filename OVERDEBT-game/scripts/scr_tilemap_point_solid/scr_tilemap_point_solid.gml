function scr_tilemap_point_solid(_map, _x, _y) {
    if (_map == -1) return false;

    var _cell_x = tilemap_get_cell_x_at_pixel(_map, _x, _y);
    var _cell_y = tilemap_get_cell_y_at_pixel(_map, _x, _y);
    if (_cell_x < 0 || _cell_y < 0) return false;

    var _data = tilemap_get(_map, _cell_x, _cell_y);
    if (tile_get_empty(_data)) return false;

    var _index = tile_get_index(_data);
    if (_index < 0 || _index > 19) return false;

    var _tile_w = tilemap_get_tile_width(_map);
    var _tile_h = tilemap_get_tile_height(_map);
    var _local_x = floor(_x - (tilemap_get_x(_map) + _cell_x * _tile_w));
    var _local_y = floor(_y - (tilemap_get_y(_map) + _cell_y * _tile_h));

    switch (_index) {
        case 0: return false;
        case 1: return (_local_x <= 13 && _local_y >= 10);
        case 2: return (_local_x >= 18);
        case 3: return (_local_y >= 10 || _local_x <= 13);
        case 4: return (_local_y >= 10);
        case 5: return false;
        case 6: return ((_local_y < 14 && _local_x <= 13)
                     || (_local_y >= 10 && _local_x >= 18));
        case 7: return (_local_y >= 10 || _local_x >= 18);
        case 8: return true;
        case 9: return (_local_y <= 12 || _local_x <= 13);
        case 10: return false;
        case 11: return (_local_y <= 13 && _local_x >= 18);
        case 12: return (_local_y <= 13);
        case 13: return (_local_y <= 13 || _local_x >= 18);
        case 14: return (_local_x <= 13);
        case 15: return false;
        case 16: return false;
        case 17: return (_local_y >= 10 && _local_x >= 18);
        case 18:
            if (_local_y < 10) return (_local_x >= 18);
            if (_local_y < 14) return (_local_x <= 13 || _local_x >= 18);
            return (_local_x <= 13);
        case 19: return (_local_y <= 13 && _local_x <= 13);
    }

    return false;
}
