/*
	Internal Function via execVM
	compiles passed string into event vehicleVarName and raises the event, sending the arguments of the original event to all handlers

	Not Recommended for use!
	author: Igneous01
*/

private ["_event", "_args", "_displayID"];
disableSerialization;	// required in order to pass display to routed event
_event = _this select 0;	// event name as string
_args = _this select 1;



// required, since controls with handlers have no idea of what display is housing them
if (typename (_args select 0) == "CONTROL") then
{
	_displayID = ctrlIDD (ctrlParent (_args select 0));
}
else
{
	_displayID = ctrlIDD (_args select 0);
	//_displayID = _args select 0;
};

//player sidechat format ["args: %1", _args];

_code = format ["_event = %1", _event];
call compile _code;

// need to add concurrency check here
waitUntil {!(_event getVariable "raised")};
[_event, _displayID, _args] call IGN_fnc_raiseRoutedEvent;