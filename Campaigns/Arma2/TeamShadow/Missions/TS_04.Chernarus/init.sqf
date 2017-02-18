//////////////////////////////////////////////////////////////////
// Function file for Armed Assault
// Created by: TODO: Author Name
//////////////////////////////////////////////////////////////////

null = execVM "briefing.sqf";

// Core Functions - for rangefinder script
execvm "RMM_Core.sqf";

//Init UPSMON scritp
call compile preprocessFileLineNumbers "scripts\Init_UPSMON.sqf";		

// weather effects
//"colorcorrections" ppeffectadjust [0.4, 1, -0.0042, [0.4, 0.8, 0.7, -0.005*0], [5/9, 2/3, 3/3, 0.32], [3*0.8, -1.0*0.8, -0.9*0.8, 0.0]];
//"colorcorrections" ppeffectcommit 5;
//"colorcorrections" ppeffectenable true;
0 setFog 1;

// initializing functions to use in game

// random mortar fire function
if (isnil "DZ_fnc_MortarFire") then {
    DZ_fnc_MortarFire = {
        private ["_ammo", "_marker", "_xcoord", "_ycoord", "_timer", "_fire"];
        _ammo = _this select 0;
        _marker = _this select 1;
        _xcoord = _this select 2;
        _ycoord = _this select 3;
        _timer = _this select 4;
        _fire = true;
        while {_fire} do {
            _firerun = _ammo createvehicle [(getmarkerpos _marker select 0) + random _xcoord, (getmarkerpos _marker select 1) + random _ycoord, getmarkerpos _marker select 2];
            sleep (random _timer);
        };
    };
};

// random spawn function
if (isnil "DZ_fnc_RandomSpawn") then {
    DZ_fnc_RandomSpawn = {
        private ["_markers", "_unit", "_xrand", "_distance"];
        _markers = _this select 0;
        _unit = _this select 1;
        _xrand = _markers select floor(random(count _markers));
        //_unit setpos (getpos _xrand)
        [_unit,_xrand,30] execvm "shk_moveobjects.sqf";
    };
};

// Spotting mode function initialization
DZ_FNC_SpottingMode = {
	private ["_spotter"]; 
      _spotter = _this select 0; 
      selectplayer _spotter; 
      (vehicle _spotter) switchcamera "GUNNER";
};

// position artillery
_artyspawn = [[m1, m2, m3], artypiece] spawn DZ_fnc_RandomSpawn; 

sleep 3;

// position patrol
_patrolspawn = [guardleader, 20, artypiece, artypiece, 50, "AWARE", 100, "LIMITED", "FILE", 0, 0] execVM "USPS.sqf"; 

// Airsup scrpt init
ASfirstrun = true;

// Ambient Combat Module
sleep 2;
//ACM settings    
waitUntil {!isNil {BIS_ACM1 getVariable "initDone"}};
waitUntil {BIS_ACM1 getVariable "initDone"};
[] spawn {
    waitUntil {!(isnil "BIS_fnc_init")};
    [0.7, BIS_ACM1] call BIS_ACM_setIntensityFunc;                 //Sets the intensity of the ACM, in other words, determines how active it will be. Starts at 0 ends at 1.0, its been known to fail using 0.7 and 0.8
    [BIS_ACM1, 800, 1200] call BIS_ACM_setSpawnDistanceFunc;      // This is the radius on where the units will spawn around the unit the module is sync'd to, 400m being the minimal distance and 700m being the maximum. Minimum is 1 I believe. 
    [["USMC", "RU", "CDF", "GUE"], BIS_ACM1] call BIS_ACM_setFactionsFunc;     // This tells the ACM which faction of units it will spawn. In this case it will spawn Takistani Insurgents
    [0, 0.4, BIS_ACM1] call BIS_ACM_setSkillFunc;                // This determines what the skill rating for the spawned units will be
    [0.7, 0.8, BIS_ACM1] call BIS_ACM_setAmmoFunc;               // This sets their amount of ammo they spawn with
    ["ground_patrol", 1, BIS_ACM1] call BIS_ACM_setTypeChanceFunc; //If you want ground patrols then leave it as a 1, if you don't put a 0. They will use random paths
    ["air_patrol", 0, BIS_ACM1] call BIS_ACM_setTypeChanceFunc;    // Same thing for air patrols
    [BIS_ACM1, ["USMC_FireTeam", "USMC_FireTeam_AT", "USMC_MotInfSection_AT", "CDF_InfSection_MG", "RU_InfSquad", "RU_MotInfSection_Recon", "RU_InfSquad", "GUE_InfTeam_AT"]] call BIS_ACM_addGroupClassesFunc;   // This determines which exact units will spawn from the group **Citation needed**
};

finishmissioninit;



