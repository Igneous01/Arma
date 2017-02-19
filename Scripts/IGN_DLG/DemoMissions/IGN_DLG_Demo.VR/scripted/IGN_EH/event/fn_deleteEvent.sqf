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
#include "IGN_EH_Macros.h"

params ["_event"];
if (typename _event == typename []) then {_event = _this select 0;};

#ifdef IGN_LIB_DEBUG
[_event, "IGN_fnc_deleteEvent"] call IGN_fnc_validateEvent;
diag_log text format ["IGN_EH: IGN_fnc_deleteEvent: Deleting event (%1)", _event];
#endif

//deleteLocation _event;	// test to make sure this command is global
deleteVehicle _event;