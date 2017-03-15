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