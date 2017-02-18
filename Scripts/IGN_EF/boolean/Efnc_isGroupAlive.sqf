/*
* EF_fnc_isGroupAlive
* Tests to see whether the group is alive (has atleast 1 member alive)
* grpAlive = [grp] call EF_fnc_isGroupAlive;
* grp: Group - the group to check
* Returns: Boolean - true if the group is alive, false if not
* if a null group is passed in, false is returned
*/


private ["_grp", "_alive"];
_grp = [_this, grpNull, [grpNull]] call EF_fnc_singleParam;
if ({alive _x} count units _grp == 0) then
{
	_alive = false;
}
else
{
	_alive = true;
};
_alive