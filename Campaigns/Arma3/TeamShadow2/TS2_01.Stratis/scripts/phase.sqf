// constructs phase logic object with various properties
IGN_fnc_initPhaseLogic =
{
	params["_logic", "_targets", "_weapon"];
	diag_log text format ["IGN_fnc_initPhaseLogic: %1", _this];
	_logic setVariable ["TS2_targets", _targets];
	_logic setVariable ["TS2_targetsCount", count _targets];
	_logic setVariable ["TS2_weapon", _weapon];	// required weapon
	_logic setVariable ["TS2_shotsFired", 0];	// number of shots fired
	_logic setVariable ["TS2_hits", 0];			// number of hits
	_logic setVariable ["TS2_time", 0];			// time completed
	_logic setVariable ["TS2_accuracyBonus", 0];// bonus points accrued for accuracy
	_logic setVariable ["TS2_bonus", 0 ];		// bonus subscore (used in logic and calculation) (displays in real time for player)
	_logic setVariable ["TS2_penalties", 0];	// penalty points accrued during phase (displays in real time for player)
	_logic setVariable ["TS2_penaltyWrongWeapon", 0];	// penalty counter for wrong weapon in zone
	_logic setVariable ["TS2_penaltyMissedShots", 0];	// penalty counter for misses
	_logic setVariable ["TS2_penaltySkippedTargets", 0];// penalty counter for skipping/not hitting all targets in phase
};

IGN_fnc_initPhase1 =
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
	} forEach _targets;

	[logic_phase1, _targets, "SniperRifle"] call IGN_fnc_initPhaseLogic;
	//["Rifle_Long_Base_F","Rifle_Base_F","Rifle","RifleCore","Default"]
};

IGN_fnc_initPhase10 =
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
	} forEach _targets;

	[logic_phase10, _targets, "SniperRifle"] call IGN_fnc_initPhaseLogic;
	//["Rifle_Long_Base_F","Rifle_Base_F","Rifle","RifleCore","Default"]
};

// initializes all phases - called in trigger
IGN_fnc_initPhases =
{
	private _handle = [] spawn IGN_fnc_initPhase1;
	waitUntil {scriptDone _handle};

	{
		private _logic = _x select 0;
		private _trg = _x select 1;
		private _weap = _x select 2;
		private _targets = _trg nearObjects ["TargetBase", ((triggerArea _trg) select 0)]; // returns all popup/moving targets in area
		{
			_x animate ["terc", 1];
			_x setVariable ["TS2_logicphase", _logic];	// set a reference to the logic that houses this target (used in hitpart EH)
		} forEach _targets;

		[_logic, _targets, _weap] call IGN_fnc_initPhaseLogic;
	} foreach
	[
		[logic_phase2, trgPhase2, "SniperRifle"],
		[logic_phase3, trgPhase3, "SniperRifle"],
		[logic_phase4, trgPhase4, "Handgun"],
		[logic_phase5, trgPhase5, "SniperRifle"],
		[logic_phase6, trgPhase6, "Handgun"],
		[logic_phase7, trgPhase7, "SniperRifle"],
		[logic_phase8, trgPhase8, "Handgun"],
		[logic_phase9, trgPhase9, "Handgun"]
	];
	_handle = [] spawn IGN_fnc_initPhase10;
	waitUntil {scriptDone _handle};
};

// handler for HitPart attached to each target
IGN_fnc_hitPartHandler =
{
	diag_log text format ["hitPartHandler: %1", _this];
	//params ["_targetObj", "_shooter", "_bullet", "_pos", "_vel", "_hitParts", "_ammo", "_dir", "_radius", "_surface", "_direct"];
	private _targetObj = (_this select 0) select 0;
	private _shooter = (_this select 0) select 1;
	private _bullet = (_this select 0) select 2;
	private _hitParts = (_this select 0) select 5;
	private _ammo = (_this select 0) select 6;
	private _direct = (_this select 0) select 10;
	//diag_log text format ["HitPart %1", _this];
	//hint format ["hit part: %1", _hitParts];
	// appears that "target" is returned when hit in zone

	// player needs to be shooter, ammo must belong to specified weapon, and must be direct impact
	if (_shooter isEqualTo player && _direct) then
	{
		_targetObj removeEventHandler ["HitPart", (_targetObj getVariable "TS2_hitPartHandler")];	// remove handler
		_targetObj setVariable ["TS2_hitPartHandler", -1];	// index no longer valid
		private _l = _targetObj getVariable "TS2_logicphase";
		_L setVariable ["TS2_hits", (_l getVariable "TS2_hits") + 1];	// increment hits counter

		private _weapon = ((currentWeapon player) call BIS_fnc_itemtype) select 1;
		// in order to get accuracy bonus, the correct weapon must be selected
		if (_weapon isEqualTo (_l getVariable "TS2_weapon")) then
		{
			if ( ({_x == "target"} count _hitParts) != 0 ) then
			{
				// hit target in accuracy zone
				_l setVariable ["TS2_accuracyBonus", (_l getVariable "TS2_accuracyBonus")];	// increment accuracy bonus counter
			};
		}
		else
		{
			_l setVariable ["TS2_penaltyWrongWeapon", (_l getVariable "TS2_penaltyWrongWeapon") + 1];	// increment wrong weapon counter
		};

		// if this is the last of the targets hit during this phase, call end phase
		if ((_l getVariable "TS2_targetsCount") == (_l getVariable "TS2_hits")) then
		{
			_l call IGN_fnc_endPhase;
		};
	};
};

