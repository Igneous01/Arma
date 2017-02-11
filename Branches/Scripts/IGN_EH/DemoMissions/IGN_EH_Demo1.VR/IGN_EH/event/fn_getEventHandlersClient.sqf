/*
	getEventHandlersClient
	returns a collection of handlers in format [[clientID, code]] that belong to the specified client

	Parameters
	event (object) - the event
	clientID (number) - clientID

	Returns
	array of [clientID,code]

	Example
	handlers = [myEvent, 0] call IGN_fnc_getEventHandler;	// returns handlers registered to server
*/
params ["_event", "_clientID"];
#ifdef IGN_LIB_DEBUG
[_event, "IGN_fnc_getEventHandler"] call IGN_fnc_validateEvent;
#endif
private _handlers = [];
{
	private _cID = _x select 0;
	private _code = _x select 1;
	if (_cID == _clientID) then
	{
		_handlers pushback _x;
	};
} (_event getVariable "handlers");

_handlers;