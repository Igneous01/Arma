// LIBRARY/SCRIPT INITIALIZATION
#include "IGN_AHD\IGN_AHD_Init.hpp";	// authentic helicopter damage
call compile preprocessfilelinenumbers "functions.sqf";	// mission specific functions
call compile preprocessfilelinenumbers "IGN_LIB\IGN_LIB_INIT.sqf";	// events and functions
execVM "gvs\gvs_init.sqf"; // generic vehicle script initialization

/*
	Helicopter hitpoints
	"tail rotor" - anti torque rotar
	"main rotor" - main rotar
	"motor" - engines
	"munice" - munitions?
	"karoserie" - radar?

	// better alternative
	getText(configfile >> "CfgVehicles" >> "O_Heli_Attack_02_F" >> "HitPoints" >> "HitFuel" >> "name")	// fuel
	getText(configfile >> "CfgVehicles" >> "O_Heli_Attack_02_F" >> "HitPoints" >> "HitAvionics" >> "name")   // instruments
	getText(configfile >> "CfgVehicles" >> "O_Heli_Attack_02_F" >> "HitPoints" >> "HitEngine" >> "name") // engines
	getText(configfile >> "CfgVehicles" >> "O_Heli_Attack_02_F" >> "HitPoints" >> "HitHRotor" >> "name") // main rotar
	getText(configfile >> "CfgVehicles" >> "O_Heli_Attack_02_F" >> "HitPoints" >> "HitMissiles" >> "name") // all munitions (not working)
	getText(configfile >> "CfgVehicles" >> "O_Heli_Attack_02_F" >> "HitPoints" >> "HitVRotor" >> "name") // tail rotar

	// Engine Damage Visual
	EF_fnc_createEffect
	smokeParticle attachTo [(vehicle player),[2,-3,-1]]; // attaches to right engine exhaust, simulates engine smoking

*/




// MISSION PARAMETERS

// Enemy Spawn Distances
SAR_ENEMY_SPAWN_DIST = 1000;
EXTRACTION_ENEMY_SPAWN_DIST = 1000;
PLAYERDOWN_ENEMY_SPAWN_DIST = 700;
PLAYERDOWN_RESCUE_SPAWN_DIST = 10000;	// AI Chopper spawn distance away

GAME_TIMES = 0;				// time of day
GAME_WEATHER = 0;			// weather
GAME_FORECAST = 0;			// weather forecast

AA_CHANCE = 0;				// infantry AA spawning probability

MECHANICAL_CHANCE = 0;		// Mechanical Failure probability
MECHANICAL_PART = 0;		// Preferred Mechanical Failure Selection

REINFORCEMENT_CHANCE = 0;	// CAS support chance
REINFORCEMENT_TIMES = 0;	// time for CAS support to arrive from enemy

// END PARAMETERS






// MISSION INITIALIZATION



// initialize container of positions
LZ_ARRAY = [];
CAS_ARRAY = [];
SAR_ARRAY = [];
CONVOY_ARRAY = [];
TEMP_LZ = [];

for [{_i = 0}, {_i < 11}, {_i = _i+1}] do
{
	call compile (format ["TEMP_LZ = GL_LZ_%1", _i]);
	LZ_ARRAY set [count LZ_ARRAY, TEMP_LZ];
	call compile (format ["TEMP_LZ = GL_CAS_%1", _i]);
	CAS_ARRAY set [count CAS_ARRAY, TEMP_LZ];
	call compile (format ["TEMP_LZ = GL_SAR_%1", _i]);
	SAR_ARRAY set [count SAR_ARRAY, TEMP_LZ];
	call compile (format ["TEMP_LZ = GL_CONVOY_%1", _i]);
	CONVOY_ARRAY set [count CONVOY_ARRAY, TEMP_LZ];
};

TEMP_LZ = nil; // not needed anymore






// Mission_Logic Initialization
MISSION = objNull;
MISSION_IN_PROGRESS = false;		// used in trigger to assign new missions
REINFORCEMENT_CALLED = false;		// used to track if Enemy CAS reinforcement was called
AA_WILL_SPAWN = true;				// switch to turn on/off AA spawns (for SAR missions only!)
MISSION_CAN_START = false;			// switch to resume/stop mission (only used during options menu!)

// Events

