// constructs phase logic object with various properties
TS2_fnc_initPhaseLogic =
{
	params["_logic", "_targets", "_weapon"];
	diag_log text format ["TS2_fnc_initPhaseLogic: %1", _this];
	_logic setVariable ["TS2_targets", _targets];
	_logic setVariable ["TS2_targetsCount", count _targets];
	//_logic setVariable ["TS2_started", false];	// whether phase has started - used to prevent triggers from reactivating
	_logic setVariable ["TS2_weapon", _weapon];	// required weapon
	_logic setVariable ["TS2_shotsFired", 0];	// number of shots fired
	_logic setVariable ["TS2_hits", 0];			// number of hits
	_logic setVariable ["TS2_time", 0];			// time completed
	_logic setVariable ["TS2_accuracyHits", 0]; // bonus counter for accuracy
	_logic setVariable ["TS2_bonus", 0 ];		// bonus subscore (used in logic and calculation) (displays in real time for player)
	_logic setVariable ["TS2_penalties", 0];	// penalty points accrued during phase (displays in real time for player)
	_logic setVariable ["TS2_penaltyWrongWeapon", 0];	// penalty counter for wrong weapon in zone
	_logic setVariable ["TS2_penaltyMissedShots", 0];	// penalty counter for misses
	_logic setVariable ["TS2_penaltySkippedTargets", 0];// penalty counter for skipping/not hitting all targets in phase
};

TS2_fnc_initTargetZones =
{
	private _t = _this;
	// check to see if target has accuracy zones defined
	{
		private _tClass = _x select 0;
		//diag_log text format ["typeOf target: %1 class expected: %2", (typeOf _t), _tClass];
		if ((typeOf _t) isEqualTo _tClass) exitWith
		{
			diag_log text format ["Found target %1 with class %2 - creating zones", _t, _tClass];
			private _tHead = _x select 1;
			private _tTorso = _x select 2;
			// using the same logic as BIS - simply create a dummy object, attach it to the model coordinates, then compute using distance in the HitPart handler to determine if the shot was inside the accuracy zone
			private _zoneHead = "Sign_Sphere10cm_F" createVehicle (getpos _t);
			_zoneHead attachTo [_t, _tHead];
			private _zoneTorso = "Sign_Sphere10cm_F" createVehicle (getpos _t);
			_zoneTorso attachTo [_t, _tTorso];
			_t setVariable ["TS2_accuracyZones", [_zoneHead, _zoneTorso]];
		};
	} forEach TARGET_ZONE_ARRAY;
};

TS2_fnc_initPhase1 =
{
	// first create the railings and moving targets
	private _createRailhandle1 = [phase1rail1,11,0,31,[1.2,-1,0,-1,objNull]] execVM "scripts\initTargetRailExt.sqf";	// side to side sandbags middle
	private _createRailhandle2 = [phase1rail2,7,0,21,[1,-1,2,-1,objNull]] execVM "scripts\initTargetRailExt.sqf";	// side to side rocks right
	private _createRailhandle3 = [phase1rail3,11,0,11,[2,-1,3,-1,objNull]] execVM "scripts\initTargetRailExt.sqf";	// side to side long far left
	private _createRailhandle4 = [phase1rail4,8,2,11,[2.5,-1,0,-1,objNull]] execVM "scripts\initTargetRailExt.sqf";	// side to side next to bunker
	private _createRailhandle5 = [phase1rail5,20,3,11,[1,-1,1,-1,objNull]] execVM "scripts\initTargetRailExt.sqf";	// forward moving target

	{
		waitUntil {scriptDone _x;};
	} forEach [_createRailhandle1, _createRailhandle2, _createRailhandle3, _createRailhandle4, _createRailhandle5];

	// swivel target parent class: "Target_Swivel_01_base_F"
	// target base classL "TargetBase"
	// rails are also part of TargetBase, so we need to filter these out ("Target_Rail_F")
	private _targets = trgPhase1 nearObjects ["TargetBase", ((triggerArea trgPhase1) select 0)]; // returns all popup/moving targets in area
	for "_i" from ((count _targets) - 1) to 0 step -1 do
	{
		if ( (_targets select _i) isKindOf "Target_Rail_F" ) then
		{
			_targets deleteAt _i;
		};
	};
	{
		_x animate ["terc", 1];
		_x setVariable ["TS2_logicphase", logic_phase1];	// set a reference to the logic that houses this target (used in hitpart EH)
		_x call TS2_fnc_initTargetZones;
	} forEach _targets;

	[logic_phase1, _targets, "SniperRifle"] call TS2_fnc_initPhaseLogic;
	//["Rifle_Long_Base_F","Rifle_Base_F","Rifle","RifleCore","Default"]
};

