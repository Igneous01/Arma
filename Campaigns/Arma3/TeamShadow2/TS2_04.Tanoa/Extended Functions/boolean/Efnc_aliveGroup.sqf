/*
* Efnc_aliveGroup
* Tests to see whether the group is alive (has atleast 1 member alive)
* grpAlive = [grp] call Efnc_aliveGroup;
* grp: Group - the group to check
* Returns: Boolean - true if the group is alive, false if not
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