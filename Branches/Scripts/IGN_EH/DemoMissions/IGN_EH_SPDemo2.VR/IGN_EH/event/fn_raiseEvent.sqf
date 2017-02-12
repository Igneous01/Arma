/*
	raiseEvent
	Raises an existing event, calling all handlers in sequence with specified arguments
	When an event object is raised, it will set its namespace attribute "raised" to true, until all handlers calls are finished
	When all handlers have received the event, the attribute "raised" will be set to false

	Parameters
	event (object) - the event to be raised
	arguments (anything) (optional) - the arguments to be passed to each handler
						default value - [] (no arguments will be passed)

	Returns
	nothing

	Example
	[myEvent] spawn IGN_fnc_raiseEvent;	// raises myEvent, no arguments are passed to handlers
	myEvent spawn IGN_fnc_raiseEvent;	// same as above, but without array brackets
	[myEvent, [myString, myTank]] spawn IGN_fnc_raiseEvent;	// raises myEvent, passes myString as (_this select 0), myTank as (_this select 1) to all handlers
	[myEvent, myTank] spawn IGN_fnc_raiseEvent;	// raises myEvent, passes myTank as _this to all handlers


	****** dealing with ASYNCHRONOUS/NON-SCHEDULED/THREADED calls to an event

	This is particularly useful if you have spawn 'ed threads that may raise the event and want to synchronize calls

	Example of Unsafe non-scheduled calls to an event:

	// thread 1 only tracks player death
	_thread_1 = spawn {
		waitUntil {!alive player};
		[eventUnitDead, player] spawn IGN_fnc_raiseEvent;	// this can be called at the same time as the other one!
	};

	// thread 2 tracks any dead in enemyUnits
	_thread_2 = spawn {
		private ["_grpAliveCount"];
		_grpAliveCount = count enemyUnits;
		while {_grpAliveCount > 0} do
		{
			{
				if (!alive _x) then
				{
					_grpAliveCount = _grpAliveCount - 1;
					[eventUnitDead, _x] spawn IGN_fnc_raiseEvent;	// this can be called at the same time as the other one!
				};
			} foreach enemyUnits;
		};
	};

	// Potential for thread 1 and thread 2 to raise eventUnitDead at the same time! not safe!

	Example of safer non-scheduled calls to an event

	Here is a safer way of doing the above:

	// thread 1 only tracks player death
	_thread_1 = spawn {
		waitUntil {!alive player};
		waitUntil {!(eventUnitDead getVariable "raised")};	// block thread if event is busy
		[eventUnitDead, player] spawn IGN_fnc_raiseEvent;
	};

	// thread 2 tracks any dead in enemyUnits
	_thread_2 = spawn {
		private ["_grpAliveCount"];
		_grpAliveCount = count enemyUnits;
		while {_grpAliveCount > 0} do
		{
			{
				if (!alive _x) then
				{
					_grpAliveCount = _grpAliveCount - 1;
					waitUntil {!(eventUnitDead getVariable "raised")};	// block thread if event is busy
					[eventUnitDead, _x] spawn IGN_fnc_raiseEvent;
				};
			} foreach enemyUnits;
		};
	};
	******
*/
#include "IGN_EH_Macros.h"

private ["_event", "_params"];
if (typename _this == typename []) then
{
	_event = _this select 0;
	_params = [_this, 1, []] call BIS_fnc_param;
}
else
{
	_event = _this;
	_params = [];
};

#ifdef IGN_LIB_DEBUG
[_event, "fnc_raiseEvent"] call IGN_fnc_validateEvent;
[_event, _params, "fnc_raiseEvent"] call IGN_fnc_validateEventArgs;
diag_log text format ["IGN_EH: IGN_fnc_raiseEvent: Event (%1) raised by client(%2) with arguments (%3)", _event, clientOwner, _params];
#endif

private _broadcast = (_event getVariable "broadcast");
private _owner = (_event getVariable "owner");

_event setVariable ["raised", true, _broadcast];
//if (_broadcast) then {publicVariable "_event";};

if (_broadcast) then
{
	{
		private _clientID = _x select 0;
		private _handler = _x select 1;

#ifdef IGN_LIB_DEBUG
diag_log text format ["IGN_EH: IGN_fnc_raiseEvent: handler for (%1) (handlerOwner(%2), eventOwner(%3), code(%4)",
_event, _clientID, _owner, _handler];
#endif

		if (_clientID == _owner) then
		{

#ifdef IGN_LIB_DEBUG
diag_log text format ["IGN_EH: IGN_fnc_raiseEvent: (%1) handlerOwner(%2) == eventOwner(%3) - calling handler normally",
_event, _clientID, _owner];
#endif

			_params call _handler;
		}
		else
		{

#ifdef IGN_LIB_DEBUG
diag_log text format ["IGN_EH: IGN_fnc_raiseEvent: (%1) handlerOwner(%2) != eventOwner(%3) - remoteExecCall on handler owner machine",
_event, _clientID, _owner];
#endif

			[_params, _handler] remoteExecCall ["bis_fnc_call", _clientID];
		};
	} foreach (_event getVariable "handlers");
}
else
{
	{
		private _clientID = _x select 0;
		private _handler = _x select 1;

#ifdef IGN_LIB_DEBUG
diag_log text format ["IGN_EH: IGN_fnc_raiseEvent: Calling handler for (%1) (handlerOwner(%2), eventOwner(%3), code(%4)",
_event, _clientID, _owner, _handler];
#endif

		_params call _handler;
	} foreach (_event getVariable "handlers");
};

_event setVariable ["raised", false, _broadcast];	// return nothing
//if (_broadcast) then {publicVariable "_event";};
