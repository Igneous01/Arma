// exponential function
// each uniform interval increases the probability of malfunction occuring
// if it doesn't, increase by p = p + i^2
// after 6 intervals, the probability goes from 1.3% to 92% chance a failure will occur
// invoke via spawn
// raises event when probability is true
IGN_AHD_T_malfunction =
{
	private ["_veh", "_chance", "_factor", "_probability", "_closeLoop", "_interval", "_preference"];
	_veh = _this select 0;
	_chance = _this select 1;
	_preference = _this select 2;
	_factor = 300;	// 5 minutes (testing)
	_probability = _chance;
	while {(!isNull _veh || alive _veh) && (_veh getVariable "IGN_AHD_malfunctionRunning")} do
	{
		sleep 1;
		if (isEngineOn _veh) then
		{
			_veh setVariable ["IGN_AHD_runningTime", (_veh getVariable "IGN_AHD_runningTime") + 1];

			if ((_veh getVariable "IGN_AHD_runningTime") > _factor) then
			{
				if ((random 100) < _probability) then
				{
					//player sidechat "Malfunction has occured.";
					[_veh, _preference] call IGN_AHD_randomMalfunction;
					// reset
					_veh setVariable ["IGN_AHD_runningTime", 0];
					_probability = _chance;
					_veh setVariable ["IGN_AHD_interval", 0];
				}
				else
				{
					_veh setVariable ["IGN_AHD_interval", (_veh getVariable "IGN_AHD_interval") + 1];
					_probability = _probability + ((_veh getVariable "IGN_AHD_interval") ^ 2);	// exponential increase
					_veh setVariable ["IGN_AHD_runningTime", 0];	// reset runtime
				};
			};
		};
		//hint format ["_runtime: %1                 _probability: %2                _interval: %3", (_veh getVariable "IGN_AHD_runningTime"), _probability, (_veh getVariable "IGN_AHD_interval")];
	};
};


// invoked via spawn
IGN_AHD_T_modifyHandling =
{
	private ["_veh"];
	_veh = _this;
	//player sidechat "thread spawned...";
	while {alive _veh && isEngineOn _veh && (_veh getVariable "IGN_AHD_isEngineDamaged")} do
	{
		_veh call IGN_AHD_modifyZVelocity;				// modify velocity
		sleep 0.3;
	};
	//player sidechat "thread terminated...";

/*
	// destroy smoke 5 seconds after
	if ((_veh getVariable "IGN_AHD_engineHasEffect") != 0) then
	{
		_veh spawn
		{
			sleep 5;
			_this call IGN_AHD_removeEngineEffect;

		};
	};
*/
};