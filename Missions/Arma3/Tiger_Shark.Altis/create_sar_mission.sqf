/*
SEARCH AND RESCUE MISSION TEMPLATE






*/

_pickUp_pos = _this select 0;
_dropOff_pos = _this select 1;
_radius = _this select 2;
_taskDesc = _this select 3;

MISSION = createVehicle ["Land_HelipadEmpty_F", [0,0,0], [], 0, "NONE"];
_mission = MISSION;

// common attributes
_mission setVariable ["name", "SAR"];

_mission setVariable ["task", taskNull];

// mission specific
_mission setVariable ["pos_pickUp", _pickUp_pos];
_mission setVariable ["pos_dropOff", _dropOff_pos];
_mission setVariable ["mrk_area", ["SARarea_mrk", "", _pickUp_pos, _radius] call fnc_createMarkerEllipse];
_mission setVariable ["mrk_pickUp", ["pickUp_mrk", "SAR", _pickUp_pos] call fnc_createMarker];
_mission setVariable ["mrk_dropOff", ["dropOff_mrk", "Drop Off", _dropOff_pos] call fnc_createMarker];

//_pickUp_pos = [_pickUp_pos, _radius] call fnc_placementRadiusGround;
_pickUp_pos = [[[_pickUp_pos, _radius]]] call BIS_fnc_randomPos;
_sarData = [_pickup_pos, _radius, (Mission_Dictionary getVariable "Wreck")] call fnc_createSARGroup;
_mission setVariable ["grp_pickUp", _sarData select 0];
_mission setVariable ["array_objects", [_sarData select 1]];
_mission setVariable ["array_groups", [_sarData select 0]];

// spawn enemies
_enemyGrps = [_pickUp_pos, 3, SAR_ENEMY_SPAWN_DIST] call fnc_spawnEnemyGroups;
_mission setVariable ["array_groups", (_mission getVariable "array_groups") + _enemyGrps];


_mission setVariable ["is_picked_up", false];
_mission setVariable ["task", player createSimpleTask ["SAR"]];

(_mission getVariable "task") setSimpleTaskDescription [(_taskDesc select 0), (_taskDesc select 1), ""];


// EVENTS
_mission setVariable ["event_pickUp", [[objNull, objNull]] call IGN_fnc_createEvent];
_mission setVariable ["event_squadLoaded", [[objNull]] call IGN_fnc_createEvent];
_mission setVariable ["event_dropOff", [[objNull, objNull]] call IGN_fnc_createEvent];



// TRIGGERS


// pickUp
_trg = createTrigger["EmptyDetector", _pickUp_pos];
_trg setTriggerArea[300,300,0,false];
_trg setTriggerActivation["EAST","PRESENT",false];
_trg setTriggerTimeout [2.5, 2.5, 2.5, true];
_trg setTriggerStatements["(vehicle player != player) && ((vehicle player) in thislist) && (isTouchingGround (vehicle player))",
"[MISSION getVariable 'event_pickUp', [vehicle player, MISSION]] call IGN_fnc_raiseEvent",
""];

_mission setVariable ["trg_pickUp", _trg];


// dropOff
_trg = createTrigger["EmptyDetector", _dropOff_pos];
_trg setTriggerArea[300,300,0,false];
_trg setTriggerActivation["EAST","PRESENT",false];
_trg setTriggerTimeout [0, 0, 0, true];
_trg setTriggerStatements["((vehicle player) in thislist) && (isTouchingGround (vehicle player)) && MISSION getVariable 'is_picked_up'",
"[MISSION getVariable 'event_dropOff', [vehicle player, MISSION]] call IGN_fnc_raiseEvent",
""];

_mission setVariable ["trg_dropOff", _trg];



// pickUpUnitsDead
_trg = createTrigger["EmptyDetector", [0,0,0]];
_trg setTriggerArea[0,0,0,false];
_trg setTriggerActivation["NONE","PRESENT",false];
_trg setTriggerTimeout [0, 0, 0, true];
_trg setTriggerStatements["MISSION getVariable 'grp_pickUp' call EF_fnc_groupDead",
"[EVENT_MISSION_FAILED, [MISSION, MISSION getVariable 'task']] call IGN_fnc_raiseEvent;",
""];

_mission setVariable ["trg_pickUpUnitsDead", _trg];


// squadLoaded
_trg = createTrigger["EmptyDetector", [0,0,0]];
_trg setTriggerArea[0,0,0,false];
_trg setTriggerActivation["NONE","PRESENT",false];
_trg setTriggerTimeout [0,0,0, true];
_trg setTriggerStatements["[MISSION getVariable 'grp_pickUp', vehicle player] call EF_fnc_groupInVehicle && !(MISSION getVariable 'grp_pickUp' call EF_fnc_groupDead)",
"[MISSION getVariable 'event_squadLoaded', [MISSION]] call IGN_fnc_raiseEvent;",
""];

_mission setVariable ["trg_squadLoaded", _trg];



