/*
	createEvent
	Creates an event object, allowing registration of handlers and raising
	Does not broadcast in multiplayer

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
	"raised" - a bool value determining if the event is currently being raised

	Example:
	myEvent = call IGN_fnc_createEvent;	// no args, no vehicle var name
	myEvent = [[objNull, []]] call IGN_fnc_createEvent; // will send arguments of type object (_this select 0) and array (_this select 1)
	[objNull, "myEvent"] call IGN_fnc_createEvent;	// myEvent can be referenced, will send argument of type object (_this)
	[[objNull], []], "myEvent"] call IGN_fnc_createEvent; // vehicle var name will be myEvent - can now reference myEvent in code

*/
//#include "IGN_LIB_macros.hpp";	not supported in A3 !

	private ["_arg_types", "_name", "_event"];
	if (!isNil {_this}) then
	{
		_arg_types = [_this, 0, []] call BIS_fnc_param;
		_name = [_this, 1, "", [""]] call BIS_fnc_param;
	}
	else
	{
		_name = "";
		_arg_types = [];
	};

	_event = createVehicle ["Land_HelipadEmpty_F", [0,0,0], [], 0, "NONE"];

	if (_name != "") then
	{
		_event setVehicleVarName _name;
		_event Call Compile Format ["%1=_This",_name];
	};

	[_event, _name, _arg_types] call IGN_fnc_initEvent;	// return event
