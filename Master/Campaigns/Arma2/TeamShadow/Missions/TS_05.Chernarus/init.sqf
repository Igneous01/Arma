// extra objects in mission
_garbage = execVM "Extras.sqf";

// Core Functions - for rangefinder script
_garbage2 = execvm "RMM_Core.sqf";

// briefing
_garbage3 = execVM "briefing.sqf";

// Spotting mode function initialization
DZ_FNC_SpottingMode = {
	private ["_spotter"]; 
      _spotter = _this select 0; 
      selectplayer _spotter; 
      (vehicle _spotter) switchcamera "GUNNER";
};

// Sniper auto fire function initilization
DZ_FNC_AI_FIRE = {
	private ["_unit", "_timeleast", "_timemax"];
	_unit = _this select 0;
	_timeleast = _this select 1;
	_timemax = _this select 2;
      while {alive _unit} do
	{
		sleep _timeleast;
		_unit action ["useWeapon",_unit,_unit,0];
		sleep (random _timemax);
	};
};

//finish loading mission before starting
finishMissionInit;