// Mission Created Event
// fires when a mission is created
// sends arguments [missionObj, task]
EVENT_MISSION_CREATED = [[objNull, taskNull], "EVENT_MISSION_CREATED"] call IGN_fnc_createEvent;

// Mission Failed Event
// fires when a mission fails
// sends arguments [missionObj, task]
EVENT_MISSION_FAILED = [[objNull, taskNull], "EVENT_MISSION_FAILED"] call IGN_fnc_createEvent;

// Mission Completed Event
// fires when a mission is completed
// sends arguments [missionObj, task]
EVENT_MISSION_COMPLETED = [[objNull, taskNull], "EVENT_MISSION_COMPLETED"] call IGN_fnc_createEvent;

// Mission Cleanup Event
// fires when a mission is about to be deleted (garbage collected)
// sends arguments [missionObj]
EVENT_MISSION_CLEANUP = [[objNull], "EVENT_MISSION_CLEANUP"] call IGN_fnc_createEvent;

// Reinforcements called Event
// fires when an AI unit requests reinforcements
// sends arguments pos
EVENT_REINFORCEMENT_CALLED = [[0,0,0], "EVENT_REINFORCEMENT_CALLED"] call IGN_fnc_createEvent;


// Global Event Handlers

// MISSION COMPLETED
EH_MISSION_COMPLETED = [
	EVENT_MISSION_COMPLETED,
	{
		private ["_mission"];
		_mission = _this select 0;
		_task = _this select 1;

		// complete task
		_task setTaskState "Succeeded";
		["TaskCompleted",[(taskDescription _task) select 1]] call bis_fnc_showNotification;

		_mission call (_mission getVariable "destroy");	// clean up resources

		MISSION_IN_PROGRESS = false;
	}
] call IGN_fnc_addEventHandler;

// MISSION CREATED
EH_MISSION_CREATED = [
	EVENT_MISSION_CREATED,
	{
		private ["_mission"];
		_mission = _this select 0;
		_task = _this select 1;

		// create task
		_task setTaskState "Created";
		["TaskCreated",[(taskDescription _task) select 1]] call bis_fnc_showNotification;

		MISSION_IN_PROGRESS = true;
	}
] call IGN_fnc_addEventHandler;

// MISSION FAILED
EH_MISSION_FAILED = [
	EVENT_MISSION_FAILED,
	{
		private ["_mission"];
		_mission = _this select 0;
		_task = _this select 1;

		_task setTaskState "Failed";	// fail task
		["TaskFailed",[(taskDescription _task) select 1]] call bis_fnc_showNotification;

		_mission call (_mission getVariable "destroy");	// clean up resources
		MISSION_IN_PROGRESS = false;
	}
] call IGN_fnc_addEventHandler;

// MISSION FAILED
EH_MISSION_CLEANUP = [
	EVENT_MISSION_CLEANUP,
	{
		private ["_mission"];
		_mission = _this select 0;

		//hint format ["Mission %1 is being Cleaned Up...", _mission];

		// naive garbage collection - if units are still alive they wont be cleaned up! (maybe not afterall)
		{
			[units _x] call BIS_fnc_GC;	// send to GC
		} foreach (_mission getVariable "array_groups");

		[_mission getVariable "array_objects"] call BIS_fnc_GC;
	}
] call IGN_fnc_addEventHandler;

// REINFORCEMENT CALLED
EH_REINFORCEMENT_CALLED = [
	EVENT_REINFORCEMENT_CALLED,
	{
		private ["_pos"];
		_pos = _this;

		// spawn timer in new thread, create vehicle
		[_pos, REINFORCEMENT_TIMES] spawn
		{
			private ["_pos", "_c", "_veh", "_grp", "_JetData", "_wp"];
			_pos = _this select 0;
			_c = _this select 1;
			waitUntil {sleep 1; _c = _c - 1; hint format ["Enemy Air Support will arrive in: %1 seconds", _c]; _c == 0};

			_JetData = [getpos GL_AIRSPAWN, getDir GL_AIRSPAWN, Mission_Dictionary getVariable "B_Jet"] call fnc_createReinforcements;
			_grp = _JetData select 0;
			_veh = _JetData select 1;
			_wp = [_grp, _pos, 1, "MOVE", 1000, {}, [60, 120, 180]] call EF_fnc_createWP;

			_veh addEventHandler ["killed", {REINFORCEMENT_CALLED = false; [_this select 0] call BIS_fnc_GC;}];

			// Garbage Cleanup after waypoint completes - DOES NOT DELETE GROUP!!!!
			_wp = [_grp, getpos GL_AIRSPAWN, 2, "MOVE", 1000,
			{
				REINFORCEMENT_CALLED = false;
				(vehicle this) call BIS_fnc_GC;
				(group this) call BIS_fnc_GC;
			}] call EF_fnc_createWP;

			/*
			// DEBUGGING
			_veh spawn
			{
	            private ["_myLocalMarker"];
				_myLocalMarker = ["jet_mrk", "JET", getpos _this] call fnc_createMarker;
				while {alive _this} do
				{
					_myLocalMarker setMarkerPos (getpos _this);
				};
			};
			//
			*/
		};

	}
] call IGN_fnc_addEventHandler;


