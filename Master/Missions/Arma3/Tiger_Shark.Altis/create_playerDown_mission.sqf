/*
	Player Chopper Down Mission Template



*/

_posPickUp = _this select 0;
_posDropOff = _this select 1;
_crew = _this select 2;
_taskDesc = _this select 3;

// merge crew into single group
{
	if (group _x != group player) then
	{
		[_x] joinSilent (group player);
	};
} foreach (_crew - [_crew select 0]);	// assuming _crew select 0 is player


MISSION = createVehicle ["Land_HelipadEmpty_F", [0,0,0], [], 0, "NONE"];
_mission = MISSION;

// common attributes
_mission setVariable ["name", "playerDown"];
_mission setVariable ["task", taskNull];

// mission specific
_mission setVariable ["pos_pickUp", _posPickUp];
_mission setVariable ["pos_dropOff", _posDropOff];
_mission setVariable ["mrk_pickUp", ["pickUp_mrk", "Chopper Down", _posPickUp] call fnc_createMarker];

_mission setVariable ["array_crew", _crew];
_mission setVariable ["grp_pickUp", (group player)];
_mission setVariable ["array_objects", []];
_mission setVariable ["array_groups", []];		// needs to be tweaked to not include player and gunner (if alive)


_mission setVariable ["is_picked_up", false];
_mission setVariable ["task", player createSimpleTask ["playerDown"]];
(_mission getVariable "task") setSimpleTaskDescription [(_taskDesc select 0), (_taskDesc select 1), ""];


// SAR HELO SPAWN
_heloSpawnPos = [_posPickUp, PLAYERDOWN_RESCUE_SPAWN_DIST, (random 359)] call EF_fnc_getPosAtAngle;
_heloSpawnPos = _heloSpawnPos - [(_heloSpawnPos select 2)];	// remove Z so BIS_fnc_spawnVehicle creates it in FLYING
_SARHELODATA = [_heloSpawnPos, 0, "O_Heli_Light_02_F", EAST] call bis_fnc_spawnvehicle;
(_SARHELODATA select 0) setCaptive true;	// Chopper belongs to CIVILIAN SIDE!
(_SARHELODATA select 2) allowFleeing 0;
(_SARHELODATA select 2) setCombatMode "BLUE";


// MISSION DATA SETTING
_mission setVariable ["helicopter", _SARHELODATA select 0];
_mission setVariable ["grp_helicopter", _SARHELODATA select 2];


// WAYPOINTS
[_mission getVariable "grp_helicopter", _posPickUp, 1, "MOVE", 500] call EF_fnc_createWP;
[_mission getVariable "grp_helicopter", _posPickUp, 2, "MOVE", 600,
{
	(vehicle this) land "LAND";
	[MISSION getVariable "event_pickUp", [_mission getVariable "helicopter", _mission]] call IGN_fnc_raiseEvent;
}] call EF_fnc_createWP;


// ENEMY SPAWN
_enemyGrps = [_posPickUp, ([0, 1, 2] call BIS_fnc_selectRandom), PLAYERDOWN_ENEMY_SPAWN_DIST] call fnc_spawnEnemyGroups;
_mission setVariable ["array_groups", (_mission getVariable "array_groups") + _enemyGrps];


// EVENTS
//_mission setVariable ["event_time", [ [objNull, []] ] call IGN_fnc_createEvent];	// sends [missionObj, crewArray]
_mission setVariable ["event_pickUp", [[objNull, objNull]] call IGN_fnc_createEvent];
_mission setVariable ["event_squadLoaded", [[objNull]] call IGN_fnc_createEvent];
_mission setVariable ["event_dropOff", [[objNull, objNull]] call IGN_fnc_createEvent];



// TRIGGERS

// NOT WORKING!!! isTouchingGround does not recognize airfield as ground!
// dropOff
_trg = createTrigger["EmptyDetector", _posDropOff];
_trg setTriggerArea[300,300,0,false];
_trg setTriggerActivation["CIV","PRESENT",false];
_trg setTriggerTimeout [0, 0, 0, true];
_trg setTriggerStatements["((vehicle player) in thislist) && (isTouchingGround (vehicle player)) && MISSION getVariable 'is_picked_up'",
"[MISSION getVariable 'event_dropOff', [(MISSION getVariable 'helicopter'), MISSION]] call IGN_fnc_raiseEvent",
""];

_mission setVariable ["trg_dropOff", _trg];


