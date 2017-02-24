#define TXTROUND 1000
#define TXTSHOTS 1001
#define TXTTIME 1002
disableSerialization;


//create game/round
IGN_fnc_createGame =
{
	private _unit = _this;
	private _tgt = TargetsArray call BIS_fnc_selectRandom;
	TargetsArray deleteAt (TargetsArray find _tgt);	// remove from list
	// create helper
	//private _helper = createVehicle ["Sign_Circle_F", getpos _tgt, [], 0, "CAN_COLLIDE"];
	private _helper = createVehicle ["ProtectionZone_F", getpos _tgt, [], 0, "CAN_COLLIDE"];
	_helper setpos [((getpos _helper) select 0), ((getpos _helper) select 1), 35];
	_helper setDir (getDir _tgt);
	_tgt hideObject false;

	// round related data
	_unit setVariable ["TS2_target", _tgt];		// target object
	_unit setVariable ["TS2_helper", _helper];	// helper object
	_unit setVariable ["TS2_shotsLeft", NUMSHOTS];		// shots player has left
	_unit setVariable ["TS2_targetHit", false];	// whether target was hit
	_unit setVariable ["TS2_roundDone", false];	// is the current round completed?
	_unit setVariable ["TS2_time", TIMEPERROUND];		// time left for shooter
	_unit setVariable ["TS2_round", (_unit getVariable "TS2_round") + 1];

	// Add HIT handler for target
	private _hitEH = _tgt addEventHandler ["hit",
	{
		params["_unit", "_causedBy", "_damage", "_instigator"];
		if (_instigator isEqualTo PlayerShooter) then
		{
			if (!(_instigator getVariable "TS2_roundDone")) then
			{
				_instigator setVariable ["TS2_targetHit", true];
			};
		};
	}];

	_unit setVariable ["TS2_hitEH", _hitEH];	// targets hit handler

	// Add FIRED handler for player
	private _shotEH = PlayerShooter addEventHandler ["fired",
	{
		params["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_mag", "_obj", "_gunner"];
		if (_unit isEqualTo PlayerShooter) then
		{
			[_unit, _obj] spawn
			{
				params ["_unit", "_obj"];
				_unit setVariable ["TS2_shotsLeft", (_unit getVariable "TS2_shotsLeft") - 1];

				waitUntil {!alive _obj;};	// waituntil the bullet has completed trajectory
				sleep 0.25;	// delay just in case the hit handler has not registered yet

				if (!(_unit getVariable "TS2_roundDone")) then
				{
					// if the target was hit, or the player is out of chances, stop the game
					if ( (_unit getVariable "TS2_targetHit") || ( (_unit getVariable "TS2_shotsLeft") <= 0) ) then
					{
						_unit call IGN_fnc_stopGame;
					};
				};
			};
		};
	}];

	_unit setVariable ["TS2_shotEH", _shotEH];	// units fired handler

	// add onEachFrame handler for HUD
	["updateHudH", "onEachFrame",
	{
		((uiNamespace getVariable "HUDLONGRANGE") displayCtrl TXTROUND) ctrlSetText (format ["Round: %1", (_this getVariable "TS2_round")]);
		((uiNamespace getVariable "HUDLONGRANGE") displayCtrl TXTSHOTS) ctrlSetText (format ["Shots Left: %1", (_this getVariable "TS2_shotsLeft")]);
		((uiNamespace getVariable "HUDLONGRANGE") displayCtrl TXTTIME) ctrlSetText (format ["Time Left: %1", (_this getVariable "TS2_time")]);
	}, _unit] call BIS_fnc_addStackedEventHandler;

	// spawn timer
	_timeH = _unit spawn
	{
		private _t = _this getVariable "TS2_time";

		for [{_i = _t}, {_i > 0}, {_i = _i - 1}] do
		{
			_this setVariable ["TS2_time", _i];
			sleep 1;
			if (_this getVariable "TS2_roundDone") exitWith {_this call IGN_fnc_stopGame;};
		};
	};

	_unit setVariable ["TS2_onEachFrameEH", "updateHudH"];
	_unit setVariable ["TS2_timeH", _timeH];
};


