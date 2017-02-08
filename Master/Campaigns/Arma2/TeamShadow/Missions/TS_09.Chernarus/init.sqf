// briefing
_garbage2 = execVM "briefing.sqf";

// Core Functions - for rangefinder script
_garbage1 = execvm "RMM_Core.sqf";

//Init Burn
BIS_fnc_burn = compile preprocessFile "\ca\Data\ParticleEffects\Scripts\Destruction\burn.sqf";

// Spotting mode function initialization
if (isnil "DZ_FNC_SpottingMode") then {
	DZ_FNC_SpottingMode = {
		private ["_spotter"]; 
      	_spotter = _this select 0; 
      	selectplayer _spotter; 
      	(vehicle _spotter) switchcamera "GUNNER";
	};
};

randomlocation = round (floor (random 2));

if (randomlocation == 0) then {
	apt_sniper setPosATL [12255.2,9509.64,5.80502];apt_sniper setDir 338.794;
};
if (randomlocation == 1) then {
	apt_sniper setPosATL [12257.7,9513.14,9.91303];apt_sniper setDir 24.6297;  
};
if (randomlocation == 2) then {
	apt_sniper setPosATL [12264.9,9507.77,9.91303];apt_sniper setDir 135.872;
};

// Ambient Combat Module
sleep 2;
//ACM settings    
waitUntil {!isNil {BIS_ACM1 getVariable "initDone"}};
waitUntil {BIS_ACM1 getVariable "initDone"};
[] spawn {
    waitUntil {!(isnil "BIS_fnc_init")};
    [0.5, BIS_ACM1] call BIS_ACM_setIntensityFunc;                 //Sets the intensity of the ACM, in other words, determines how active it will be. Starts at 0 ends at 1.0, its been known to fail using 0.7 and 0.8
    [BIS_ACM1, 850, 1500] call BIS_ACM_setSpawnDistanceFunc;      // This is the radius on where the units will spawn around the unit the module is sync'd to, 400m being the minimal distance and 700m being the maximum. Minimum is 1 I believe. 
    [["INS"], BIS_ACM1] call BIS_ACM_setFactionsFunc;     // This tells the ACM which faction of units it will spawn. In this case it will spawn Takistani Insurgents
    [0, 0.5, BIS_ACM1] call BIS_ACM_setSkillFunc;                // This determines what the skill rating for the spawned units will be
    [0.7, 0.8, BIS_ACM1] call BIS_ACM_setAmmoFunc;               // This sets their amount of ammo they spawn with
    ["ground_patrol", 1, BIS_ACM1] call BIS_ACM_setTypeChanceFunc; //If you want ground patrols then leave it as a 1, if you don't put a 0. They will use random paths
    ["air_patrol", 0, BIS_ACM1] call BIS_ACM_setTypeChanceFunc;    // Same thing for air patrols
    [BIS_ACM1, ["INS_InfSquad_Weapons", "INS_InfSection_AT", "INS_MilitiaSquad", "INS_MotInfSection", "INS_MechInfSection"]] call BIS_ACM_addGroupClassesFunc;   // This determines which exact units will spawn from the group **Citation needed**
};


