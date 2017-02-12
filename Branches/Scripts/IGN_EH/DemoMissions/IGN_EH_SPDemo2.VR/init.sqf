// define an event, that accepts two parameters of type object
EVT_DETECTED = [[objNull, objNull], "EVT_DETECTED"] call IGN_fnc_createEvent;
// define a task changed event, which we will raise anytime the status of a task is changed
// parameters will be [obj - the player that owns the task, task - the task itself, status - string of status]
EVT_TASK_CHANGED = [[objNull, "", ""], "EVT_TASK_CHANGED"] call IGN_fnc_createEvent;

// spawn a thread that monitors players spotted units, and raise event each time a new unit is spotted
_handle = [] spawn
{
	spottedList = [];
	while {alive player} do
	{
		{
			if (player knowsAbout _x > 0.1 && !(_x in spottedList)) then
			{

				[EVT_DETECTED, [player, _x]] call IGN_fnc_raiseEvent;	// pass the player and the mine to all listeners
				spottedList pushback _x;

			};
			sleep 0.25;
		} foreach (allunits - [player]);
	};
};

// handlers for the detected event
handlerID1 = [EVT_DETECTED,
	{
		hint format ["Event [%1] raised [%2, %3]", EVT_DETECTED, _this select 0, _this select 1];
	}
] call IGN_fnc_addEventHandler;	// everytime event is raised, this hint will display

handlerID2 = [EVT_DETECTED,
	{
		(_this select 1) setUnitPos "MIDDLE";	// make them crouch
	}
] call IGN_fnc_addEventHandler;	// everytime event is raised, unit detected will crouch

handlerID3 = [EVT_DETECTED,
	{
		diag_log text format ["Event [%1] raised [%2, %3]", EVT_DETECTED, _this select 0, _this select 1];
	}
] call IGN_fnc_addEventHandler;	// everytime event is raised, this hint will display

// handlers for the task changed event
handlerTaskID = [EVT_TASK_CHANGED,
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