// calculates the scores / penalties for a phase
IGN_fnc_calculateScore =
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

	// calculate bonus
	private _bonus = ( (_logic getVariable "TS2_hits") * BONUS_HIT ) + ( (_logic getVariable "TS2_accuracyBonus") * BONUS_ACCURACY );
	_logic setVariable ["TS2_bonus", _bonus];

	if (_penalty_skiptargets > 0) then
	{
		hintC "Phase Not Completed";
	};
};

IGN_fnc_startPhase =
{
	private _logic = _this;
	hintC "Starting Phase";
	_logic setVariable ["TS2_time", time];	// start tracking time
	// if phase 1 - make all targets stand up
	//if (_logic == logic_phase1) then
	//{
		{
			_x animate ["terc", 0];
			private _h = _x addEventHandler ["HitPart", IGN_fnc_hitPartHandler];
			diag_log text format ["IGN_fnc_startPhase: BEFORE TS2_hitPartHandler: %1", (_x getVariable "TS2_hitPartHandler")];
			_x setVariable ["TS2_hitPartHandler", _h];	// check to see this will work (not sure if forEach will allow this)
			diag_log text format ["IGN_fnc_startPhase: AFTER TS2_hitPartHandler: %1", (_x getVariable "TS2_hitPartHandler")];
		} forEach (_logic getVariable "TS2_targets");
	//};
	CURRENT_PHASE = _logic;
};

IGN_fnc_endPhase =
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

	_logic call IGN_fnc_calculateScore;
	CURRENT_PHASE = objNull;

	if (_logic == logic_phase10) then
	{
		call IGN_fnc_endTest;
	};
};



// returns an array of strings that are later used to format a report of each phase
IGN_fnc_getPhaseScoreReport =
{
	private _logic = _this;
	private _report = [];
	private _phaseText = "";

	// calculate score
	private _hitScore = (_logic getVariable "TS2_hits") * BONUS_HIT;
	private _accBonus = (_logic getVariable "TS2_accuracyBonus") * BONUS_ACCURACY;
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
								[_hitScore, "MM:SS"] call BIS_fnc_secondsToString
							  ] );
	_report pushback ( format ["Accuracy Bonus (x%1): -%2",
								(_logic getVariable "TS2_accuracyBonus"),
								[_accBonus, "MM:SS"] call BIS_fnc_secondsToString
							  ] );
	_report pushback ( format ["Penalty - Wrong Weapon (x%1): +%2",
								(_logic getVariable "TS2_penaltyWrongWeapon"),
								[_wrongPenalty, "MM:SS"] call BIS_fnc_secondsToString
							  ] );
	_report pushback ( format ["Penalty - Missed Shot (x%1): +%2",
								(_logic getVariable "TS2_penaltyMissedShots"),
								[_missPenalty, "MM:SS"] call BIS_fnc_secondsToString
							  ] );
	_report pushback ( format ["Penalty - Skipped Targets (x%1): +%2",
								(_logic getVariable "TS2_penaltySkippedTargets"),
								[_skipPenalty, "MM:SS"] call BIS_fnc_secondsToString
							  ] );
	_report pushback ( format ["Bonus Gain: %1", [_deltaT, "MM:SS"] call BIS_fnc_secondsToString] );
	_report;	// return
};



IGN_fnc_getAllPhaseScores =
{
	private _score = 0;
	{
		private _subscore = (_x getVariable "TS2_penalties") - (_x getVariable "TS2_bonus");
		_score = _score + _subscore;
	} forEach [logic_phase1, logic_phase2, logic_phase3, logic_phase4, logic_phase5, logic_phase6, logic_phase7, logic_phase8, logic_phase9, logic_phase10];

	_score;
};