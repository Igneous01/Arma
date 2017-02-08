endmeeting = 0;
playerspotted = 0;

// weather settings
"colorcorrections" ppeffectadjust [1, 1, -0.0042*0, [0.0, 0.4, 1.0, -0.005*0], [2/9, 3/3, 3/3, 0.32], [3*0.8, -1.0*0.8, -0.9*0.8, 0.0]];
"colorcorrections" ppeffectcommit 1;
"colorcorrections" ppeffectenable true;
0 setovercast 0.7;

execVM "briefing.sqf";

execvm "RMM_Core.sqf";

// Spotting mode function initialization
DZ_FNC_SpottingMode = {
	private ["_spotter"]; 
      _spotter = _this select 0; 
      selectplayer _spotter; 
      (vehicle _spotter) switchcamera "GUNNER";
};
