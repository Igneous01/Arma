/*
	IGN Authentic Helicopter Damage
	Gives more realistic damage to helicopters when receiving damage
*/

/*
	Helicopter hitpoints
	"tail rotor" - anti torque rotar
	"main rotor" - main rotar
	"motor" - engines
	"munice" - munitions?
	"karoserie" - radar?

	// better alternative
	getText(configfile >> "CfgVehicles" >> "O_Heli_Attack_02_F" >> "HitPoints" >> "HitFuel" >> "name")	// fuel
	getText(configfile >> "CfgVehicles" >> "O_Heli_Attack_02_F" >> "HitPoints" >> "HitAvionics" >> "name")   // instruments
	getText(configfile >> "CfgVehicles" >> "O_Heli_Attack_02_F" >> "HitPoints" >> "HitEngine" >> "name") // engines
	getText(configfile >> "CfgVehicles" >> "O_Heli_Attack_02_F" >> "HitPoints" >> "HitHRotor" >> "name") // main rotar
	getText(configfile >> "CfgVehicles" >> "O_Heli_Attack_02_F" >> "HitPoints" >> "HitMissiles" >> "name") // all munitions (not working)
	getText(configfile >> "CfgVehicles" >> "O_Heli_Attack_02_F" >> "HitPoints" >> "HitVRotor" >> "name") // tail rotar

	// Engine Damage Visual
	EF_fnc_createEffect
	smokeParticle attachTo [(vehicle player),[2,-3,-1]]; // attaches to right engine exhaust, simulates engine smoking

	coefficient: 1.2222 // multiply this by damage, returns engineCollectiveModifier
*/


private ["_vehicle", "_isEngineDamaged", "_isMissileDamaged", "_chance", "_preference"];
_vehicle = _this select 0;
_chance = _this select 1;
_preference = _this select 2;

if (_chance < 0) exitWith{};	// disables mechanical damage if 'none' was selected

_isEngineDamaged = false;
if ((_vehicle getHitPointDamage "HitEngine") > 0.1) then
{
	_isEngineDamaged = true;
};
_isMissileDamaged = false;
if ((_vehicle getHitPointDamage "HitMissiles") > 0.1) then
{
	_isMissileDamaged = true;
};

_vehicle setVariable ["IGN_AHD_malfunctionRunning", false];
_vehicle setVariable ["IGN_AHD_runningTime", 0];
_vehicle setVariable ["IGN_AHD_interval", 0];

/*
_vehicle setVariable ["IGN_AHD_isMissileDamaged", _isMissileDamaged];
_vehicle setVariable ["IGN_AHD_missileDamage", _vehicle getHitPointDamage "HitMissiles"];
_vehicle setVariable ["IGN_AHD_missile", getText(configfile >> "CfgVehicles" >> (typeof _vehicle) >> "HitPoints" >> "HitMissiles" >> "name")];
*/
_vehicle setVariable ["IGN_AHD_isEngineDamaged", _isEngineDamaged];
_vehicle setVariable ["IGN_AHD_engineDamage", _vehicle getHitPointDamage "HitEngine"];
_vehicle setVariable ["IGN_AHD_engineDamageCoefficient", 1.1222];	// multiply this by damage, returns engineCollectiveModifier
_vehicle setVariable ["IGN_AHD_engineCollectiveModifier", 0];
_vehicle setVariable ["IGN_AHD_engine", getText(configfile >> "CfgVehicles" >> (typeof _vehicle) >> "HitPoints" >> "HitEngine" >> "name")];
_vehicle setVariable ["IGN_AHD_engineEffect", objNull];
_vehicle setVariable ["IGN_AHD_engineHasEffect", 0];

/* DEBUG PURPOSES
_vehicle spawn
{
	while {alive _this} do
	{
		hint str (velocity _this);
		sleep 0.2;
	};
};
*/

// add event handlers
_vehicle addEventHandler ["handleDamage", IGN_AHD_EH_HandleDamage];
_vehicle addEventHandler ["Engine",
{
	private ["_veh"];
	_veh = _this select 0;

	if (_veh getVariable "IGN_AHD_isEngineDamaged") then
	{
		if (_this select 1) then
		{
			_veh spawn IGN_AHD_T_ModifyHandling;
			[_veh, (_veh getVariable "IGN_AHD_engine"), (_veh getHitPointDamage "HitEngine")] call IGN_AHD_EH_HandleDamage;
		};
	};
}];

// chance
_vehicle setVariable ["IGN_AHD_malfunctionRunning", true];
[_vehicle, _chance, _preference] spawn IGN_AHD_T_malfunction;


