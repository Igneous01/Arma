/*
	getEventHandler
	returns the specified handler at the specified index

	Parameters
	event (object) - the event
	id (number) - index of handler

	Returns
	code

	Example
	handler = [myEvent, 0] call IGN_fnc_getEventHandler;	// returns first registered handler
*/

	private ["_event", "_index"];
	_event = _this select 0;
	_index = _this select 1;

	#ifdef IGN_LIB_DEBUG
	[_event, "IGN_fnc_getEventHandler"] call IGN_fnc_validateEvent;
	#endif

	(_event getVariable "handlers") select _index;	// return
