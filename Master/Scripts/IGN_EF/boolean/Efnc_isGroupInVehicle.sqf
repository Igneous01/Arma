/*
* EF_fnc_isGroupInVehicle
* Tests to see whether all the units in a group are in the specified vehicle
* isIn = [group, vehicle] call EF_fnc_isGroupInVehicle;
* group: Group - group to check
* vehicle: Object - the vehicle to check
* returns: Boolean - true if group is in vehicle, false if not
* if invalid arguments provided, returns false
*/
if (count _this != 2) exitWith {false;};	// return false if insufficient arguments provided
if (
		!([_this select 0, [grpNull], true] call Efnc_isValidArgType)
		or
		!([_this select 1, [objNull], true] call Efnc_isValidArgType)
	) exitWith {false;};	// return false if invalid argument types provided

private ["_grp", "_veh", "_inVeh"];
_grp = _this select 0;
_veh = _this select 1;
// check if _veh is actual vehicle
if ({_x in _veh} count units _grp == count units _grp) then
{
	_inVeh = true;
}
else
{
	_inVeh = false;
};
_inVeh


