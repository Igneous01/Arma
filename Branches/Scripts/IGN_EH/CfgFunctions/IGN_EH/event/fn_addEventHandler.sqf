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

	private ["_event", "_handle"];
	_event = _this select 0;
	_handle = [_this, 1, {}, [{}]] call BIS_fnc_param;

	#ifdef IGN_LIB_DEBUG
	[_event, "IGN_fnc_addEventHandler"] call IGN_fnc_validateEvent;
	#endif

	(_event getVariable "handlers") set [count (_event getVariable "handlers"), _handle];
	count (_event getVariable "handlers") - 1;	// return id
