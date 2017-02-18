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

//finish loading mission before starting
finishMissionInit;





