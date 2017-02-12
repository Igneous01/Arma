call compile preprocessFileLineNumbers "IGN_EH\IGN_EH_INIT.sqf";

// define an event, that accepts two parameters of type object
EVT_DETECTED = [[objNull, objNull], "EVT_DETECTED"] call IGN_fnc_createEvent;
// define a task changed event, which we will raise anytime the status of a task is changed
// parameters will be [obj - the player that owns the task, task - the task itself, status - string of status]
EVT_TASK_CHANGED = [[objNull, "", ""], "EVT_TASK_CHANGED"] call IGN_fnc_createEvent;

//diag_log text format ["init.sqf : Created Events (%1, %2) for client (%3)", EVT_DETECTED, EVT_TASK_CHANGED, clientOwner];
//diag_log text format ["init.sqf : vehicleVarName(%1) vehicleVarName(%2)", vehicleVarName EVT_DETECTED, vehicleVarName EVT_TASK_CHANGED];
//diag_log text "";
//diag_log text "";

// spawn a thread that monitors players spotted units, and raise event each time a new unit is spotted
_handle = [] spawn
{
	spottedList = [];
	while {alive player} do
	{
		{
			if (player knowsAbout _x > 0.1 && !(_x in spottedList)) then
			{
//				diag_log text format ["Raising (%1) for client (%2) with arguments (%3)", EVT_DETECTED, clientOwner, [player, _x]];
//				diag_log text "";
//				diag_log text "";
				[EVT_DETECTED, [player, _x]] call IGN_fnc_raiseEvent;	// pass the player and the unit to all listeners
				spottedList pushback _x;
				diag_log text format ["spottedList: %1", spottedList];

			};
			sleep 0.25;
		} foreach (allunits - [player]);
	};
};

// handlers for the detected event
handlerID1 = [EVT_DETECTED,
	{
		diag_log text format ["CLIENT(%1) handler invoked", clientOwner];
//		diag_log text "";
	}
] call IGN_fnc_addEventHandler;	// everytime event is raised, this hint will display

handlerID2 = [EVT_DETECTED,
	{
		private _unit = _this select 1;
		[
			_unit,
			{_this setUnitPos "MIDDLE";}
		] remoteExecCall ["bis_fnc_call", (owner _unit)];	// make them crouch
	}
] call IGN_fnc_addEventHandler;	// everytime event is raised, unit detected will crouch

handlerID3 = [EVT_DETECTED,
	{
		diag_log text format ["CLIENT(%1): DUMPING Event Object (%2)", clientOwner, EVT_DETECTED];
		diag_log text format ["CLIENT(%1) : name(%2) arg_types(%3) raised (%4) handlers (%5) broadcast (%6) owner (%7)",
		clientOwner,
		EVT_TASK_CHANGED getVariable "name",
		EVT_TASK_CHANGED getVariable "arg_types",
		EVT_TASK_CHANGED getVariable "raised",
		EVT_TASK_CHANGED getVariable "handlers",
		EVT_TASK_CHANGED getVariable "broadcast",
		EVT_TASK_CHANGED getVariable "owner"];
	//	diag_log text "";
	}
] call IGN_fnc_addEventHandler;	// everytime event is raised, this hint will display



// handlers for the task changed event
handlerTaskID = [EVT_TASK_CHANGED,
	{
//		diag_log text format ["Handler called for (%1), client (%2) with arguments (%3)", EVT_TASK_CHANGED, clientOwner, _this];
//		diag_log text "";
		private["_obj", "_task", "_status"];
		_obj = _this select 0;
		_task = _this select 1;
		_status = _this select 2;
		[_task, _status, true] spawn BIS_fnc_taskSetState;

		// create new task if task1 was completed
		if (_task == "TASK1") then
		{
			[west, "TASK3", ["Kill the Officer", "Kill the Officer", "hvt"],  getpos hvt, true] spawn BIS_fnc_taskCreate;
			hvt addEventHandler ["killed",
				{[EVT_TASK_CHANGED, [player, "TASK3", "SUCCEEDED"]] call IGN_fnc_raiseEvent;}
				];
		}
	}]
call IGN_fnc_addEventHandler;


SUITCASE addAction ["Pick up",
	{
		deleteVehicle (_this select 0);
		[EVT_TASK_CHANGED, [player, "TASK2", "SUCCEEDED"]] call IGN_fnc_raiseEvent;
	}];

/*
diag_log text format ["init.sqf : Dumping Event Data for %1", EVT_DETECTED];
diag_log text format ["init.sqf : IGN_EVENT_TYPE(%1) name(%2) arg_types(%3) raised (%4) handlers (%5) broadcast (%6) owner (%7)",
EVT_DETECTED getVariable "IGN_EVENT_TYPE",
EVT_DETECTED getVariable "name",
EVT_DETECTED getVariable "arg_types",
EVT_DETECTED getVariable "raised",
EVT_DETECTED getVariable "handlers",
EVT_DETECTED getVariable "broadcast",
EVT_DETECTED getVariable "owner"];
diag_log text "";
diag_log text "";
diag_log text "";

diag_log text format ["init.sqf : Dumping Event Data for %1", EVT_TASK_CHANGED];
diag_log text format ["init.sqf : IGN_EVENT_TYPE(%1) name(%2) arg_types(%3) raised (%4) handlers (%5) broadcast (%6) owner (%7)",
EVT_TASK_CHANGED getVariable "IGN_EVENT_TYPE",
EVT_TASK_CHANGED getVariable "name",
EVT_TASK_CHANGED getVariable "arg_types",
EVT_TASK_CHANGED getVariable "raised",
EVT_TASK_CHANGED getVariable "handlers",
EVT_TASK_CHANGED getVariable "broadcast",
EVT_TASK_CHANGED getVariable "owner"];
diag_log text "";
diag_log text "";
diag_log text "";

diag_log text format ["IGN_fnc_getEventHandlers for (%1) \n %2", EVT_DETECTED, [EVT_DETECTED] call IGN_fnc_getEventHandlers];
diag_log text "";
diag_log text "";
diag_log text "";

diag_log text format ["IGN_fnc_getEventHandlersClient for (%1) \n %2", EVT_DETECTED, [EVT_DETECTED, clientOwner] call IGN_fnc_getEventHandlersClient];
diag_log text "";
diag_log text "";
diag_log text "";
*/