TS2_fnc_initPhase9 =
{
	private _railArrayHandles = [];
	_railArrayHandles pushback ([phase9rail1,6,0,31,[1.2,-1,1,-1,objNull]] execVM "scripts\initTargetRailExt.sqf");
	_railArrayHandles pushback ([phase9rail2,13,0,31,[1.5,-1,0.5,-1,objNull]] execVM "scripts\initTargetRailExt.sqf");
	_railArrayHandles pushback ([phase9rail3,8,0,31,[2,-1,1.5,-1,objNull]] execVM "scripts\initTargetRailExt.sqf");
	{
		waitUntil {scriptDone _x;};
	} forEach _railArrayHandles;

	// swivel target parent class: "Target_Swivel_01_base_F"
	// target base class: "TargetBase"
	// rails are also part of TargetBase, so we need to filter these out ("Target_Rail_F")
	private _targets = trgPhase9 nearObjects ["TargetBase", ((triggerArea trgPhase9) select 0)]; // returns all popup/moving targets in area
	for "_i" from ((count _targets) - 1) to 0 step -1 do
	{
		if ( (_targets select _i) isKindOf "Target_Rail_F" ) then
		{
			_targets deleteAt _i;
		};
	};

	//_targets append (trgPhase10 nearObjects ["Target_Swivel_01_base_F", ((triggerArea trgPhase10) select 0)]);

	{
		_x animate ["terc", 1];
		_x setVariable ["TS2_logicphase", logic_phase9];	// set a reference to the logic that houses this target (used in hitpart EH)
		_x call TS2_fnc_initTargetZones;
	} forEach _targets;

	[logic_phase9, _targets, "Handgun"] call TS2_fnc_initPhaseLogic;
	//["Rifle_Long_Base_F","Rifle_Base_F","Rifle","RifleCore","Default"]
};

TS2_fnc_initPhase10 =
{
	private _railArrayHandles = [];
	_railArrayHandles pushback ([phase2rail1,8,0,31,[1.2,-1,1,-1,objNull]] execVM "scripts\initTargetRailExt.sqf"); // side to side top right building
	_railArrayHandles pushback ([phase2rail2,7,0,31,[1.5,-1,0.5,-1,objNull]] execVM "scripts\initTargetRailExt.sqf"); // side to side bottom left building
	_railArrayHandles pushback ([phase2rail3,9,3,31,[2,-1,1.5,-1,objNull]] execVM "scripts\initTargetRailExt.sqf"); // forward moving left building
	_railArrayHandles pushback ([phase2rail4,8,0,31,[1,-1,0,-1,objNull]] execVM "scripts\initTargetRailExt.sqf"); // side to side bottom right building
	_railArrayHandles pushback ([phase2rail5,13,0,31,[2,-1,0.75,-1,objNull]] execVM "scripts\initTargetRailExt.sqf"); // side to side right
	_railArrayHandles pushback ([phase2rail6,7,0,31,[0.75,-1,1,-1,objNull]] execVM "scripts\initTargetRailExt.sqf"); // side to side top right building
	_railArrayHandles pushback ([phase2rail7,12,0,31,[1.2,-1,0.75,-1,objNull]] execVM "scripts\initTargetRailExt.sqf"); // side to side top right building
	_railArrayHandles pushback ([phase2rail8,15,3,31,[1.5,-1,1.5,-1,objNull]] execVM "scripts\initTargetRailExt.sqf"); // forward moving left building
	{
		waitUntil {scriptDone _x;};
	} forEach _railArrayHandles;

	// swivel target parent class: "Target_Swivel_01_base_F"
	// target base class: "TargetBase"
	// rails are also part of TargetBase, so we need to filter these out ("Target_Rail_F")
	private _targets = trgPhase10 nearObjects ["TargetBase", ((triggerArea trgPhase10) select 0)]; // returns all popup/moving targets in area
	for "_i" from ((count _targets) - 1) to 0 step -1 do
	{
		if ( (_targets select _i) isKindOf "Target_Rail_F" ) then
		{
			_targets deleteAt _i;
		};
	};

	_targets append (trgPhase10 nearObjects ["Target_Swivel_01_base_F", ((triggerArea trgPhase10) select 0)]);

	{
		_x animate ["terc", 1];
		_x setVariable ["TS2_logicphase", logic_phase10];	// set a reference to the logic that houses this target (used in hitpart EH)
		_x call TS2_fnc_initTargetZones;
	} forEach _targets;

	[logic_phase10, _targets, "SniperRifle"] call TS2_fnc_initPhaseLogic;
	//["Rifle_Long_Base_F","Rifle_Base_F","Rifle","RifleCore","Default"]
};