IGN_fnc_saveRoundResults =
{
	private _round = (_this getVariable "TS2_round");
	private _time = TIMEPERROUND - (_this getVariable "TS2_time");
	private _hit = (_this getVariable "TS2_targetHit");
	private _dist =  ( round (_this distance (_this getVariable "TS2_target")) ) / 100;
	private _shotsFired = 3 - (_this getVariable "TS2_shotsLeft");

	// round score formula
	// formulas chosen based on results from graphing here: https://www.desmos.com/calculator

	// target hit score = 100 * (range / 100)
	// time bonus = (3000 / time) * 3
	// penalties = (numMissedShots - 1) * (500 / range)

	private _rndScore = 0;
	if (_hit && _time < TIMEPERROUND) then
	{
		_rndScore = 100 * _dist;	// makes no sense dividing by 100 above, then multiplying here by 100
		_rndScore = _rndScore + ( ((TIMEPERROUND * 10) / _time) * 3 );
		_rndScore = round (_rndScore - ( (_shotsFired - 1) * ( 500 / _dist) ) );
	};
	// no hit = 0

	GamesReport pushback [_round, _time, _hit, _dist, _shotsFired, _rndScore];		// save this information
	_this setVariable ["TS2_score", (_this getVariable "TS2_score") + _rndScore];	// accumulate score

	_rndScore;	// return
};

// [Time,Format] call BIS_fnc_timeToString;
IGN_fnc_stopGame =
{
	private _unit = _this;
	// set round completed flag
	_unit setVariable ["TS2_roundDone", true];

	// remove handlers
	_unit removeEventHandler ["fired", (_unit getVariable "TS2_shotEH")];
	(_unit getVariable "TS2_target") removeEventHandler ["hit", (_unit getVariable "TS2_hitEH")];
	[(_unit getVariable "TS2_onEachFrameEH"), "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
	terminate (_unit getVariable "TS2_timeH");

	private _status = "Failed";
	if ((_unit getVariable "TS2_targetHit") && ((_unit getVariable "TS2_time") > 0)) then { _status = "Completed"; };

	// calculate score, store report
	private _rndScore = _unit call IGN_fnc_saveRoundResults;

	// update HUD
	((uiNamespace getVariable "HUDLONGRANGE") displayCtrl TXTROUND) ctrlSetText (format ["Round %1", _status]);
	((uiNamespace getVariable "HUDLONGRANGE") displayCtrl TXTSHOTS) ctrlSetText (format ["Points: %1", _rndScore]);
	((uiNamespace getVariable "HUDLONGRANGE") displayCtrl TXTTIME) ctrlSetText "";

	// spin up another game if we still have more rounds - otherwise quit
	if (_unit getVariable "TS2_round" < NUMROUNDS) then
	{
		_unit spawn
		{
			sleep 5;
			// delete and hide objects
			deleteVehicle (_this getVariable "TS2_helper");
			(_this getVariable "TS2_target") hideObject true;

			for [{_i = DELAYBETWEENROUNDS}, {_i > 0}, {_i = _i - 1}] do
			{
				sleep 1;
				((uiNamespace getVariable "HUDLONGRANGE") displayCtrl TXTTIME) ctrlSetText (format ["Starting In: %1", str _i]);
			};

			// create next round
			_this call IGN_fnc_createGame;
		};
	}
	else
	{
		TestComplete = true;

		_unit spawn
		{
			sleep 5;
			// delete and hide objects
			deleteVehicle (_this getVariable "TS2_helper");
			(_this getVariable "TS2_target") hideObject true;

			// update HUD
			((uiNamespace getVariable "HUDLONGRANGE") displayCtrl TXTROUND) ctrlSetText "Test Complete";
			((uiNamespace getVariable "HUDLONGRANGE") displayCtrl TXTSHOTS) ctrlSetText (format ["Score: %1", (_this getVariable "TS2_score")]);
			((uiNamespace getVariable "HUDLONGRANGE") displayCtrl TXTTIME) ctrlSetText "";

			// spawn hint, addAction to one of the rangemasters
			if ((_this getVariable "TS2_score") >= REQUIREDSCORE) then
			{
				"SUCCEEDED" call IGN_fnc_setTestTaskState;
				sleep 5;
				"end1" call BIS_fnc_endMission;
			}
			else
			{
				"FAILED" call IGN_fnc_setTestTaskState;
				sleep 5;
				"loser" call BIS_fnc_endMission;
			};
		};
	};
};

