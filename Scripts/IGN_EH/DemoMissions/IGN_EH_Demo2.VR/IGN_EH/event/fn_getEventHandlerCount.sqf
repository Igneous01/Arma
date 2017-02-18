/*
	getEventHandlerCount
	returns the size of the handler array

	Parameters
	event (object) - the event

	Returns
	size (number)

	Example
	numHandles = myEvent call IGN_fnc_getEventHandlerCount;
*/

	private ["_event"];
	_event = _this;
	if (typename _event == typename []) then {_event = _this select 0;};

	#ifdef IGN_LIB_DEBUG
	[_event, "IGN_fnc_getEventHandlerCount"] call IGN_fnc_validateEvent;
	#endif

	count (_event getVariable "handlers");	// return
