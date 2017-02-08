fnc_select_position =
{
    private ["_pos", "_prevPos"];
    _prevPos = _this;
    if ((isNil {_prevPos}) || (typeName _prevPos) != "OBJECT") then
    {
        _pos = LZ_ARRAY call BIS_fnc_selectRandom;
    }
    else
    {
        _pos = (LZ_ARRAY - [_prevPos]) call BIS_fnc_selectRandom;
    };
    getpos _pos;
};

fnc_createGroup =
{
	private ["_pos", "_grp"];
	if (isNil {_this}) exitWith {grpNull;};
	if (typename _this != "ARRAY") exitWith {grpNull;};

	_pos = _this;
	_grp = createGroup east;
	"O_Soldier_F" createUnit [_pos, _grp,"",0.5, "CORPORAL"];
	"O_Soldier_F" createUnit [_pos, _grp,"",0.5, "PRIVATE"];
	"O_Soldier_F" createUnit [_pos, _grp,"",0.5, "PRIVATE"];
	"O_Soldier_F" createUnit [_pos, _grp,"",0.5, "PRIVATE"];

	_grp;
};

fnc_spawnEnemyGroups =
{
	private ["_pos", "_count", "_grps", "_i", "_dist"];
	_pos = _this select 0;
	_count = _this select 1;
	_dist = _this select 2;
	_grps = [];
	for [{_i = 0}, {_i < _count}, {_i = _i + 1}] do
	{
		private ["_g", "_p"];
		_p = [_pos, _dist, (random 359)] call EF_fnc_getPosAtAngle;
		_g = [_p, WEST, (configfile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_InfTeam")] call BIS_fnc_spawnGroup;
		_grps set [count _grps, _g];

		// create seek and destroy waypoint for group
		[_g, _pos, 1, "SAD", 50] call EF_fnc_createWP;
	};
	_grps;	// return array of groups
};

fnc_createSARGroup =
{
	private ["_pos", "_radius", "_wreckType", "_wreck", "_grp"];
	_pos = _this select 0;
	_radius = _this select 1;
	_wreckType = _this select 2;
	_wreck = createVehicle [_wreckType, _pos, [], 0, "CAN_COLLIDE"];
	_grp = createGroup east;
	(Mission_Dictionary getVariable "O_Heli_Pilot") createUnit [[_pos, 10, random (359)] call EF_fnc_GetPosAtAngle, _grp,"",0.5, "CORPORAL"];
	(Mission_Dictionary getVariable "O_Heli_Crew") createUnit [[_pos, 10, random (359)] call EF_fnc_GetPosAtAngle, _grp,"",0.5, "PRIVATE"];

	[_grp, _wreck];
};

fnc_vehicleDisabled =
{
	private ["_veh", "_res"];
	_veh = [_this, objNull, [objNull]] call EF_fnc_singleParam;

	if (isNull _veh) exitWith {false;};

	_res = false;
	if (!alive _veh || !canMove _veh) then { _res = true; };
	_res;
};

fnc_vehicleDisabledInCollection =
{
	private ["_veh", "_vehicles", "_res"];
	_vehicles = _this;
	_veh = objNull;
	{
		_res = _x call fnc_vehicleDisabled;
		if (_res) then
			{
				_veh = _x;
			};
	} foreach _vehicles;
	_veh;
};

fnc_createConvoy =
{
	private ["_veh_types","_veh_count","_posBegin","_dir","_grp_convoy","_convoy_vehs","_i"];
	_veh_types = _this select 0; // array ['veh_class_1', 'veh_class_2']
	_veh_count = [_this, 1, 4, [0]] call BIS_fnc_param; // number
	_posBegin = _this select 2;							// start position
	_dir = _this select 3;								// dir
	_grp_convoy = createGroup west;
	_convoy_vehs = [];

	for [{_i = 0}, {_i < _veh_count}, {_i = _i + 1}] do
	{
		private ["_v", "_spawnData"];
		_spawnData = [_posBegin, _dir, _veh_types select _i, _grp_convoy] call BIS_fnc_spawnVehicle;
		_convoy_vehs set [count _convoy_vehs, _spawnData select 0];
	};

	[_grp_convoy, _convoy_vehs];	// return
};

fnc_createCASTargets =
{
	private ["_target_types","_target_count","_pos","_radius","_separate_groups","_target_groups","_target_vehicles","_spawnPos","_i"];
	_target_types = _this select 0;
	_target_count = _this select 1;
	_pos = _this select 2;
	_radius = _this select 3;
	_separate_groups = _this select 4;

	_target_groups = [];
	_target_vehicles = [];
	_spawnPos = [];
	for [{_i = 0}, {_i < _target_count}, {_i = _i + 1}] do
	{
		private ["_type", "_veh", "_spawnData"];
		if (typename _target_types == typename []) then
		{
			_type = _target_types call BIS_fnc_selectRandom;
		}
		else {_type = _target_types;};

		// *******FIX THIS
		if (_separate_groups || count _target_groups == 0) then
		{
			// position
			// *** VEHICLE SPAWNS IN BAD PLACES (UNDERWATER, NEXT TO ANOTHER VEHICLE)
			//_spawnPos = [_pos, _radius] call fnc_placementRadiusGround;
			_spawnPos = [[[_pos, _radius]]] call BIS_fnc_randomPos;

			_spawnData = [_spawnPos, (random 359), _type, west] call BIS_fnc_spawnVehicle;
			_target_groups set [count _target_groups, _spawnData select 2]
		}
		else
		{
			// Increment Second argument of GetPosAtAngle!!!!! AND HANDLE SPAWNING IN BUILDINGS/WATER !!!!!!
			_spawnData = [[_spawnPos, 25, random (359)] call EF_fnc_GetPosAtAngle, (random 359), _type, (_target_groups select 0)] call BIS_fnc_spawnVehicle;
		};

		_target_vehicles set[count _target_vehicles, _spawnData select 0];
	};

	// return data
	[_target_vehicles, _target_groups];
};

fnc_createConvoy =
{
	private ["_veh_types","_spawnPos","_dir","_grp_convoy","_convoy_vehs","_i"];
	_veh_types = _this select 0; // array ['veh_class_1', 'veh_class_2']
	_spawnPos = _this select 1;							// start position (DOES THIS MODIFY ORIGINAL ARGUMENT??????)
	_dir = _this select 2;								// dir
	_grp_convoy = createGroup west;
	_convoy_vehs = [];

	for [{_i = 0}, {_i < (count _veh_types)}, {_i = _i + 1}] do
	{
		private ["_v", "_spawnData"];
		_spawnData = [_spawnPos, _dir, _veh_types select _i, _grp_convoy] call BIS_fnc_spawnVehicle;
		_convoy_vehs set [count _convoy_vehs, _spawnData select 0];
		_spawnPos = [_spawnPos, 25, _dir - 180] call EF_fnc_GetPosAtAngle;
	};

	[_grp_convoy, _convoy_vehs];	// return
};

fnc_createAAGroup =
{
	private ["_pos", "_grp"];
	_pos = _this;
	_grp = createGroup west;
	_pos = [[[_pos, 1200]]] call BIS_fnc_randomPos;
	(Mission_Dictionary getVariable "B_Soldier_AA") createUnit [_pos, _grp,"",0.5, "CORPORAL"];
	(Mission_Dictionary getVariable "B_Soldier") createUnit [_pos, _grp,"",0.5, "PRIVATE"];
	(Mission_Dictionary getVariable "B_Soldier") createUnit [_pos, _grp,"",0.5, "PRIVATE"];
	//hint format ["createAAGroup: %1", units _grp];
	(leader _grp) setDir (random 359);
	_grp;	// return
};

fnc_createReinforcements =
{
	private ["_pos", "_dir", "_type", "_veh", "_grp", "_spawnData"];
	_pos = _this select 0;
	_dir = _this select 1;
	_type = _this select 2;
	_grp = createGroup west;
	_spawnData = [[_pos select 0, _pos select 1], _dir, _type, _grp] call BIS_fnc_spawnVehicle;
	_veh = _spawnData select 0;
	[_grp, _veh];	// return group and vehicle
};

// variable _z is ignored!!!!!!!!!!!!!!
fnc_placementRadiusGround =
{
	private ["_pos", "_radius", "_newPos", "_z"];
	_pos = [_this, 0, [0,0,0], [[]]] call BIS_fnc_param;
	_radius = [_this, 1, 300, [0]] call BIS_fnc_param;

	// return new position within radius relative to position
	_newPos = [(_pos select 0)-_radius*sin(random 359), (_pos select 1)-_radius*cos(random 359)];
	_z = getTerrainHeightASL _newPos;	// BIS_fnc_spawnGroup doesn't use ASL position!!!!
	_newPos set[2, 0];

	_newPos;
};

fnc_deleteGroup =
{
	private ["_grp"];
	_grp = [_this, grpNull, [grpNull]] call EF_fnc_singleParam;
	if (isNull(_grp)) exitWith {false;};

	{
		deleteVehicle _x;
	} foreach units _grp;

	deleteGroup _grp;
	true;
};

fnc_createMarker =
{
	private ["_name", "_text", "_pos", "_type", "_color", "_marker"];
	_name = [_this, 0, "default_marker", [""]] call BIS_fnc_param;
	_text = [_this, 1, "marker text", [""]] call BIS_fnc_param;
	_pos = [_this, 2, [0,0,0], [[]]] call BIS_fnc_param;
	_type = [_this, 3, "hd_destroy", [""]] call BIS_fnc_param;
	_color = [_this, 4, "ColorBlue", [""]] call BIS_fnc_param;

	_marker = createMarker [_name, _pos];
	_name setMarkerText _text;
	_name setMarkerType _type;
	_name setMarkerColor _color;

	_marker;
};

fnc_createMarkerEllipse =
{
	private ["_name","_text","_pos","_color","_marker","_radius"];
	_name = [_this, 0, "default_marker", [""]] call BIS_fnc_param;
	_text = [_this, 1, "marker text", [""]] call BIS_fnc_param;
	_pos = [_this, 2, [0,0,0], [[]]] call BIS_fnc_param;
	_radius = [_this, 3, 300, [0]] call BIS_fnc_param;
	_color = [_this, 4, "ColorBlue", [""]] call BIS_fnc_param;

	_marker = createMarker [_name, _pos];
	_name setMarkerText _text;
	_name setMarkerShape "ELLIPSE";
	_name setMarkerSize [_radius, _radius];
	_name setMarkerColor _color;

	_marker;
};

fnc_CreateKajmanWithGunner =
{
	private ["_pos", "_veh", "_gunner", "_grp"];
	_pos = _this;

	_veh = createVehicle ["O_Heli_Attack_02_F", _pos, [], 0, "NONE"];
	_grp = createGroup EAST;
	_gunner = _grp createUnit [Mission_Dictionary getVariable "O_Heli_Crew", _pos, [], 0, "FORM"] ;
	_gunner assignAsGunner _veh;
	_gunner moveInGunner _veh;

	_veh addEventHandler ["GetIn", eh_HeliGetIn];

	_veh;
};

fnc_TrackCrashingHeli =
{
	private ["_z", "_veh"];
	_veh = _this;
	waitUntil
	{
		_z = (getPosATL _veh) select 2;
		//hint format ["%1", _z];

		_z < 12;
	};

	0 = _veh execVM "CrashToWreck.sqf";
};


// Event Handlers
eh_HeliGetIn =
{
	private ["_veh", "_unit", "_veh_pos"];
	_veh = _this select 0;
	_veh_pos = _this select 1;
	_unit = _this select 2;
	if (_veh_pos == "driver") then
	{
		private ["_grp"];
		_veh removeEventHandler ["GetIn", 0];
		_grp = group (gunner _veh);
		[(gunner _veh)] join (group _unit);
		deleteGroup _grp;
		_veh addEventHandler ["HandleDamage", eh_HeliHandleDamage];
		[_veh, MECHANICAL_CHANCE, MECHANICAL_PART] execVM "IGN_AHD\IGN_AHD.sqf";
	};
};

eh_HeliHandleDamage =
{
	if ((_this select 4) == "") exitWith {_this select 2;};
	//hint "triggered";
	if (!canMove (_this select 0)) then
	{
		// raise existing MISSION to cancelled status (if MISSION != null)
		// transfer existing friendly units (if any) ownership to this mission (if feasable)
		if (!isNull MISSION) then
		{
			[EVENT_MISSION_FAILED, [MISSION, MISSION getVariable "task"]] call IGN_fnc_raiseEvent;
			MISSION_IN_PROGRESS = true;
		};
		(_this select 0) removeEventHandler ["HandleDamage", 0];
		0 = (_this select 0) spawn fnc_TrackCrashingHeli;
	};
	_this select 2;
};

fnc_chance =
{
	private ["_chance", "_res"];
	_chance = _this;
	_res = false;
	if ((random(100)) < _chance) then {_res = true;};

	_res;
};

fnc_cleanUpAA =
{
	private ["_grp"];
	_grp = _this;

	if (isNil {_grp}) exitWith {};
	if (isNull _grp) exitWith {};

	// determine if separate calls makes a difference in GC behaviour
	[units _grp] call BIS_fnc_GC;
	[_grp] call BIS_fnc_GC;
};




//




// kills the entity (setdamage 1), sends to Garbage collector for cleanup
// best called with spawn - cleanup can happen concurrently
// NOT NEEDED, as BIS_GC will delete units/objects even if they are alive (only cares if player dist > 2000 or so)
/*
fnc_addToGCQueue =
{
	private ["_entity"];
	if (isNil {_entity}) exitWith {};
	if (typename _entity == typename []) exitWith
	{
		{
			if (typename _x == typename grpNull) then
			{
				{_x setDamage 1;} foreach units _x;
				[units _x] call BIS_fnc_GC;
				[_x] call BIS_fnc_GC;
			};
			if (typename _x == typename objNull) then
			{
				_x setDamage 1;
				[_x] call BIS_fnc_GC;
			};
		} foreach _entity;
	};
	if (typename _entity == typename grpNull) then
	{
		{_x setDamage 1;} foreach units _entity;
		[units _entity] call BIS_fnc_GC;
		[_entity] call BIS_fnc_GC;
	}
	else {
		if (typename _entity == typename objNull) then
		{
			_entity setDamage 1;
			[_entity] call BIS_fnc_GC;
		};
	};

};
*/