// initializes all phases - called in trigger
TS2_fnc_initPhases =
{
	private _handle = [] spawn TS2_fnc_initPhase1;
	waitUntil {scriptDone _handle};

	{
		private _logic = _x select 0;
		private _trg = _x select 1;
		private _weap = _x select 2;
		private _targets = _trg nearObjects ["TargetBase", ((triggerArea _trg) select 0)]; // returns all popup/moving targets in area
		{
			private _t = _x;
			_t animate ["terc", 1];						// set down
			_t setVariable ["TS2_logicphase", _logic];	// set a reference to the logic that houses this target (used in hitpart EH)
			_t call TS2_fnc_initTargetZones;
		} forEach _targets;

		[_logic, _targets, _weap] call TS2_fnc_initPhaseLogic;
	} foreach
	[
		[logic_phase2, trgPhase2, "SniperRifle"],
		[logic_phase3, trgPhase3, "SniperRifle"],
		[logic_phase4, trgPhase4, "Handgun"],
		[logic_phase5, trgPhase5, "SniperRifle"],
		[logic_phase6, trgPhase6, "Handgun"],
		[logic_phase7, trgPhase7, "SniperRifle"],
		[logic_phase8, trgPhase8, "Handgun"]
	];
	_handle = [] spawn TS2_fnc_initPhase9;
	waitUntil {scriptDone _handle};
	_handle = [] spawn TS2_fnc_initPhase10;
	waitUntil {scriptDone _handle};
};


TS2_fnc_calculateAccuracyBonus =
{
	params ["_target", "_shotPos"];
	diag_log text format ["target: %1, accuracyZones: %2", _target, (_target getVariable "TS2_accuracyZones")];
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
};



// handler for HitPart attached to each target
TS2_fnc_hitPartHandler =
{
	diag_log text format ["hitPartHandler: %1", _this];
	//params ["_targetObj", "_shooter", "_bullet", "_pos", "_vel", "_hitParts", "_ammo", "_dir", "_radius", "_surface", "_direct"];
	private _targetObj = (_this select 0) select 0;
	private _shooter = (_this select 0) select 1;
	private _bullet = (_this select 0) select 2;
	private _pos = (_this select 0) select 3;
	private _hitParts = (_this select 0) select 5;
	private _ammo = (_this select 0) select 6;
	private _direct = (_this select 0) select 10;
	//diag_log text format ["HitPart %1", _this];
	//hint format ["hit part: %1", _hitParts];
	// appears that "target" is returned when hit in zone

	// player needs to be shooter, and must be direct impact
	if (_shooter isEqualTo player && _direct && (count _hitParts) > 0) then
	{
		// remove handler, and reset index to -1
		_targetObj removeEventHandler ["HitPart", (_targetObj getVariable "TS2_hitPartHandler")];
		_targetObj setVariable ["TS2_hitPartHandler", -1];

		// update hits counters and score
		private _l = _targetObj getVariable "TS2_logicphase";
		_L setVariable ["TS2_hits", (_l getVariable "TS2_hits") + 1];	// increment hits counter
		_L setVariable ["TS2_bonus", (_l getVariable "TS2_bonus") + BONUS_HIT];	// add to bonus
		TEST_BONUSES = TEST_BONUSES + BONUS_HIT;

		// in order to get accuracy bonus, the correct weapon must be selected
		// check if correct weapon is used
		private _weapon = ((currentWeapon player) call BIS_fnc_itemtype) select 1;
		if (_weapon isEqualTo (_l getVariable "TS2_weapon")) then
		{
			private _bonus = [_targetObj, _pos] call TS2_fnc_calculateAccuracyBonus;
			if (_bonus > 0) then
			{
				// hit target in accuracy zone
				_l setVariable ["TS2_accuracyHits", (_l getVariable "TS2_accuracyHits") + 1];
				_l setVariable ["TS2_bonus", (_l getVariable "TS2_bonus") + _bonus];
				TEST_BONUSES = TEST_BONUSES + _bonus;
			};
		}
		else
		{
			TEST_PENALTIES = TEST_PENALTIES + PENALTY_WRONG_WEAPON;
			_l setVariable ["TS2_penaltyWrongWeapon", (_l getVariable "TS2_penaltyWrongWeapon") + 1];	// increment wrong weapon counter
		};

		// if this is the last of the targets hit during this phase, call end phase
		if ((_l getVariable "TS2_targetsCount") == (_l getVariable "TS2_hits")) then
		{
			_l call TS2_fnc_endPhase;
		};
	};
};