// squadLoaded
_trg = createTrigger["EmptyDetector", [0,0,0]];
_trg setTriggerArea[0,0,0,false];
_trg setTriggerActivation["NONE","PRESENT",false];
_trg setTriggerTimeout [0,0,0, true];
_trg setTriggerStatements["[MISSION getVariable 'grp_pickUp', (MISSION getVariable 'helicopter')] call EF_fnc_groupInVehicle",
"[MISSION getVariable 'event_squadLoaded', [MISSION]] call IGN_fnc_raiseEvent;",
""];

_mission setVariable ["trg_squadLoaded", _trg];


// SARHELO Killed/Unable to fly
_trg = createTrigger["EmptyDetector", [0,0,0]];
_trg setTriggerArea[0,0,0,false];
_trg setTriggerActivation["NONE","PRESENT",false];
_trg setTriggerTimeout [0,0,0, true];
_trg setTriggerStatements["!alive (MISSION getVariable 'helicopter') || !canMove (MISSION getVariable 'helicopter')",
"[EVENT_MISSION_FAILED, [MISSION]] call IGN_fnc_raiseEvent;",
""];

_mission setVariable ["trg_SARFailed", _trg];




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
	[EVENT_MISSION_CLEANUP, [MISSION]] call IGN_fnc_raiseEvent;
	deleteMarker (MISSION getVariable "mrk_pickUp");
	[(MISSION getVariable "event_pickUp")] call IGN_fnc_deleteEvent;
	[(MISSION getVariable "event_squadLoaded")] call IGN_fnc_deleteEvent;
	[(MISSION getVariable "event_dropOff")] call IGN_fnc_deleteEvent;
	//[(_this getVariable "event_failed")] call fnc_DeleteEvent;
	deleteVehicle (MISSION getVariable "trg_dropOff");
	deleteVehicle (MISSION getVariable "trg_SARFailed");
	//[_this getVariable "onEachFrame", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
	deleteVehicle (MISSION getVariable "trg_squadLoaded");
	deleteVehicle MISSION;
	MISSION_IN_PROGRESS = false;
}];




// REGISTER HANDLERS

// EVENT PICKED UP
[
	(_mission getVariable "event_pickUp"),
	{
		private ["_mission", "_vehicle"];
		_vehicle = _this select 0;
		_mission = _this select 1;

		{
			_x assignAsCargo _vehicle;
			_x orderGetin true;
		} foreach (_mission getVariable "array_crew");

		//hint "GET IN THE CHOPPA!";
	}
] call IGN_fnc_addEventHandler;


// EVENT SQUAD LOADED
[
	(_mission getVariable "event_squadLoaded"),
	{
		private ["_mission"];
		_mission = _this select 0;
		_mission setVariable ["is_picked_up", true];
		hint "Lets get you guys home!";
		[_mission getVariable "grp_helicopter", (_mission getVariable "pos_dropOff"), 3, "MOVE", 300] call EF_fnc_createWP;
		[_mission getVariable "grp_helicopter", (_mission getVariable "pos_dropOff"), 4, "MOVE", 300,
		{
			(vehicle this) land "land";
		}] call EF_fnc_createWP;
	}
] call IGN_fnc_addEventHandler;


// EVENT DROP OFF
[
	(_mission getVariable "event_dropOff"),
	{
		private ["_vehicle", "_mission", "_group"];
		_vehicle = _this select 0;
		_mission = _this select 1;
		_group = _mission getVariable "grp_pickUp";
		_lz = _mission getVariable "pos_dropOff";
		_task = _mission getVariable "task";

		// eject ai group, fiddle around with behaviour

		{_x action["eject", vehicle _x]} forEach units _group;
		{unAssignVehicle _x} forEach units _group;

		// split off extra units from player group
		{
			if (_x != player) then
			{
				[_x] join grpNull;
				_mission setVariable ["array_objects", (_mission getVariable "array_objects") + [_x]];
				//(_mission getVariable "array_objects") set [count (_mission getVariable "array_objects"), _x];
			};
		} foreach (units _group);

		_vehicle land "NONE";

		_mission setVariable ["array_objects", (_mission getVariable "array_objects") + [(_mission getVariable "helicopter")]];
		_mission setVariable ["array_groups", (_mission getVariable "array_groups") + [(_mission getVariable "grp_helicopter")]];

		[(_mission getVariable "grp_helicopter"), getpos GL_HELI_FINAL, 4, "MOVE", 500] call EF_fnc_createWP;
		[EVENT_MISSION_COMPLETED, [MISSION, MISSION getVariable "task"]] call IGN_fnc_raiseEvent;
	}
] call IGN_fnc_addEventHandler;

// Create new Kajman at base with preloaded gunner and event handlers
(getMarkerPos "HELI_SPAWN") call fnc_CreateKajmanWithGunner;

[EVENT_MISSION_CREATED, [_mission, _mission getVariable "task"]] call IGN_fnc_raiseEvent;




