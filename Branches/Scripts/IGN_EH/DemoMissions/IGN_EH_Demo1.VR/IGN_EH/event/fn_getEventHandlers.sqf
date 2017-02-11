/*
	getEventHandlers
	returns the array of all event handlers registered to the current event

	Parameters
	event (object) - the event

	Returns
	array of [clientID, code]

	Example
	allHandlers = myEvent call IGN_fnc_getEventHandlers;
*/

params ["_event"];
if (typename _event == typename []) then {_event = _this select 0;};
#ifdef IGN_LIB_DEBUG
[_event, "IGN_fnc_getEventHandlers"] call IGN_fnc_validateEvent;
#endif
_event getVariable "handlers";	// return
