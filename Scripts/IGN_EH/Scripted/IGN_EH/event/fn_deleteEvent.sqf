/*
	deleteEvent
	Deletes an existing event object
	If an invalid event object is passed, it will not be deleted

	Parameters
	event (object) - the event to be deleted

	Returns
	nothing

	Example:
	_wasDeleted = myEvent call IGN_fnc_deleteEvent;
	_wasDeleted = [myEvent] call IGN_fnc_deleteEvent;
*/

	private ["_event"];
	_event = _this;
	if (typename _event == typename []) then {_event = _this select 0;};

	#ifdef IGN_LIB_DEBUG
	[_event, "IGN_fnc_deleteEvent"] call IGN_fnc_validateEvent;
	#endif

	deleteVehicle _event;
