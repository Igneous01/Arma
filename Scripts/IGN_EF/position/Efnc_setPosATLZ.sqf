/*
* Efnc_setPosATLZ
* set the height of an object ATL
* [unit, height] call Efnc_setPosATLZ
* unit: Object
* height: number - number in metres 
* returns: nothing
*/

private ["_unit", "_z"];
_unit = _this select 0;
_z = _this select 1;
_unit setposATL  [(getpos _unit) select 0,  (getpos _unit) select 1, _z];
