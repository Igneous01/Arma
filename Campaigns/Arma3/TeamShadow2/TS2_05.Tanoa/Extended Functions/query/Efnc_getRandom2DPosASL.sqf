/*
* EF_fnc_getRandom2DPosASL
* Returns a random new position inside provided radius, with altitude at sea level
* newPos = [pos, radius] call EF_fnc_getRandom2DPosASL
* pos: Array - position in either [x, y] or [x, y, z]
* radius: Number - radius to randomly select within
* returns: Array format [x, y, z] - new position
* if invalid arguments provided, returns new position at [0,0,0] with radius 300
*/

private ["_pos", "_radius", "_newPos", "_z"];
_pos = [_this, 0, [0,0,0], [[]], [2,3]] call BIS_fnc_param;
_radius = [_this, 1, 300, [0]] call BIS_fnc_param;

// return new position within radius relative to position
_newPos = [(_pos select 0)-_radius*sin(random 359), (_pos select 1)-_radius*cos(random 359)];
_z = getTerrainHeightASL _newPos;
_newPos set[2, _z];
_newPos;
