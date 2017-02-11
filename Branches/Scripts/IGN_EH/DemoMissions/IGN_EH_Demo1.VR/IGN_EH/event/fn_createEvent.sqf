/*
	createEvent
	Creates an event object, allowing registration of handlers and raising
	Does not broadcast in multiplayer

	Parameters
	args (Array) (Optional) - Argument types that the event will send to all handlers
					default value - [] (no arguments)
	name (String) - The name of the event

	Returns
	The created event object, with these getters in its namespace:
	"name" - the name of the event (Argument passed)
	"handlers" - an array containing all handlers currently registered to the event
	"arg_types" - an array containing the argument types
	"raised" - a bool value determining if the event is currently being raised

	Example:
	myEvent = call IGN_fnc_createEvent;	// no args, no vehicle var name
	myEvent = [[objNull, []]] call IGN_fnc_createEvent; // will send arguments of type object (_this select 0) and array (_this select 1)
	[objNull, "myEvent"] call IGN_fnc_createEvent;	// myEvent can be referenced, will send argument of type object (_this)
	[[objNull], []], "myEvent"] call IGN_fnc_createEvent; // vehicle var name will be myEvent - can now reference myEvent in code

*/
//#include "IGN_LIB_macros.hpp";	not supported in A3 !

private ["_arg_types", "_name", "_broadcast"];
_arg_types = _this param [0, []];
_name = [_this, 1, "", [""]] call BIS_fnc_param;
_broadcast = _this param [3, false, ""];

#ifdef IGN_LIB_DEBUG
diag_log text format ["IGN_EH: IGN_fnc_createEvent called with %1", _this];
diag_log text format ["IGN_EH: IGN_fnc_createEvent arguments [%1, %2, %3]", _arg_types, _name, _broadcast];
#endif

private _event = createLocation ["NameLocal ", [0,0,0], 0, 0];
if (_broadcast) then
{
	publicVariable _event;	// broadcast that event was created
};
_event setVariable ["IGN_EVENT_TYPE", 0, _broadcast];		// event identifier
_event setVariable ["name", _name, _broadcast];
_event setVariable ["arg_types", _arg_types, _broadcast];
_event setVariable ["raised", false, _broadcast];			// asynchronous check
_event setVariable ["handlers", [], _broadcast];
_event setVariable ["broadcast", _broadcast, _broadcast];	// whether event object should broadcast on all changes
_event setVariable ["owner", clientOwner, _broadcast];	// server will be owner ID 0
if (_broadcast) then
{
	publicVariable _event;	// broadcast again -- may not be needed if setVariable broadcasts changes already
};

_event;