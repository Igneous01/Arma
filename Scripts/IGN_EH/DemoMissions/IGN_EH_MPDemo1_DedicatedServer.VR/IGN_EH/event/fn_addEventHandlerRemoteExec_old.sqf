/*
	addEventHandler
	Adds a handler to the specified event, handlerID is returned

	Parameters
	event (object) - the event
	handle (code) - event handler code

	Returns
	handlerID (index of handler in this event)

	Example
	handlerID = [myEvent, {hint format ["%1", _this];}] call IGN_fnc_addEventHandler;	// everytime myEvent is raised, a hint will display the argument passed to the handler (assuming myEvent sends 1 argument or array)

	// Assuming myEvent was raised as such : [myEvent, ["weapon_class_tank_cannon", someTank]] call fnc_RaiseEvent;
	handlerID = [myEvent,
	{
		private ["_weaponName", "_tank"];
		_weaponName = _this select 0;		// raise of myEvent sends weapon string as arg 0
		_tank = _this select 1;				// tank object is sent as arg 1
		//...
	}] call IGN_fnc_addEventHandler;
*/
#include "IGN_EH_Macros.h"

//private ["_event", "_handle"];
private _event = _this select 0;
private _handle = [_this, 1, {}, [{}]] call BIS_fnc_param;

#ifdef IGN_LIB_DEBUG
[_event, "IGN_fnc_addEventHandler"] call IGN_fnc_validateEvent;
diag_log text format ["IGN_EH: called IGN_fnc_addEventHandler(%1)", _this];
#endif

private _broadcast = (_event getVariable "broadcast");
private _owner = (_event getVariable "owner");
private _ret = -1;

#ifdef IGN_LIB_DEBUG
diag_log text format ["IGN_EH: IGN_fnc_addEventHandler: event(name: %1, owner: %2, broadcast: %3)", _event, _owner, _broadcast];
#endif

// publicVariable does not work on locations, or any local objects that belong to a client. We must use remoteExec on the owner of the event
if (_broadcast && clientOwner != _owner) then
{

#ifdef IGN_LIB_DEBUG
diag_log text format ["IGN_EH: IGN_fnc_addEventHandler: event(%1) - handler owner (%2) != event owner (%3) - remoteExecuting addHandler on event owner machine",
_event, clientOwner, _owner];
#endif

 	// if we do not own this event, remoteExecute on the event owner machine, passing in the clientID of the machine that executed this code from
	_ret =
	[
		[_handle, _event, clientOwner],
		{
			params ["_handler", "_event", "_clientID"];

#ifdef IGN_LIB_DEBUG
diag_log text format ["IGN_EH: IGN_fnc_addEventHandler: remoteExecCall initiated on event owner(%1) for handler owner(%2)",
clientOwner, _clientID];
diag_log text format ["IGN_EH: IGN_fnc_addEventHandlerRemote: params(%1)", _this];
#endif

			private _handlers = (_event getVariable "handlers");
			_handlers pushback [_clientID, _handler];	// add handler
			_event setVariable["handlers", _handlers, (_event getVariable "broadcast")];
			count _handlers - 1;	// return
		}
	] remoteExecCall ["bis_fnc_call", _owner];
}
else
{

#ifdef IGN_LIB_DEBUG
diag_log text format ["IGN_EH: IGN_fnc_addEventHandler: event(%1) - handler owner (%2) == event owner (%3) - adding normally",
_event, clientOwner, _owner];
#endif

	private _handlers = (_event getVariable "handlers");
	_handlers pushback [clientOwner, _handle];
	_event setVariable["handlers", _handlers, _broadcast];
	_ret = count _handlers - 1;	// return id (not using getVariable here, as there is a chance that calling getVariable will return a different value in multithreaded environment like mp)
};

publicVariable (_event getVariable "name"); // not supported for locations

#ifdef IGN_LIB_DEBUG
diag_log text format ["IGN_EH: IGN_fnc_addEventHandler: handlerID(%1) handleOwner(%2) event(%3) eventOwner(%4)",
_ret, clientOwner, _event, _owner];

#endif
_ret;




