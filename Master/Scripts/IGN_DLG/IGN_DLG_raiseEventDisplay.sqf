/*
	raiseEventDisplay
	Internal function that raises event for display (onLoad, onUnLoad)
	Not Routed EVENTS!

	Not Recommended for use!
	author: Igneous01
*/

private ["_event", "_args"];
disableSerialization;	// required in order to pass display to routed event
_event = _this select 0;	// event name as string
_args = _this select 1;

//player sidechat format ["args: %1", _args];

_code = format ["_event = %1", _event];
call compile _code;

// need to add concurrency check here
waitUntil {!(_event getVariable "raised")};
[_event, _args] call IGN_fnc_raiseEvent;