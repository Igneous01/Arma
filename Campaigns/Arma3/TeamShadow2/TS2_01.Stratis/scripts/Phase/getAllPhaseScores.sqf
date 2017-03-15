private _score = 0;
{
	private _subscore = (_x getVariable "TS2_penalties") - (_x getVariable "TS2_bonus");
	_score = _score + _subscore;
} forEach [logic_phase1, logic_phase2, logic_phase3, logic_phase4, logic_phase5, logic_phase6, logic_phase7, logic_phase8, logic_phase9, logic_phase10];

_score;
