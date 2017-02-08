//create variables
SeeAA1 = false;
SeeAA2 = false;
SeeAA3 = false;
SeeAA4 = false;
aacount = 0;
// load extra objects from 3d editor
execVM "Extras.sqf";

// Core Functions - for rangefinder script
execvm "RMM_Core.sqf";

//Briefing and Objectives
execvm "briefing.sqf";

// Spotting mode function initialization
DZ_FNC_SpottingMode = {
	private ["_spotter"]; 
      _spotter = _this select 0; 
      selectplayer _spotter; 
      (vehicle _spotter) switchcamera "GUNNER";
};



// Finish world initialization before mission is launched
//finishMissionInit;


// add weather effects
// weather settings
"colorcorrections" ppeffectadjust [1, 1, -0.0042*0, [0.0, 0.4, 1.0, -0.005*0], [2/9, 3/3, 3/3, 0.32], [3*0.8, -1.0*0.8, -0.9*0.8, 0.0]];
"colorcorrections" ppeffectcommit 1;
"colorcorrections" ppeffectenable true;