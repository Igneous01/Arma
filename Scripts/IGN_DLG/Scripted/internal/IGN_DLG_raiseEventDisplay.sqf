/*
	raiseEventDisplay
	Internal function via execVM that raises event for display (onLoad, onUnLoad)
	Not Routed EVENTS!

	Not Recommended for use!
	author: Igneous01
*/
disableSerialization;	// required in order to pass display to routed event
params ["_event", "_args", "_displayID"];
// this strips the quotes off of the event string name, so that it becomes:
// _event = "SomeEvent" to _event = SomeEvent (which must be a valid variable holding a reference to an existing object)
_code = format ["_event = %1", _event];
call compile _code;
// need to add concurrency check here
waitUntil {!(_event getVariable "raised")};
[_event, [_args, _displayID]] call IGN_fnc_raiseEvent;