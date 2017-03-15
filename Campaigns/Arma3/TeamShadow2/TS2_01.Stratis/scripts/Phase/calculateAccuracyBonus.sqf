params ["_target", "_shotPos"];
//diag_log text format ["target: %1, accuracyZones: %2", _target, (_target getVariable "TS2_accuracyZones")];
if (isNil {(_target getVariable "TS2_accuracyZones");}) exitWith {0;}; // return 0 for any targets that do not have defined zones

private _head = (_target getVariable "TS2_accuracyZones") select 0;
if (_shotPos distance (getposASL _head) <= HEAD_ZONE_DISTANCE) exitWith
{
	diag_log text format ["Head Shot (Distance to center: %1)", (_shotPos distance (getposASL _head))];
	BONUS_ACCURACY_HEAD;
};

private _torso = (_target getVariable "TS2_accuracyZones") select 1;
if (_shotPos distance (getposASL _torso) <= TORSO_INNER_ZONE_DISTANCE) exitWith
{
	diag_log text format ["Inner Torso Shot (Distance to center: %1)", (_shotPos distance (getposASL _torso))];
	BONUS_ACCURACY_TORSO_INNER;
};

if (_shotPos distance (getposASL _torso) <= TORSO_OUTER_ZONE_DISTANCE) exitWith
{
	diag_log text format ["Outer Torso Shot (Distance to center: %1)", (_shotPos distance (getposASL _torso))];
	BONUS_ACCURACY_TORSO_OUTER;
};

diag_log text format ["No Bonus Shot (Distance to head: %1 Distance to torso: %2)", (_shotPos distance _head), (_shotPos distance _torso)];
0;	// return 0
