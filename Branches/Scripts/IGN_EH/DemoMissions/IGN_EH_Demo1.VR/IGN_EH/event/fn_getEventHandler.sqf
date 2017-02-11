/*
	getEventHandler
	returns the specified handler at the specified index

	Parameters
	event (object) - the event
	id (number) - index of handler

	Returns
	[clientID,code]

	Example
	handler = [myEvent, 0] call IGN_fnc_getEventHandler;	// returns first registered handler
*/
params ["_event", "_index"];
#ifdef IGN_LIB_DEBUG
[_event, "IGN_fnc_getEventHandler"] call IGN_fnc_validateEvent;
#endif
(_event getVariable "handlers") select _index;	// return
