/*
	deleteEvent
	Deletes an existing event object

	Parameters
	event (object) - the event to be deleted

	Returns
	nothing

	Example:
	myEvent call IGN_fnc_deleteEvent;
	[myEvent] call IGN_fnc_deleteEvent;
*/

params ["_event"];
if (typename _event == typename []) then {_event = _this select 0;};

#ifdef IGN_LIB_DEBUG
[_event, "IGN_fnc_deleteEvent"] call IGN_fnc_validateEvent;
#endif

deleteLocation _event;	// test to make sure this command is global
