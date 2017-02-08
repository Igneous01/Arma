_pickUp_pos = _this select 0;
_dropOff_pos = _this select 1;
_type = _this select 2;
_taskDesc = _this select 3;

MISSION = createVehicle ["Land_HelipadEmpty_F", [0,0,0], [], 0, "NONE"];
_mission = MISSION;

// common attributes
_mission setVariable ["name", _type];
_mission setVariable ["task", taskNull];

// mission specific
_mission setVariable ["pos_pickUp", _pickUp_pos];
_mission setVariable ["pos_dropOff", _dropOff_pos];
_mission setVariable ["grp_pickUp", _pickUp_pos call fnc_createGroup];

// Garbage Collector Use
_mission setVariable ["array_groups", [_mission getVariable "grp_pickUp"]];
_mission setVariable ["array_objects", []];

private ["_mrkPickUpText", "_mrkDropOffText"];
if (_type == "insertion") then
{
	_mrkPickUpText = "Pick Up Point";
	_mrkDropOffText = "Insertion LZ";
};
if (_type == "extraction") then
{
	private ["_enemyGrps"];
	_mrkPickUpText = "Extraction LZ";
	_mrkDropOffText = "Drop Off Point";
	_enemyGrps = [_pickUp_pos, 1 + (round (random 1.99)), EXTRACTION_ENEMY_SPAWN_DIST] call fnc_spawnEnemyGroups;
	_mission setVariable ["array_groups", (_mission getVariable "array_groups") + _enemyGrps];
};
_mission setVariable ["mrk_pickUp", ["pickUp_mrk", _mrkPickUpText, _pickUp_pos] call fnc_createMarker];
_mission setVariable ["mrk_dropOff", ["dropOff_mrk", _mrkDropOffText, _dropOff_pos] call fnc_createMarker];
_mission setVariable ["is_picked_up", false];
_mission setVariable ["task", player createSimpleTask ["Insert/Extract"]];

(_mission getVariable "task") setSimpleTaskDescription [(_taskDesc select 0), (_taskDesc select 1), ""];


// EVENTS
_mission setVariable ["event_pickUp", [[objNull, objNull]] call IGN_fnc_createEvent];	// raises [vehicle, missionObj]
_mission setVariable ["event_squadLoaded", [[objNull]] call IGN_fnc_createEvent];		// raises [missionObj]
_mission setVariable ["event_dropOff", [[objNull, objNull]] call IGN_fnc_createEvent];	// raises [vehicle, missionObj]



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


// inSmokeRange
if (_type == "extraction") then
{
	_trg = createTrigger["EmptyDetector", _pickUp_pos];
	_trg setTriggerArea[2000,2000,0,false];
	_trg setTriggerActivation["EAST","PRESENT",false];
	_trg setTriggerTimeout [0,0,0, true];
	_trg setTriggerStatements["(vehicle player) in thisList",
	"0 = (getpos thisTrigger) execVM 'spawnSmoke.sqf';",
	""];

	_mission setVariable ["trg_inSmokeRange", _trg];
};



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
	deleteMarker (MISSION getVariable "mrk_dropOff");
	[(MISSION getVariable "event_pickUp")] call IGN_fnc_deleteEvent;
	[(MISSION getVariable "event_squadLoaded")] call IGN_fnc_deleteEvent;
	[(MISSION getVariable "event_dropOff")] call IGN_fnc_deleteEvent;
	//[(_this getVariable "event_failed")] call IGN_fnc_deleteEvent;
	deleteVehicle (MISSION getVariable "trg_pickUp");
	deleteVehicle (MISSION getVariable "trg_dropOff");
	//[_this getVariable "onEachFrame", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
	deleteVehicle (MISSION getVariable "trg_pickUpUnitsDead");
	deleteVehicle (MISSION getVariable "trg_squadLoaded");

	if ((MISSION getVariable "name") == "extraction") then
	{
		deleteVehicle (MISSION getVariable "trg_inSmokeRange");	// delete smoke trigger if extraction
	};
	deleteVehicle MISSION;
	MISSION_IN_PROGRESS = false;
}];




// REGISTER HANDLERS

// EVENT PICKED UP
[
	(_mission getVariable "event_pickUp"),
	{
		private ["_mission", "_vehicle", "_wp"];
		_vehicle = _this select 0;
		_mission = _this select 1;
		_group = _mission getVariable "grp_pickUp";

		// order ai squad into vehicle
		{_x assignAsCargo _vehicle} foreach units _group;
		{[_x] ordergetin true} foreach units _group;
		{_x disableAI "TARGET"; _x disableAI "AUTOTARGET";} foreach units _group;
		_wp = _group addwaypoint [_vehicle,5,1];
		_wp setwaypointType "GETIN";

		hint "friendlies are boarding...";
	}
] call IGN_fnc_addEventHandler;


// EVENT SQUAD LOADED
[
	(_mission getVariable "event_squadLoaded"),
	{
		(_this select 0) setVariable ["is_picked_up", true];
		hint "friendlies inside...";
	}
] call IGN_fnc_addEventHandler;


// EVENT DROP OFF
[
	(_mission getVariable "event_dropOff"),
	{
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

		wp = _group addwaypoint [_lz,5,1];
		wp setwaypointType "MOVE";

		[EVENT_MISSION_COMPLETED, [MISSION, MISSION getVariable "task"]] call IGN_fnc_raiseEvent;
	}
] call IGN_fnc_addEventHandler;



[EVENT_MISSION_CREATED, [_mission, _mission getVariable "task"]] call IGN_fnc_raiseEvent;

// MISC
{ _x setUnitPos "MIDDLE"; } foreach units (_mission getVariable "grp_pickUp");
//((units (_mission getVariable "grp_pickUp")) select 0) allowDamage false;


