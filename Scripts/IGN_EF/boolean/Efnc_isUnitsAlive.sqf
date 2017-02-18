/*
* EF_fnc_isUnitsAlive
* Tests to see whether the array of units is alive (atleast 1 unit is alive)
* unitsAlive = units call EF_fnc_isUnitsAlive;
* units: Array format [object1, object2, ...] - the units to check
* Returns: Boolean - true if the units are alive, false if not
* If units is empty array, returns false
*/

private ["_units", "_alive"];
_units = [_this, [], [[]]] call EF_fnc_singleParam;
if (count _units == 0) exitWith {false;};
if ({alive _x} count _units == 0) then
{
	_alive = false;
}
else
{
	_alive = true;
};
_alive