/* NOT USABLE UNTIL BIS_fnc_addStackedEventHandler implements routing of arguments to calling function
// ON EACH FRAME
// pickUpUnitsDead
// squadLoaded
_id = ["onEachFrameId", "onEachFrame",
{
	private ["_missionObj"];
	_missionObj = _this select 0;
	_veh = vehicle player;
	_grp = _missionObj getVariable "grp_pickUp";
	hint format ["mission = %1      veh = %2         grp = %3              params = %4", _missionObj, _veh, _grp, _this];

	if (_grp call EF_fnc_groupDead) then
	{
		[_missionObj getVariable "event_failed", [_missionObj]] call fnc_RaiseEvent;
		[_id, "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
	}
	else
	{
		if ([_grp, _veh] call EF_fnc_groupInVehicle) then
		{
			[_missionObj getVariable "event_squadLoaded", [_missionObj]] call fnc_RaiseEvent;
			[_id, "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
		};
	};
}, [_mission, vehicle player]] call BIS_fnc_addStackedEventHandler;

_mission setVariable ["onEachFrame", _id];
*/



// CLEAN UP
_mission setVariable ["destroy",
{
	AA_WILL_SPAWN = true; // need this here in case mission fails
	[EVENT_MISSION_CLEANUP, [MISSION]] call IGN_fnc_raiseEvent;
	deleteMarker (MISSION getVariable "mrk_pickUp");
	deleteMarker (MISSION getVariable "mrk_dropOff");
	deleteMarker (MISSION getVariable "mrk_area");
	[(MISSION getVariable "event_pickUp")] call IGN_fnc_deleteEvent;
	[(MISSION getVariable "event_squadLoaded")] call IGN_fnc_deleteEvent;
	[(MISSION getVariable "event_dropOff")] call IGN_fnc_deleteEvent;
	//[(_this getVariable "event_failed")] call fnc_DeleteEvent;
	deleteVehicle (MISSION getVariable "trg_pickUp");
	deleteVehicle (MISSION getVariable "trg_dropOff");
	//[_this getVariable "onEachFrame", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
	deleteVehicle (MISSION getVariable "trg_pickUpUnitsDead");
	deleteVehicle (MISSION getVariable "trg_squadLoaded");
	deleteVehicle MISSION;
	MISSION_IN_PROGRESS = false;
}];




// REGISTER HANDLERS

// EVENT PICKED UP
[
	(_mission getVariable "event_pickUp"),
	{
		private ["_mission"];
		_vehicle = _this select 0;
		_mission = _this select 1;
		_group = _mission getVariable "grp_pickUp";

		// order ai squad into vehicle
		{_x assignAsCargo _vehicle} foreach units _group;
		{[_x] ordergetin true} foreach units _group;
		{_x disableAI "TARGET"; _x disableAI "AUTOTARGET";} foreach units _group;
		wp = _group addwaypoint [_vehicle,5,1];
		wp setwaypointType "GETIN";

		hint "friendlies are boarding...";
	}
] call IGN_fnc_addEventHandler;


// EVENT SQUAD LOADED
[
	(_mission getVariable "event_squadLoaded"),
	{
		(_this select 0) setVariable ["is_picked_up", true];
		hint "friendlies inside...";
		// Turn on AA spawning
		AA_WILL_SPAWN = true;
	}
] call IGN_fnc_addEventHandler;


// EVENT DROP OFF
[
	(_mission getVariable "event_dropOff"),
	{
		private ["_vehicle", "_mission", "_group", "_lz", "_task", "_wp"];
		_vehicle = _this select 0;
		_mission = _this select 1;
		_group = _mission getVariable "grp_pickUp";
		_lz = _mission getVariable "pos_dropOff";
		_task = _mission getVariable "task";

		// eject ai group, fiddle around with behaviour
		deleteWaypoint [_group,1];

		{_x action["eject", vehicle _x]} forEach units _group;
		{unAssignVehicle _x} forEach units _group;
		{_x enableAI "TARGET"; _x enableAI "AUTOTARGET";} foreach units _group;

		_wp = _group addwaypoint [_lz,5,1];
		_wp setwaypointType "MOVE";

		[EVENT_MISSION_COMPLETED, [_mission, _mission getVariable "task"]] call IGN_fnc_raiseEvent;
	}
] call IGN_fnc_addEventHandler;



[EVENT_MISSION_CREATED, [_mission, _mission getVariable "task"]] call IGN_fnc_raiseEvent;

// MISC
{ _x setUnitPos "MIDDLE"; } foreach units (_mission getVariable "grp_pickUp");
//((units (_mission getVariable "grp_pickUp")) select 0) allowDamage false;

// create fire/smoke
_eff = [_sarData select 1, ["fire", "smoke"] call BIS_fnc_selectRandom] call EF_fnc_createEffect;
(_mission getVariable "array_objects") set [count (_mission getVariable "array_objects"), _eff];

// turn off AA spawning
AA_WILL_SPAWN = false;

