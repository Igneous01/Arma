/*
* Efnc_setPosASLZ
* set the height of an object ASL
* [unit, height] call Efnc_setPosASLZ
* unit: Object
* height: number - number in metres 
* returns: nothing
*/

private ["_unit", "_z"];
_unit = _this select 0;
_z = _this select 1;
_unit setposASL  [(getpos _unit) select 0,  (getpos _unit) select 1, _z];
