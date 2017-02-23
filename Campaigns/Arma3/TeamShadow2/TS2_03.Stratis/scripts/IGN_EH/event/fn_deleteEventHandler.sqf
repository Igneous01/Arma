/*
	deleteEventHandler
	removes a handler from the specified event

	Parameters
	event (object) - the event
	handleID (number) - event handler id

	Returns
	nothing

	Example
	[myEvent, handlerID] call IGN_fnc_deleteEventHandler;	// removes handlerID from myEvent
*/
#include "IGN_EH_Macros.h"

private ["_event", "_id", "_handlers"];
_event = _this select 0;
_id = [_this, 1, 0, [0]] call BIS_fnc_param;

#ifdef IGN_LIB_DEBUG
[_event, "IGN_fnc_deleteEventHandler"] call IGN_fnc_validateEvent;
diag_log text format ["IGN_EH: IGN_fnc_deleteEventHandler: deleting handler for event (%1) (handler owner: %2, event owner: %3)",
_event,
( (_event getVariable "handlers") select _id) select 0,
_event getVariable "owner"
];
#endif
(_event getVariable "handlers") deleteAt _id;
_handlers = (_event getVariable "handlers");
_event setVariable ["handlers", _handlers, (_event getVariable "broadcast")];

//if ((_event getVariable "broadcast")) then {publicVariable (_event getVariable "name");};