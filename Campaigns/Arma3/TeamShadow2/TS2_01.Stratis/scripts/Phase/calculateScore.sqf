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
