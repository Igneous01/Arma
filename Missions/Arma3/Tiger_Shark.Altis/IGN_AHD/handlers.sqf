// event handler code for handleDamage
IGN_AHD_EH_handleDamage =
{
	private ["_veh", "_sel", "_dmgTaken"];
	_veh = _this select 0;	// assigned handler to this object
	_sel = _this select 1;	// selection name that was damaged (string)
	_dmgTaken = _this select 2;	// damage taken

	if (_dmgTaken < 0.1) exitWith {_dmgTaken;};

	if (_sel == (_veh getVariable "IGN_AHD_engine")) exitWith
	{
		_veh call IGN_AHD_updateEngineCollective;	// update the collective offset

		if (!(_veh getVariable "IGN_AHD_isEngineDamaged")) then
		{
			_veh setVariable ["IGN_AHD_isEngineDamaged", true];
			// spawn this handling effect
			_veh spawn IGN_AHD_T_modifyHandling;
		};

		if ( (_veh getHitPointDamage "HitEngine") >= 0.7 && (_veh getVariable "IGN_AHD_engineHasEffect") != 2) then
		{
			[_veh, 1] call IGN_AHD_createEngineDamageEffect;
			_veh setVariable ["IGN_AHD_engineHasEffect", 2];
		}
		else
		{
			if ( (_veh getHitPointDamage "HitEngine") >= 0.38 && (_veh getVariable "IGN_AHD_engineHasEffect") == 0) then
			{
				[_veh, 0] call IGN_AHD_createEngineDamageEffect;
				_veh setVariable ["IGN_AHD_engineHasEffect", 1];
			};
		};
		_dmgTaken;
	};

	_dmgTaken;
};

IGN_AHD_handleRepair =
{
	private ["_veh", "_dmg"];
	_veh = _this;
	if (_veh getVariable "IGN_AHD_isEngineDamaged") then
	{
		_veh setVariable ["IGN_AHD_isEngineDamaged", false];
	};
	_veh setVariable ["IGN_AHD_runningTime", 0];
	_veh setVariable ["IGN_AHD_interval", 0];
	_veh call IGN_AHD_updateEngineCollective;
	_veh call IGN_AHD_deleteEngineEffect;

};