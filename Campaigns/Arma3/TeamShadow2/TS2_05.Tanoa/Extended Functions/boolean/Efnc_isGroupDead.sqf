// EF_fnc_isGroupDead
// checks to see if all units in group are dead
// param - group
// returns true if all dead, false if not
// if group is null, returns true


_grp = [_this, grpNull, [grpNull]] call EF_fnc_singleParam;
({alive _x} count (units _grp)) == 0;

