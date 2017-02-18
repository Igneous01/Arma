/*
	CONVOY MISSION TEMPLATE


*/

_pos = _this select 0;
_dir = _this select 1;
_veh_classes = _this select 2;
_taskDesc = _this select 3;

MISSION = createVehicle ["Land_HelipadEmpty_F", [0,0,0], [], 0, "NONE"];
_mission = MISSION;

// common attributes
_mission setVariable ["name", "Convoy"];
_mission setVariable ["task", taskNull];

// mission specific
_mission setVariable ["pos_start", _pos];



// ROAD LOOK UP
_endPos = [_pos, 6000, _dir] call EF_fnc_GetPosAtAngle;
_endRoad = [_endPos, 700] call BIS_fnc_nearestRoad;
if (isNull _endRoad) exitWith {hint "Error: Failed To Create Convoy mission: Road not found";};
_endPos = getpos _endRoad;
_mission setVariable ["pos_end", _endPos];

_mrk = ["convoyStart_mrk", "Last Known Location", _pos, "hd_arrow", "colorRed"] call fnc_createMarker;	// fnc_createMarker corrupts _pos
_mrk setMarkerDir _dir;
_mission setVariable ["mrk_convoy", _mrk];

//_dbg_mrk1 = ["convoy_dbg_mrk", "end Position", _endPos, "hd_arrow"] call fnc_createMarker;

_convoyData = [_veh_classes, _pos, _dir] call fnc_createConvoy;

//_dbg_mrk2 = ["convoy_dbg_unit", "unit", getpos ((_convoyData select 1) select 0)] call fnc_createMarker;

//_mission setVariable ["mrk_debug_1", _dbg_mrk1];
//_mission setVariable ["mrk_debug_2", _dbg_mrk2];

/*
[(_convoyData select 1) select 0, _dbg_mrk2] spawn
{
	while {true} do
	{
		sleep 1; (_this select 1) setMarkerPos getpos (_this select 0);
	};
};
*/

// waypoint
_wp = [_convoyData select 0, _endPos, 0, "MOVE", 100,
	{
		[MISSION getVariable "event_wp_complete", [MISSION]] call IGN_fnc_raiseEvent;
	}, [0, 0, 0]] call EF_fnc_createWP;


_mission setVariable ["grp_convoy", _convoyData select 0];
_mission setVariable ["target_vehicles", _convoyData select 1];	// keeps alive vehicles only
_mission setVariable ["array_objects", [_convoyData select 1]];
_mission setVariable ["array_groups", [_convoyData select 0]];

_mission setVariable ["task", player createSimpleTask ["Convoy"]];

(_mission getVariable "task") setSimpleTaskDescription [(_taskDesc select 0), (_taskDesc select 1), ""];


// Events
// fires when a target is destroyed/disabled (sends [missionObj, vehicleDestroyed])
_mission setVariable ["event_target_destroyed_single", [[objNull, objNull]] call IGN_fnc_createEvent];
// fires when all targets destroyed/disabled (sends [missionObj])
_mission setVariable ["event_targets_destroyed", [[objNull]] call IGN_fnc_createEvent];
// fires when convoy reaches waypoint (sends [missionObj])
_mission setVariable ["event_wp_complete", [[objNull]] call IGN_fnc_createEvent];


// Clean Up
_mission setVariable ["destroy",
{
	[EVENT_MISSION_CLEANUP, [MISSION]] call IGN_fnc_raiseEvent;
	deleteMarker (MISSION getVariable "mrk_convoy");
	//deleteMarker (MISSION getVariable "mrk_debug_1");
	//deleteMarker (MISSION getVariable "mrk_debug_2");
	[(MISSION getVariable "event_target_destroyed_single")] call IGN_fnc_DeleteEvent;
	[(MISSION getVariable "event_targets_destroyed")] call IGN_fnc_DeleteEvent;
	[(MISSION getVariable "event_wp_complete")] call IGN_fnc_DeleteEvent;

	[EVENT_MISSION_FAILED, MISSION getVariable "eh_failed"] call IGN_fnc_DeleteEventHandler;
	deleteVehicle MISSION;
	MISSION_IN_PROGRESS = false;
}];


// REGISTER HANDLERS

// EVENT SINGLE TARGET DESTROYED
[
	(_mission getVariable "event_target_destroyed_single"),
	{
		private ["_mission"];
		_mission = _this select 0;
		_vehicle = _this select 1;

		// call reinforcements
		if (!REINFORCEMENT_CALLED) then
		{
			if (REINFORCEMENT_CHANCE call fnc_chance) then
			{
				REINFORCEMENT_CALLED = true;
				[EVENT_REINFORCEMENT_CALLED, (getpos _vehicle)] call IGN_fnc_RaiseEvent;
			};
		};
	}
] call IGN_fnc_AddEventHandler;

// EVENT ALL TARGETS DESTROYED
[
	(_mission getVariable "event_targets_destroyed"),
	{
		private ["_mission"];
		_mission = _this select 0;

		[EVENT_MISSION_COMPLETED, [_mission, _mission getVariable "task"]] call IGN_fnc_RaiseEvent;
	}
] call IGN_fnc_AddEventHandler;

// EVENT WAYPOINT COMPLETE
[
	(_mission getVariable "event_wp_complete"),
	{
		private ["_mission"];
		_mission = _this select 0;
		_vehicle = (_mission getVariable "target_vehicles") select 0;

		[EVENT_MISSION_FAILED, [_mission, _mission getVariable "task"]] call IGN_fnc_RaiseEvent;
	}
] call IGN_fnc_AddEventHandler;

// MISSION FAILED
_ehFailedID = [
	EVENT_MISSION_FAILED,
	{
		onEachFrame {};
	}
] call IGN_fnc_AddEventHandler;

_mission setVariable ["eh_failed", _ehFailedID];

// onEachFrame
onEachFrameArgs = _mission;
onEachFrame
{
	_mission = onEachFrameArgs;

	// single target destroyed
	_v = (_mission getVariable "target_vehicles") call fnc_vehicleDisabledInCollection;
	if (!(isNull _v)) then
	{
		_tempArr = (_mission getVariable "target_vehicles") - [_v];	// remove element
		_mission setVariable ["target_vehicles", _tempArr];
		[_mission getVariable "event_target_destroyed_single", [_mission, _v]] call IGN_fnc_RaiseEvent;
	};

	// all targets destroyed
	if (count (_mission getVariable "target_vehicles") == 0) then
	{
		[_mission getVariable "event_targets_destroyed", [_mission]] call IGN_fnc_RaiseEvent;
		onEachFrame {};
	};
};


[EVENT_MISSION_CREATED,[_mission, _mission getVariable "task"]] call IGN_fnc_RaiseEvent;
