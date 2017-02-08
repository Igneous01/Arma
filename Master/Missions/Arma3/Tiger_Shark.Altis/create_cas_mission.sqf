_cas_pos = _this select 0;
_radius = [_this, 1, 300, [0]] call BIS_fnc_param;	// default to 300
_target_types = [_this, 2, "Armor", ["", []]] call BIS_fnc_param;	// default to armor
_target_count = [_this, 3, 2, [0]] call BIS_fnc_param;	// default to 2
_targets_separate = [_this, 4, false, [true]] call BIS_fnc_param;	// default to false (targets will be grouped together)
_taskDesc = _this select 5;

MISSION = createVehicle ["Land_HelipadEmpty_F", [0,0,0], [], 0, "NONE"];
_mission = MISSION;

// common attributes
_mission setVariable ["name", "CAS"];

_mission setVariable ["task", player createSimpleTask ["CAS"]];
(_mission getVariable "task") setSimpleTaskDescription [(_taskDesc select 0), (_taskDesc select 1), ""];

_mission setVariable ["pos_cas", _cas_pos];
_mission setVariable ["mrk_cas", ["cas_mrk", "CAS", _cas_pos] call fnc_createMarker];

// create CAS targets
_cas_data = [_target_types, _target_count, _cas_pos, _radius, _targets_separate] call fnc_createCASTargets;

// Garbage Collector Use
_mission setVariable ["array_groups", _cas_data select 1];	// holds all groups, for Garbage Collection
_mission setVariable ["array_objects", _cas_data select 0]; // holds misc objects not bound to a group

_mission setVariable ["target_vehicles", _cas_data select 0];
_mission setVariable ["target_groups", _cas_data select 1];


// Events
// fires when a target is destroyed/disabled (sends [missionObj, vehicleDestroyed])
_mission setVariable ["event_target_destroyed_single", [[objNull, objNull]] call IGN_fnc_createEvent];
// fires when all targets destroyed/disabled (sends [missionObj])
_mission setVariable ["event_targets_destroyed", [[objNull]] call IGN_fnc_createEvent];

// Clean Up
_mission setVariable ["destroy",
{
	[EVENT_MISSION_CLEANUP, [MISSION]] call IGN_fnc_raiseEvent;
	deleteMarker (MISSION getVariable "mrk_cas");
	[(MISSION getVariable "event_target_destroyed_single")] call IGN_fnc_deleteEvent;
	[(MISSION getVariable "event_targets_destroyed")] call IGN_fnc_deleteEvent;
	[EVENT_MISSION_FAILED, MISSION getVariable "eh_failed"] call IGN_fnc_deleteEventHandler;
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
] call IGN_fnc_addEventHandler;

// EVENT ALL TARGETS DESTROYED
[
	(_mission getVariable "event_targets_destroyed"),
	{
		private ["_mission"];
		_mission = _this select 0;

		[EVENT_MISSION_COMPLETED, [_mission, _mission getVariable "task"]] call IGN_fnc_raiseEvent;
	}
] call IGN_fnc_addEventHandler;

// MISSION FAILED
_ehFailedID = [
	EVENT_MISSION_FAILED,
	{
		onEachFrame {};
	}
] call IGN_fnc_addEventHandler;

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
		[_mission getVariable "event_target_destroyed_single", [_mission, _v]] call IGN_fnc_raiseEvent;
	};

	// all targets destroyed
	if (count (_mission getVariable "target_vehicles") == 0) then
	{
		[_mission getVariable "event_targets_destroyed", [_mission]] call IGN_fnc_raiseEvent;
		onEachFrame {};
	};
};


[EVENT_MISSION_CREATED,[_mission, _mission getVariable "task"]] call IGN_fnc_raiseEvent;