/*
* EF_fnc_deleteGroup
* Deletes a group and all units that belong to that group, returns true if successful, false if not
* deleted = myGroup call EF_fnc_deleteGroup;
* myGroup: Group - group that is to be deleted
* Returns: Boolean - true when the group and its units were successfully deleted, otherwise false
* If null group is provided as argument, returns false
*/

private ["_grp"];
_grp = [_this, grpNull, [grpNull]] call EF_fnc_singleParam;
if (isNull(_grp)) exitWith {false;};
{
	deleteVehicle _x;
} foreach units _grp;

deleteGroup _grp;
true;
