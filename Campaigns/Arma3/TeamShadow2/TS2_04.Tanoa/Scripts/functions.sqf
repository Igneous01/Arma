
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

fnc_chance =
{
	private ["_chance", "_res"];
	_chance = _this;
	_res = false;
	if ((random(100)) < _chance) then {_res = true;};

	_res;
};


// ["mrk_SAM1_Area", "mrk_SAM1_New", obj_SAM1, ["task_FindSAM1", task_FindSAMs], ["Find SAM site A", "Find SAM site A", ""]] call fnc_UpdateSAMMarkerAndTask
fnc_UpdateSAMMarkerAndTask =
{
	private["_marker", "_posSAM", "_task", "_markerSAM", "_taskDesc"];
	_marker = _this select 0;
	_markerSAM = _this select 1;	// name of new marker to create
	_posSAM = _this select 2;
	_task = _this select 3;
	_taskDesc = _this select 4;

	// update marker
	_marker setMarkerColor "ColorGreen";

	// create new marker
	_markerSAMobj = createMarker [_markerSAM, _posSAM];
	_markerSAMobj setMarkerType "mil_box";
	_markerSAMobj setMarkerText "SAM";
	_markerSAMobj setMarkerColor "colorGreen";

	// update task
	[_task, group_Players, _taskDesc, objNull, "SUCCEEDED"] call BIS_fnc_setTask;
};

// creates the waypoints for the team
fnc_CreateSFWaypoints =
{
	/*
	{
		_x setCombatMode "YELLOW";
		_x setBehaviour "STEALTH";
	} foreach units SFTeam;
	*/

	//wp 1 will trigger task completion
	_wp1 = SFTeam addWaypoint [getpos obj_Jammer, 0];
	_wp1 setWaypointCombatMode "YELLOW";
	_wp1 setWaypointCompletionRadius 15;
	_wp1 setWaypointStatements ["true", "[] call fnc_CompleteTaskSFTeamAtk;"];

	_wp2 = SFTeam addWaypoint [getpos logic_SFTeamAtkPos, 0];
	_wp2 setWaypointCombatMode "GREEN";
	_wp2 setWaypointCompletionRadius 15;
	_wp2 setWaypointStatements ["true", "[] spawn thr_CreateExplosionsEWRAndJammer;"];

	SFTeam setCurrentWaypoint _wp1;

	(leader SFTeam) sideChat "Shadow, this is 62. We're moving in, give us cover fire and watch for new threats.";
};

fnc_CompleteTaskSFTeamAtk =
{
	[task_AssistSFTeam, group_Players, task_AssistSFTeam_Description, objNull, 'SUCCEEDED'] call BIS_fnc_setTask;
	bool_JammerAttacked = true;
	(leader SFTeam) sideChat "Shadow, 62 here. Demolitions planted; egressing to safe point.";
};


fnc_CreateAssistSFTeamTask =
{
	// create radio trigger
	_trg = createTrigger ["EmptyDetector", getPos obj_Jammer];
	_trg setTriggerArea [0, 0, 0, false];
	_trg setTriggerActivation ["ALPHA", "PRESENT", false];
	_trg setTriggerStatements ["this", "call fnc_CreateSFWaypoints", ""];
	_trg setTriggerText "Callsign 62: Signal Attack";

	// teleport sf team
	{
		_x setPos (GetPos logic_SFTeamAtkPos);
		_x setCombatMode "BLUE";
		_x setBehaviour "STEALTH";
	} foreach units SFTeam;

	"mrk_SFTeamAtkDirection" setMarkerAlpha 1;

	[group_Players,[task_AssistSFTeam],task_AssistSFTeam_Description,getpos obj_Jammer,1,4,true] call BIS_fnc_taskCreate;

	(leader SFTeam) sideChat "Shadow, this is 62. We're in a position to strike the Jammer position, but we need your support to take down the target. Radio us in when you're in a position to cover our attack. 62 out.";
};

thr_CreateExplosionsEWRAndJammer =
{
	(leader SFTeam) sideChat "Demo armed. Timer 30 seconds.";

	sleep 30;
	_demoType = "R_80mm_HE";
	_exp1 = createVehicle [_demoType, getPos obj_Jammer, [], 0, "CAN_COLLIDE"];
	_exp2 = createVehicle [_demoType, getPos obj_Radar, [], 0, "CAN_COLLIDE"];

	obj_Radar setDamage 1;
	obj_Jammer setDamage 1;

	sleep 10;
	[] spawn thr_CreateExplosionsSAMsites;
};

thr_CreateExplosionsSAMsites =
{
	obj_PilotSEAD sideChat "62, this is cowboy 1-1. SEAD package enroute to strike positions. ETA 5 Mikes.";
	sleep 300;
	_aa =
	[
		[obj_SAM1, obj_SAM2, obj_SAM3, obj_SAM4],
		1,
		[getpos logic_SEAD1, getpos logic_SEAD2, getpos logic_SEAD3],
		1
	] execVM "Scripts\GOM_fnc_ambientAA.sqf";

	obj_PilotSEAD sideChat "62, this is cowboy 1-1. Releasing weapons. Impact imminent.";
	sleep 20;

	_demoType = "HelicopterExploSmall";
	{
		createVehicle [_demoType, getPos _x, [], 0, "CAN_COLLIDE"];
		_x setDamage 1;
	} foreach [obj_SAM1, obj_SAM2, obj_SAM3, obj_SAM4];
};

fnc_start_animation =
{
	private _grp = _this;
	_h = (units _grp) spawn
	{
		waitUntil {time > 0;};
		{
			[_x,"SIT"] call BIS_fnc_ambientAnim;
		} forEach _this;
	};
};

fnc_stop_animation =
{
	private _grp = _this;
	{
		_x call BIS_fnc_ambientAnim__terminate;
	} forEach units _grp;
	_grp setBehaviour "COMBAT";
};