private _targetObj = (_this select 0) select 0;
private _shooter = (_this select 0) select 1;
private _bullet = (_this select 0) select 2;
private _pos = (_this select 0) select 3;
private _hitParts = (_this select 0) select 5;
private _ammo = (_this select 0) select 6;
private _direct = (_this select 0) select 10;

if (_shooter isEqualTo player && _direct && (count _hitParts) > 0) then
{
	_targetObj say "FD_Target_PopDown_Large_F";
	// if swivel target, use different logic for keeping the target down
	if (_targetObj isKindOf "Swivel") then
	{
		_targetObj animate [format ["Swivel_%1rpm_rot", 6], _targetObj animationPhase (format ["Swivel_%1rpm_rot", 6])];
		_targetObj animate ["terc", 1];
	};
};


