/*
* Efnc_createWP
* simplifies creating waypoints by passing all parameters into one call
* waypoint = [group, position, index number, type, (optional: completionRadius, {code to execute}, [timeout])] call Efnc_createWP
* group: Group - the group that gets the waypoint 
* position: array - format position 
* index number: integer - index of new waypoint 
* type: String - the type of waypoint (ex "MOVE", "SAD", "TR UNLOAD")
* Optional Parameters
* completionRadius: Number - radius in metres for waypoint to complete 
* {code to execute}: Code - code that will execute at waypoints activation - must be surrounded by code brackets {}
* [timeout]: Array format [min, med, max] - the timeout until the waypoint completes
* Example: wp = [group player, getpos player, 1, "MOVE", 150, {hint "you made it!"}, [0, 5, 10]] call Efnc_createWP
* returns: waypoint [group, index] format
*/

private ["_wp", "_grp", "_pos", "_index", "_type", "_completionRadius", "_statements", "_timeout"];
_grp = _this select 0;
_pos = _this select 1; // actual position, not object
_index = _this select 2; // waypoint index
_type = _this select 3; // ex "MOVE", "TR UNLOAD"

switch (count _this) do 
{
	case 5: 
	{
		_completionRadius = _this select 4; // number of metres
	};
	case 6:
	{
		_completionRadius = _this select 4;
		_statements = _this select 5; // code to execute (this is in code block);
	};
	case 7:
	{
		_completionRadius = _this select 4;
		_statements = _this select 5; 
		_timeout = _this select 6;
	};
};

// create waypoint
_wp = _grp addWaypoint [_pos, _index];
_wp setWaypointType _type;
if (!isNil "_completionRadius") then {
	_wp setWaypointCompletionRadius _completionRadius;
};
if (!isNil "_statements") then {
	private ["_string"];
	_string = format ["call %1", _statements];
	_wp setWaypointStatements ["true", _string];
};
if (!isNil "_timeout") then {
	_wp setWaypointTimeout _timeout;
};
// output
_wp
