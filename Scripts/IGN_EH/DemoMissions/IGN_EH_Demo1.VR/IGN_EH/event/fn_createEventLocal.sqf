/*
	createEventLocal
	Creates a local event object using CreateVehicleLocal (not broadcasted in MP), allowing registration of handlers and raising
	Does not broadcast the object in multiplayer

	Parameters
	name (Optional) - The name of the object (this will set the vehicle's variable name)
						default value - "" (no name)

	Returns
	The created event object, with these getters in its namespace:
	"name" - the name of the event (Argument passed)
	"handlers" - an array containing all handlers currently registered to the event

	Example:
	myEvent = call IGN_fnc_createEventLocal;	// no args, no vehicle var name
	myEvent = [[objNull, []]] call IGN_fnc_createEventLocal; // will send arguments of type object (_this select 0) and array (_this select 1)
	[[objNull], []], "myEvent"] call IGN_fnc_createEventLocal; // vehicle var name will be myEvent
*/

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

	_event = "Land_HelipadEmpty_F" createVehicleLocal [0,0,0];

	if (_name != "") then
	{
		_event setVehicleVarName _name;
		_event Call Compile Format ["%1=_This;",_name];
	};

	[_event, _name, _arg_types] call IGN_fnc_initEvent;	// return event
