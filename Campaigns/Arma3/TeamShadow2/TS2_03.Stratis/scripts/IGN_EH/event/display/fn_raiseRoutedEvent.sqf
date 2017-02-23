/*
	raiseRoutedEvent
	Raises a routed event, calling all handlers that belong to the dialog/display in sequence with specified arguments
	When an event object is raised, it will set its namespace attribute "raised" to true, until all handlers calls are finished
	When all handlers have received the event, the attribute "raised" will be set to false

	Parameters
	event (object) - the event to be raised
	display (display idd) - the Display ID
	arguments (anything) (optional) - the arguments to be passed to each handler
						default value - [] (no arguments will be passed)

	Returns
	nothing

	Example
	[myEvent, myDisplay] call IGN_fnc_raiseRoutedEvent;	// raises myEvent to myDisplay, no arguments are passed to handlers
	[myEvent, myDisplay, [myString, myTank]] call IGN_fnc_raiseRoutedEvent;	// raises myEvent to myDisplay, passes myString as (_this select 0), myTank as (_this select 1) to all handlers
	[myEvent, 10000, myTank] call IGN_fnc_raiseRoutedEvent;	// raises myEvent to dialog 10000, passes myTank as _this to all handlers


*/
#include "IGN_EH_Macros.h"

#ifdef IGN_LIB_DEBUG
if (typename _this != typename []) then
{
	diag_log text format ["IGN_DLG Error: Parameter mismatch in function IGN_fnc_raiseRoutedEvent (Args: %1)", _this];
};
#endif

private ["_event", "_display", "_params"];
_event = _this select 0;
_display = _this select 1;
if (count _this > 2) then
{
	_params = _this select 2;
}
else
{
	_params = [];
};

#ifdef IGN_LIB_DEBUG
[_event, "fnc_RaiseEvent"] call IGN_fnc_validateEvent;
[_event, _params, "fnc_RaiseEvent"] call IGN_fnc_validateEventArgs;
#endif

// handlers looks like this : [
//								[displayIDD, {handlerCode}],
//								[displayIDD, {handlerCode}]
//							  ]

_event setVariable ["raised", true];

// This will explode if the wrong type of arguments are passed in
{
	if ( (_x select 0) == _display ) then
	{
		_params call (_x select 1);
	};
} foreach (_event getVariable "handlers");

_event setVariable ["raised", false];	// return nothing