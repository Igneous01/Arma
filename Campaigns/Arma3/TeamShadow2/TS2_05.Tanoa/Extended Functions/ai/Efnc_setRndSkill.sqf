/*
* Efnc_setRndSkill
* Sets ai skills of a unit to a random value within the desired range
* [unit, min, max] call Efnc_setRndSkill
* unit: Object - the unit 
* min: float - number from 0.0 to 1.0 - minimum skill value to select 
* max: float - number from 0.0. to 1.0 - maximum skill value to select 
* returns: nothing
* Example: [units group player, 0.2, 0.4] call Efnc_setRndSkill;
*/

private ["_unit", "_min", "_max"];
_unit = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_min = [_this, 1, 0, [0]] call BIS_fnc_param;
_max = [_this, 2, 1, [0]] call BIS_fnc_param;
{
	private ["_val"];
	_val = (_min * 100) + ( (random 0.99) * (((_max * 100) - (_min * 100)) + 1) );	// formula for random with adjusted range
	_val = _val - (_val % 1);
	_val = _val / 100;
	_unit setskill [_x,_val];
} foreach ["aimingAccuracy", "aimingShake", "aimingSpeed", "endurance", "spotDistance", "spotTime", "courage", "reloadSpeed", "commanding", "general"];  
