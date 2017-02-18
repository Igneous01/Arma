call compile preprocessFileLineNumbers "IGN_EH\IGN_EH_INIT.sqf";

if (isServer) then
{
	// DECLARE a global broadcasting variable that will track all spotted units by all clients
	GSERVER_SPOTTED_UNITS = [];
	GSERVER_ALL_AI_UNITS = allunits;
	{
		if (isPlayer _x) then
		{
			GSERVER_ALL_AI_UNITS = GSERVER_ALL_AI_UNITS - [_x];
		};
	} forEach playableUnits;

	publicVariable "GSERVER_SPOTTED_UNITS";
	publicVariable "GSERVER_ALL_AI_UNITS";

	diag_log text format["GSERVER_SPOTTED_UNITS(count: %1) GSERVER_ALL_AI_UNITS(count: %2)",
	count GSERVER_SPOTTED_UNITS, count GSERVER_ALL_AI_UNITS];

	// define the task changed event on the server, since all players should be notified of this event
	// this is a broadcasting event
	// parameters will be [obj - the player that owns the task, task - the task itself, status - string of status]
	SERVER_EVT_TASK_CHANGED = [[objNull, "", ""], "SERVER_EVT_TASK_CHANGED", true] call IGN_fnc_createEvent;

	// server handler
	// the server handler doesn't have it's own tasks, so it simply adds the killed handler on the hvt (which it owns) so that the TASK_CHANGED event will propogate to clients when that unit is killed
	serverTaskChangedHandler = [SERVER_EVT_TASK_CHANGED,
	{
		private["_obj", "_task", "_status"];
		_obj = _this select 0;
		_task = _this select 1;
		_status = _this select 2;

		// display a hint to all clients which player completed the task
		[
			[_obj, _task, _status],
			{
				hint format ["player %1 updated task %2 to status %3",
				(_this select 0), (_this select 1), (_this select 2)];
			}
		] remoteExecCall ["bis_fnc_call", 0];

		// add killed event handler to unit
		if (_task == "TASK1") then
		{
			hvt addEventHandler ["killed", {[SERVER_EVT_TASK_CHANGED, [_this select 1, "TASK3", "SUCCEEDED"]] call IGN_fnc_raiseEvent;}];
		}
	}]
	call IGN_fnc_addEventHandler;
};


// the detected event is created on clients only, as each client may detect different units
if (!isServer) then
{
	// define an event, that accepts two parameters of type object
	CLIENT_EVT_DETECTED = [[objNull, objNull], "CLIENT_EVT_DETECTED"] call IGN_fnc_createEvent;

	// handlers for the detected event - these just do some logging for now
	clientHandlerID1 = [CLIENT_EVT_DETECTED,
		{
			params["_playerObj", "_unit"];
			diag_log text format ["CLIENT(%1): spotted unit %2", clientOwner, _unit];
			[ _unit,	{_this setUnitPos "MIDDLE";} ] remoteExecCall ["bis_fnc_call", (owner _unit)];	// make them crouch
		}
	] call IGN_fnc_addEventHandler;	// everytime event is raised, this hint will display

	clientHandlerID2 = [CLIENT_EVT_DETECTED,
		{
			diag_log text format ["CLIENT(%1): DUMPING Event Object (%2)", clientOwner, CLIENT_EVT_DETECTED];
			diag_log text format ["CLIENT(%1): name(%2) arg_types(%3) raised (%4) handlers (%5) broadcast (%6) owner (%7)",
			clientOwner,
			CLIENT_EVT_DETECTED getVariable "name",
			CLIENT_EVT_DETECTED getVariable "arg_types",
			CLIENT_EVT_DETECTED getVariable "raised",
			CLIENT_EVT_DETECTED getVariable "handlers",
			CLIENT_EVT_DETECTED getVariable "broadcast",
			CLIENT_EVT_DETECTED getVariable "owner"];
			//	diag_log text "";
		}
	] call IGN_fnc_addEventHandler;	// everytime event is raised, this hint will display

	// handlers for the task changed event
	// updates client tasks
	clientHandlerTaskChanged = [SERVER_EVT_TASK_CHANGED,
	{
		private["_obj", "_task", "_status"];
		_obj = _this select 0;
		_task = _this select 1;
		_status = _this select 2;
		[_task, _status, true] spawn BIS_fnc_taskSetState;

		// create new task if task1 was completed
		if (_task == "TASK1") then
		{
			[west, "TASK3", ["Kill the Officer", "Kill the Officer", "hvt"],  getpos hvt, true] spawn BIS_fnc_taskCreate;
		}
	}]
	call IGN_fnc_addEventHandler;

	// spawn a thread that monitors players spotted units, and raise event each time a new unit is spotted
	_handle = [] spawn
	{
		while {alive player} do
		{
			{
				if (player knowsAbout _x > 0.1 && !(_x in GSERVER_SPOTTED_UNITS)) then
				{
					[CLIENT_EVT_DETECTED, [player, _x]] call IGN_fnc_raiseEvent;	// pass the player and the unit to all listeners
					GSERVER_SPOTTED_UNITS pushback _x;
					publicVariable "GSERVER_SPOTTED_UNITS";

					diag_log text format ["GSERVER_SPOTTED_UNITS: %1", GSERVER_SPOTTED_UNITS];
				};
				sleep 0.25;
			} foreach (allunits - [player]);
		};

		// if player is dead, remove handler
		[SERVER_EVT_TASK_CHANGED, clientHandlerTaskChanged] call IGN_fnc_deleteEventHandler;
	};


	SUITCASE addAction ["Pick up",
	{
		deleteVehicle (_this select 0);
		[SERVER_EVT_TASK_CHANGED, [player, "TASK2", "SUCCEEDED"]] call IGN_fnc_raiseEvent;
	}];
};


