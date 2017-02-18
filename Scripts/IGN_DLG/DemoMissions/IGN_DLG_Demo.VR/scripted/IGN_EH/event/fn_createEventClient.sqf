
/*
	createEventClient
	Creates an event object on the client(s) only, allowing registration of handlers and raising
	Does not broadcast the object in multiplayer

	Parameters
	args (Array) (Optional) - Argument types that the event will send to all handlers
						default value - [] (no arguments)
	name (String) (Optional) - The name of the object (this will set the vehicle's variable name)
						default value - "" (no name)

	Returns
	The created event object, with these getters in its namespace:
	"name" - the name of the event (Argument passed)
	"handlers" - an array containing all handlers currently registered to the event
	"arg_types" - an array containing the argument types

	Example:
	myEvent = call IGN_fnc_createEventClient;	// no args, no vehicle var name
	myEvent = [[objNull, []]] call IGN_fnc_createEventClient; // will send arguments of type object (_this select 0) and array (_this select 1)
	[[objNull], []], "myEvent"] call IGN_fnc_createEventClient; // vehicle var name will be myEvent
*/

	if (isServer) exitWith {};
	private ["_name"];
	_name = [_this, 0, "", [""]] call BIS_fnc_param;
	_name call IGN_fnc_createEvent;