// calculates the scores / penalties for a phase
TS2_fnc_calculateScore =
{
	private _logic = _this;

	// calculate penalties (if the player went ahead to next phase and did not complete all targets)
	private _penalty_skiptargets = (_logic getVariable "TS2_targetsCount") - (_logic getVariable "TS2_hits");
	private _penalty_missedshots = (_logic getVariable "TS2_shotsFired") - (_logic getVariable "TS2_hits");
	private _penalty_wrongweapon = (_logic getVariable "TS2_penaltyWrongWeapon");

	// update scores - note that TS2_penaltyWrongWeapon is tracked inside the HitPart handler
	_logic setVariable ["TS2_penaltySkippedTargets", _penalty_skiptargets];
	_logic setVariable ["TS2_penaltyMissedShots", _penalty_missedshots];
	//_logic setVariable ["TS2_penaltyWrongWeapon"];
	_logic setVariable ["TS2_penalties", (_penalty_skiptargets * PENALTY_SKIPPED_TARGET) +
										 (_penalty_missedshots * PENALTY_MISSED_SHOT) +
										 (_penalty_wrongweapon * PENALTY_WRONG_WEAPON)];

	// wrong weapon score is already calculated in real time, not included here
	TEST_PENALTIES = TEST_PENALTIES + (_penalty_skiptargets * PENALTY_SKIPPED_TARGET);
	TEST_PENALTIES = TEST_PENALTIES + (_penalty_missedshots * PENALTY_MISSED_SHOT);

	if (_penalty_skiptargets > 0) then
	{
		hintC "Phase Not Completed";
	};
};

TS2_fnc_startPhase =
{
	private _logic = _this;
	if ( (_logic getVariable "TS2_time") > 0) exitWith {};
	hintC "Starting Phase";
	_logic setVariable ["TS2_time", time];	// start tracking time
	// if phase 1 - make all targets stand up
	//if (_logic == logic_phase1) then
	//{
		{
			_x animate ["terc", 0];
			private _h = _x addEventHandler ["HitPart", TS2_fnc_hitPartHandler];
			diag_log text format ["TS2_fnc_startPhase: BEFORE TS2_hitPartHandler: %1", (_x getVariable "TS2_hitPartHandler")];
			_x setVariable ["TS2_hitPartHandler", _h];	// check to see this will work (not sure if forEach will allow this)
			diag_log text format ["TS2_fnc_startPhase: AFTER TS2_hitPartHandler: %1", (_x getVariable "TS2_hitPartHandler")];
		} forEach (_logic getVariable "TS2_targets");
	//};
	CURRENT_PHASE = _logic;
};

TS2_fnc_endPhase =
{
	if (isNull CURRENT_PHASE) exitWith {};
	hintC "Ending Phase";
	private _logic = _this;
	private _timeElapsed = time - (_logic getVariable "TS2_time");
	_logic setVariable ["TS2_time", _timeElapsed];	// set the time the phase was completed in

	// remove handlers from targets, and set them down (if not already set)
	{
		if ((_x getVariable "TS2_hitPartHandler") != -1) then
		{
			_x removeEventHandler ["HitPart", (_x getVariable "TS2_hitPartHandler")];
		};
		_x animate ["terc", 1];
	} forEach (_logic getVariable "TS2_targets");

	_logic call TS2_fnc_calculateScore;

	if (_logic == logic_phase10) then
	{
		call TS2_fnc_endTest;
	};

	CURRENT_PHASE = objNull;
};



