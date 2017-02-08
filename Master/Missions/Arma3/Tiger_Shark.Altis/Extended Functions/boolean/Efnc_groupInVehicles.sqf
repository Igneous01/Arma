/*
* Efnc_groupInVehicles
* Tests to see whether all the units in a group are in any of the specified vehicles
* isIn = [group, vehicles] call Efnc_groupInVehicles;
* group: Group - group to check
* vehicles: Array format [vehicle1, vehicle2, ...] - the vehicles to check
* returns: Boolean - true if group is in vehicles, false if not
*/

private ["_grp", "_vehs", "_inVeh"];
_grp = _this select 0;
_vehs = _this select 1;
_cnt = 0;	// init count at 0
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
