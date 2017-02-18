/*
	Internal Function via execVM
	compiles passed string into event vehicleVarName and raises the event, sending the arguments of the original event to all handlers

	Not Recommended for use!
	author: Igneous01
*/

disableSerialization;	// required in order to pass display to routed event
params ["_event", "_args"];

private _displayID = 0;
// required, since controls with handlers have no idea of what display is housing them
if (typename (_args select 0) == "CONTROL") then
{
	_displayID = ctrlIDD (ctrlParent (_args select 0));
}
else
{
	_displayID = ctrlIDD (_args select 0);
};

// this strips the quotes off of the event string name, so that it becomes:
// _event = "SomeEvent" to _event = SomeEvent (which must be a valid variable holding a reference to an existing object)
_code = format ["_event = %1", _event];
call compile _code;

// need to add concurrency check here
waitUntil {!(_event getVariable "raised")};
[_event, _displayID, _args] call IGN_fnc_raiseRoutedEvent;