// returns an array of strings that are later used to format a report of each phase
TS2_fnc_getPhaseScoreReport =
{
	private _logic = _this;
	private _report = [];
	private _phaseText = "";

	// calculate score
	private _hitScore = (_logic getVariable "TS2_hits") * BONUS_HIT;
	private _accBonus = (_logic getVariable "TS2_bonus") - _hitScore;
	private _wrongPenalty = (_logic getVariable "TS2_penaltyWrongWeapon") * PENALTY_WRONG_WEAPON;
	private _missPenalty = (_logic getVariable "TS2_penaltyMissedShots") * PENALTY_MISSED_SHOT;
	private _skipPenalty = (_logic getVariable "TS2_penaltySkippedTargets") * PENALTY_SKIPPED_TARGET;
	private _deltaT = (_wrongPenalty + _missPenalty + _skipPenalty) - (_hitScore + _accBonus);


	if (_logic isEqualTo logic_phase1) then { _phaseText = "Phase 1"; }
	else
	{
		if (_logic isEqualTo logic_phase2) then { _phaseText = "Phase 2"; }
		else
		{
			if (_logic isEqualTo logic_phase3) then { _phaseText = "Phase 3"; }
			else
			{
				if (_logic isEqualTo logic_phase4) then { _phaseText = "Phase 4"; }
				else
				{
					if (_logic isEqualTo logic_phase5) then { _phaseText = "Phase 5"; }
					else
					{
						if (_logic isEqualTo logic_phase6) then { _phaseText = "Phase 6"; }
						else
						{
							if (_logic isEqualTo logic_phase7) then { _phaseText = "Phase 7"; }
							else
							{
								if (_logic isEqualTo logic_phase8) then { _phaseText = "Phase 8"; }
								else
								{
									if (_logic isEqualTo logic_phase9) then { _phaseText = "Phase 9"; }
									else
									{
										if (_logic isEqualTo logic_phase10) then { _phaseText = "Phase 10"; };
									};
								};
							};
						};
					};
				};
			};
		};
	};

	_report pushback _phaseText;
	_report pushback ( format ["Time: %1", (_logic getVariable "TS2_time")] );
	_report pushback ( format ["Hits (x%1): -%2",
								(_logic getVariable "TS2_hits"),
								[abs _hitScore, "MM:SS.MS"] call BIS_fnc_secondsToString
							  ] );
	_report pushback ( format ["Accuracy Bonus (x%1): -%2",
								(_logic getVariable "TS2_accuracyHits"),
								[abs _accBonus, "MM:SS.MS"] call BIS_fnc_secondsToString
							  ] );
	_report pushback ( format ["Penalty - Wrong Weapon (x%1): +%2",
								(_logic getVariable "TS2_penaltyWrongWeapon"),
								[abs _wrongPenalty, "MM:SS.MS"] call BIS_fnc_secondsToString
							  ] );
	_report pushback ( format ["Penalty - Missed Shot (x%1): +%2",
								(_logic getVariable "TS2_penaltyMissedShots"),
								[abs _missPenalty, "MM:SS.MS"] call BIS_fnc_secondsToString
							  ] );
	_report pushback ( format ["Penalty - Skipped Targets (x%1): +%2",
								(_logic getVariable "TS2_penaltySkippedTargets"),
								[abs _skipPenalty, "MM:SS.MS"] call BIS_fnc_secondsToString
							  ] );
	private _deltaTString = "";
	if (_deltaT > 0) then
	{
		_deltaTString = format ["Gain/Loss: +%1", [abs _deltaT, "MM:SS.MS"] call BIS_fnc_secondsToString];
	}
	else
	{
		_deltaTString = format ["Gain/Loss: -%1", [abs _deltaT, "MM:SS.MS"] call BIS_fnc_secondsToString];
	};
	_report pushback _deltaTString;
	_report;	// return
};



TS2_fnc_getAllPhaseScores =
{
	private _score = 0;
	{
		private _subscore = (_x getVariable "TS2_penalties") - (_x getVariable "TS2_bonus");
		_score = _score + _subscore;
	} forEach [logic_phase1, logic_phase2, logic_phase3, logic_phase4, logic_phase5, logic_phase6, logic_phase7, logic_phase8, logic_phase9, logic_phase10];

	_score;
};