//


// Asset Enumerators
Mission_Dictionary setVariable ["mission_types", ["insertion", "extraction", "cas", "sar", "convoy"]];

Mission_Dictionary setVariable ["B_Armor", "B_MBT_01_TUSK_F"];
Mission_Dictionary setVariable ["B_IFV", "B_APC_Tracked_01_rcws_F"];
Mission_Dictionary setVariable ["B_APC", "B_APC_Wheeled_01_cannon_F"];
Mission_Dictionary setVariable ["B_AA", "B_APC_Tracked_01_AA_F"];
Mission_Dictionary setVariable ["B_Arty", "B_MBT_01_arty_F"];
Mission_Dictionary setVariable ["B_Truck_Fuel", "B_Truck_01_fuel_F"];
Mission_Dictionary setVariable ["B_Truck_Ammo", "B_Truck_01_ammo_F"];
Mission_Dictionary setVariable ["B_Car", ""];	// military cars
Mission_Dictionary setVariable ["B_Gunship", ""];
Mission_Dictionary setVariable ["B_Chopper", ""];
Mission_Dictionary setVariable ["B_Jet", "I_Plane_Fighter_03_AA_F"];

Mission_Dictionary setVariable ["Wreck", "Land_Wreck_Heli_Attack_02_F"];

Mission_Dictionary setVariable ["O_Heli_Pilot", "O_helipilot_F"];
Mission_Dictionary setVariable ["O_Heli_Crew", "O_helicrew_F"];
Mission_Dictionary setVariable ["O_Soldier", "O_Soldier_F"];
Mission_Dictionary setVariable ["B_Soldier_AA", "B_soldier_AA_F"];
Mission_Dictionary setVariable ["B_Soldier", "B_Soldier_F"];


// Convoy Compositions

// APC - Truck - Truck - APC
CONVOY_COMP_1 =
[
	Mission_Dictionary getVariable "B_APC",
	Mission_Dictionary getVariable "B_Truck_Ammo",
	Mission_Dictionary getVariable "B_Truck_Fuel",
	Mission_Dictionary getVariable "B_APC"
];

// AA - Truck - Truck - IFV
CONVOY_COMP_2 =
[
	Mission_Dictionary getVariable "B_AA",
	Mission_Dictionary getVariable "B_Truck_Ammo",
	Mission_Dictionary getVariable "B_Truck_Fuel",
	Mission_Dictionary getVariable "B_IFV"
];

// TANK - Truck - Truck - TANK
CONVOY_COMP_3 =
[
	Mission_Dictionary getVariable "B_Armor",
	Mission_Dictionary getVariable "B_Truck_Ammo",
	Mission_Dictionary getVariable "B_Truck_Fuel",
	Mission_Dictionary getVariable "B_Armor"
];

// Truck - Truck - Truck - Truck
CONVOY_COMP_4 =
[
	Mission_Dictionary getVariable "B_Truck_Ammo",
	Mission_Dictionary getVariable "B_Truck_Fuel",
	Mission_Dictionary getVariable "B_Truck_Ammo",
	Mission_Dictionary getVariable "B_Truck_Fuel"
];

// APC - APC
CONVOY_COMP_5 =
[
	Mission_Dictionary getVariable "B_APC",
	Mission_Dictionary getVariable "B_APC"
];

// IFV - IFV
CONVOY_COMP_6 =
[
	Mission_Dictionary getVariable "B_IFV",
	Mission_Dictionary getVariable "B_IFV"
];

