/*
* EF_fnc_isGroupInVehicles
* Tests to see whether all the units in a group are in any of the specified vehicles
* isIn = [group, vehicles] call EF_fnc_isGroupInVehicles;
* group: Group - group to check
* vehicles: Array format [vehicle1, vehicle2, ...] - the vehicles to check
* returns: Boolean - true if group is in vehicles, false if not
* if arguments are invalid, returns false
* if empty array is provided for vehicles, returns false
*/
if (count _this != 2) exitWith {false;};	// return false if insufficient arguments provided
if (
		!([_this select 0, [grpNull], true] call Efnc_isValidArgType)
		or
		!([_this select 1, [ [] ], true] call Efnc_isValidArgType)
	) exitWith {false;};	// return false if invalid argument types provided
if (count _this select 1 == 0) exitWith {false;};	// return false if empty array

private ["_grp", "_vehs", "_inVeh"];
_grp = _this select 0;
_vehs = _this select 1;
_cnt = 0;				// init count at 0
_units = units _grp;	// units of group
{
	private ["_veh"];
	_veh = _x;
	_cnt = _cnt + {_x in _veh} count _units;
} foreach _vehs;

if (_cnt == count _units) then
{
	_inVeh = true;
}
else
{
	_inVeh = false;
};
_inVeh
