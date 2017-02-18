/*
* Efnc_setPosZ
* set the height of an object
* [unit, height] call Efnc_setPosZ
* unit: Object
* height: number - number in metres 
* returns: nothing
*/

private ["_unit", "_z"];
_unit = _this select 0;
_z = _this select 1;
_unit setpos  [(getpos _unit) select 0,  (getpos _unit) select 1, _z];
