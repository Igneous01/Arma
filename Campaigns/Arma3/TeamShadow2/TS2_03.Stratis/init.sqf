"scripts\IGN_EH" call compile preprocessfilelinenumbers "scripts\IGN_EH\IGN_EH_INIT.sqf";
"scripts\IGN_DLG" call compile preprocessfilelinenumbers "scripts\IGN_DLG\IGN_DLG_INIT.sqf";

// mission globals
GamesReport = [];	// stores report about each individual round
TargetsArray = (getpos trgTargets) nearObjects ["Land_Target_Oval_F", 500];
TestComplete = false;
TestStarted = false;

// constants
REQUIREDSCORE = 4000;	// required score
DELAYBETWEENROUNDS = 30;
TIMEPERROUND = 300;
NUMSHOTS = 3;
NUMROUNDS = 5;

// set vars
PlayerShooter setVariable ["TS2_round", 0];	// player current round
PlayerShooter setVariable ["TS2_score", 0];	// player score

call compile preprocessfilelinenumbers "scripts\gameFunctions.sqf";
call compile preprocessfilelinenumbers "scripts\misc.sqf";
call compile preprocessfilelinenumbers "scripts\tasks.sqf";

#define TXTROUND 1000
#define TXTSHOTS 1001
#define TXTTIME 1002

// some init actions
{ _x hideObject true; } forEach TargetsArray;	// hide targets prior to startup

// Add Action to the remote designator
ShooterPosition addAction ["Start Test",
{
	params["_target", "_caller", "_id"];
	_target removeAction _id;	// remove action
	TestStarted = true;			// set flag
	cutRsc ["HUDLONGRANGE","PLAIN"];	// show hud
	_caller spawn
	{
		disableSerialization;
		for [{_i = DELAYBETWEENROUNDS}, {_i > 0}, {_i = _i - 1}] do
		{
			((uiNamespace getVariable "HUDLONGRANGE") displayCtrl TXTROUND) ctrlSetText "Long Range Test";
			((uiNamespace getVariable "HUDLONGRANGE") displayCtrl TXTSHOTS) ctrlSetText "";
			((uiNamespace getVariable "HUDLONGRANGE") displayCtrl TXTTIME) ctrlSetText (format ["Starting In: %1", str _i]);
			sleep 1;
		};
		// create next round
		_this call IGN_fnc_createGame;
	};
}, nil, 1.5, true, true, "", "true", 5, false];