// CAS Targets
CAS_TARGETS =
[
	Mission_Dictionary getVariable "B_Armor",
	Mission_Dictionary getVariable "B_APC",
	Mission_Dictionary getVariable "B_IFV",
	Mission_Dictionary getVariable "B_AA",
	Mission_Dictionary getVariable "B_Arty"
];



// Mission Descriptions
MISSION_INSERTION_DESC = ["Command has ordered your unit to insert some friendly forces at the specified LZ. Pick up the squad and drop them off at the specified LZ.", "Insert Forces"];

MISSION_EXTRACTION_DESC = ["Command has ordered your unit to extract friendly forces from the area. Get them out of there before the enemy can get to them!", "Extract Forces"];

MISSION_CAS_DESC = ["Friendly forces are requesting close-air support at the designated location. Fly in and take those targets out.", "Close Air Support"];

MISSION_CONVOY_DESC = ["Recon forces have intercepted the location of an armed convoy. The convoy was last spotted at the designated location with the current direction of travel. Destroy the convoy before it can reach its designated position!", "Intercept Enemy Convoy"];

MISSION_SAR_DESC = ["We've just received an emergency distress signal from a downed air unit - last known position is marked on the map. Find the downed pilots and bring them back before the enemy does!", "Search and Rescue"];

MISSION_PLAYERDOWN_DESC = ["We received your distress signal - SAR has been dispatched and should arrive soon. Defend your position until they can arrive to bring you home!", "Wait For SAR Arrival"];



// called via spawn
fnc_selectRandomMission =
{
	private ["_mission","_mission_pos","_r","_c","_v","_g"];
	_mission_pos = [];
	_mission = (Mission_Dictionary getVariable "mission_types") call BIS_fnc_selectRandom;

	//_mission = "convoy";	// CHANGE THIS LATER!!! ONLY FOR TESTING


	if (_mission == "extraction") exitWith
	{
		_mission_pos = getpos (LZ_ARRAY call BIS_fnc_selectRandom);
		[_mission_pos, getMarkerPos "BASE", "extraction", MISSION_EXTRACTION_DESC] execVM "create_insertion_mission.sqf";
	};


	if (_mission == "insertion") exitWith
	{
		_mission_pos = getpos (LZ_ARRAY call BIS_fnc_selectRandom);
		[getMarkerPos "PICKUP_ZONE", _mission_pos, "insertion", MISSION_INSERTION_DESC] execVM "create_insertion_mission.sqf";
	};


	if (_mission == "cas") exitWith
	{
		_mission_pos = getpos (CAS_ARRAY call BIS_fnc_selectRandom);
        _r = 300 + ((round (random 9.99)) * 100);
		_c = 1 + (round (random 2.99));
		_v = CAS_TARGETS call BIS_fnc_selectRandom;
		//hint format ["%1", _v];
		//_g = [true, false] call BIS_fnc_selectRandom;
		_g = false;	// DONT GROUP TARGETS - CURRENTLY SPAWN POSITIONS FOR GROUPED TARGETS IS BUGGED

		[_mission_pos, _r, _v, _c, _g, MISSION_CAS_DESC] execVM "create_cas_mission.sqf";
	};


	if (_mission == "sar") exitWith
	{
		_mission_pos = getpos (SAR_ARRAY call BIS_fnc_selectRandom);
        _r = 800 + ((round (random 9.99)) * 100);
		[_mission_pos, getMarkerPos "BASE", _r, MISSION_SAR_DESC] execVM "create_sar_mission.sqf";
	};


	if (_mission == "convoy") exitWith
	{
		private ["_logic", "_convoyList"];
		_logic = (CONVOY_ARRAY call BIS_fnc_selectRandom);
		//_logic = GL_CONVOY_10;	// CHANGE THIS LATER!! ONLY FOR DEBUGGING NEW MISSION POSITIONS!
		_mission_pos = getpos _Logic;
		_convoyList = [CONVOY_COMP_1, CONVOY_COMP_2, CONVOY_COMP_3, CONVOY_COMP_4, CONVOY_COMP_5, CONVOY_COMP_6] call BIS_fnc_selectRandom;
		[_mission_pos, getDir _Logic, _convoyList, MISSION_CONVOY_DESC] execVM "create_convoy_mission.sqf";
	};

};

titleText ["", "BLACK", 0];
player enableSimulation false;
