// this is scheduled call
//diag_log text format ["hitPartHandler: %1", _this];
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
	};
	/*
	else
	{
		TEST_PENALTIES = TEST_PENALTIES + PENALTY_WRONG_WEAPON;
		_l setVariable ["TS2_penaltyWrongWeapon", (_l getVariable "TS2_penaltyWrongWeapon") + 1];	// increment wrong weapon counter
	};
	*/

	// if this is the last of the targets hit during this phase, call end phase
	if ((_l getVariable "TS2_targetsCount") == (_l getVariable "TS2_hits")) then
	{
		_l call TS2_fnc_endPhase;
	};
};
