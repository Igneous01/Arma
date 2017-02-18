/*
* Efnc_groupInVehicle
* Tests to see whether all the units in a group are in the specified vehicle
* isIn = [group, vehicle] call Efnc_groupInVehicle;
* group: Group - group to check
* vehicle: Object - the vehicle to check
* returns: Boolean - true if group is in vehicle, false if not
*/

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


