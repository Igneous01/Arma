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
#include "IGN_EH_Macros.h"

//#include "IGN_LIB_macros.hpp";	not supported in A3 !
private ["_arg_types", "_name", "_broadcast"];
_arg_types = param [0, []];
_name = [_this, 1, "", [""]] call BIS_fnc_param;
_broadcast = param [2, false, [false]];

#ifdef IGN_LIB_DEBUG
diag_log text format ["IGN_EH: IGN_fnc_createEvent called with %1", _this];
#endif

//private _event = createLocation ["Name", [0,0,0], 0, 0];
private _event = createVehicle ["Land_HelipadEmpty_F", [0,0,0], [], 0, "NONE"];

#ifdef IGN_LIB_DEBUG
diag_log text format ["IGN_EH: IGN_fnc_createEvent: event object created (%1) - setting vehicleVarName", _event];
#endif


if (_broadcast) then
{
#ifdef IGN_LIB_DEBUG
diag_log text format ["IGN_EH: IGN_fnc_createEvent: event(%1) has broadcasting enabled - remoteExecCall setVehicleVarName on all machines"];
#endif

	_event setVehicleVarName _name;
	publicVariable _name;
	// setVehicleVarName on each machine
	[[_event, _name], {(_this select 0) setVehicleVarName (_this select 1);}] remoteExecCall ["bis_fnc_call", 0];
	publicVariable _name;
}
else
{
	_event setVehicleVarName _name;
};

_event setVariable ["IGN_EVENT_TYPE", 0, _broadcast];		// event identifier
_event setVariable ["name", _name, _broadcast];
_event setVariable ["arg_types", _arg_types, _broadcast];
_event setVariable ["raised", false, _broadcast];			// asynchronous check
_event setVariable ["handlers", [], _broadcast];
_event setVariable ["broadcast", _broadcast, _broadcast];	// whether event object should broadcast on all changes
_event setVariable ["owner", clientOwner, _broadcast];	// server will be owner ID 0

#ifdef IGN_LIB_DEBUG
diag_log text format ["IGN_EH: IGN_fnc_createEvent: obj vehicleVarName set to (%1) event (%2)", _name, _event];
diag_log text format ["IGN_EH: IGN_fnc_createEvent: event(%1) created with the following properties (IGN_EVENT_TYPE: %2, name: %3, arg_types: %4, raised: %5, handlers: %6, broadcast: %7, owner: %8)",
	_event,
	_event getVariable "IGN_EVENT_TYPE",
	_event getVariable "name",
	_event getVariable "arg_types",
	_event getVariable "raised",
	_event getVariable "handlers",
	_event getVariable "broadcast",
	_event getVariable "owner"];
#endif

_event;