IGN_AHD_Alert =
{
	// should be separate function
	private ["_Stxt", "_description", "_veh"];
	_veh = _this select 0;
	_description = _this select 1;
	_Stxt = parseText format
	["<t color='#FF3B3E' size='0.8'>Warning:</t><br/><t color='#ffff00' size='0.8'>%1</t><br/>", _description];
	playSound "alarm_industry";
	[_Stxt, 0, 0.2] call BIS_fnc_dynamicText;
};


// Modifies The handling of the vehicle, by adjusting the z velocity with an offset specified by the collective modifier
IGN_AHD_modifyZVelocity =
{
	private ["_veh", "_v", "_val"];
	_veh = _this;
	_val = _veh getVariable "IGN_AHD_engineCollectiveModifier";

	_v = velocity _veh;
	_veh setVelocity [_v select 0, _v select 1, (_v select 2) - _val];
};

// Updates the engine collective modifier to new value related to damage
IGN_AHD_updateEngineCollective =
{
	private ["_veh"];
	_veh = _this;
	_veh setVariable ["IGN_AHD_engineCollectiveModifier",
	(_veh getVariable "IGN_AHD_engineDamageCoefficient") * (_veh getHitPointDamage "HitEngine")];
};

// creates the engine damage effect
IGN_AHD_createEngineDamageEffect =
{
	private ["_veh", "_type", "_eff", "_effect"];
	_veh = _this select 0;
	_type = _this select 1;

	if (_type == 0) then
	{
		_effect = "SMOKE_MEDIUM";
	}
	else
	{
		if (_type == 1) then
		{
			//_effect = "test_EmptyObjectForSmoke";
			_effect = "FIRE_SMALL";
		};
	};

	// check if an effect currently exists, delete and replace with new one
	if ((_veh getVariable "IGN_AHD_engineHasEffect") != 0) then
	{
		{deleteVehicle _x} foreach (_veh getVariable "IGN_AHD_engineEffect");
	};

	_eff = [getpos _veh, _effect] call BIS_fn_createFireEffect;

	//_eff = _effect createVehicle (getpos _veh);
	{
		_x attachTo [_veh,[1.5,-1.8,-0.8]]; // attaches to right engine exhaust, simulates engine smoking
	} foreach _eff;	// _eff may return smoke and fire

	_veh setVariable ["IGN_AHD_engineEffect", _eff];
};





IGN_AHD_deleteEngineEffect =
{
	private ["_veh"];
	_veh = _this;
	if ((_veh getVariable "IGN_AHD_engineHasEffect") != 0) then
	{
		{
			detach _x;
			deleteVehicle _x;
		} foreach (_veh getVariable "IGN_AHD_engineEffect");

		_veh setVariable ["IGN_AHD_engineHasEffect", 0];
	};
};


// damage a specific hitpoint component
// _veh = vehicle
// _part = HitPoint Component (not the selection name!)
// _dmg = amount of damage to apply
// calls handleDamage handler to apply appropriate effects
IGN_AHD_damagePart =
{
	private ["_veh", "_dmg", "_part", "_selection", "_curDmg"];
	_veh = _this select 0;
	_part = _this select 1;
	_dmg = _this select 2;
	if ((damage _veh) == 0) then
	{_veh setDamage 0.08;};
	_curDmg = _veh getHitPointDamage _part;
	_veh setHitPointDamage [_part, _curDmg + _dmg];

	_selection = getText(configfile >> "CfgVehicles" >> (typeof _veh) >> "HitPoints" >> _part >> "name");
	[_veh, _selection, _dmg] call IGN_AHD_EH_handleDamage;	// call the handler
};


// Generates a random malfunction with vehicle, if preference is passed, it will have a 36.66% chance of being selected
IGN_AHD_randomMalfunction =
{
	private ["_veh", "_preference", "_damageProbability", "_dmg", "_roll", "_part", "_description"];
	_veh = _this select 0;
	_preference = _this select 1;	// number, denoting the component id

	// TODO: Once Munition damage implemented, set roll to random 6
	_roll = floor(random 5);	// 16.66% chance for each component to be chosen
	_part = "";
	_dmg = 0;

	// if preference is not negative (0 or greater) increase the probability for that component to be selected
	if (_preference >= 0) then {
		// 30% chance that the preferred component will be selected instead (+ 16.66%)

		// CHANGE THIS BACK TO 20% later!!!!
		if ((random 100) < 20) then
		{
			_roll = _preference;
		};
	};

	// translate roll to component name
	switch (_roll) do
	{
		// fuel
		case 0:
		{_part = "HitFuel"; _description = "Fuel Leak";};

		// engine
		case 1:
		{_part = "HitEngine"; _description = "Engine Anomaly";};

		// main rotar
		case 2:
		{_part = "HitHRotor"; _description = "Main Rotor Anomaly";};

		// tail rotar
		case 3:
		{_part = "HitVRotor"; _description = "ATRQ Rotor Anomaly";};

		// instruments
		case 4:
		{_part = "HitAvionics"; _description = "Power Loss";};

		// munitions (UNUSED)
		case 5:
		{_part = "HitMissiles"; _description = "Weapon Malfunction";};
	};

	// determine damage severity to be applied
	_damageProbability = (random 100);
	// 60% chance only light damage will occur
	if (_damageProbability >= 0 && _damageProbability < 60) then
	{
		_dmg = 0.25;	//0.15
	}
	else
	{
		// 30% chance medium damage will occur
		if (_damageProbability >= 60 && _damageProbability < 90) then
		{
			_dmg = 0.4;		//0.4
		}
		else
		{
			// 10% chance heavy damage will occur
			if (_damageProbability >= 90 && _damageProbability < 100) then
			{
				_dmg = 0.6;		//0.6
			};
		};
	};

	//player sidechat format ["_part: %1       _dmg: %2", _part, _dmg];

	[_veh, _description] spawn IGN_AHD_Alert;

	// damage component
	[_veh, _part, _dmg] call IGN_AHD_damagePart;
};


// TRY THIS FOR FIRE/SMOKE EFFECTS
BIS_fn_createFireEffect = {
	private["_effect","_pos","_fire","_smoke", "_obj"];
	private["_light","_brightness","_color","_ambient","_intensity","_attenuation"];

	_pos 	= _this select 0;
	_effect = _this select 1;

	_fire	= "";
	_smoke	= "";
	_light	= objNull;
	_obj = [];	// return effect
	_color		= [1,0.85,0.6];
	_ambient	= [1,0.3,0];

	switch (_effect) do {
		case "FIRE_SMALL" : {
			_fire 	= "SmallDestructionFire";
			_smoke 	= "MediumDestructionSmoke";
		};
		case "FIRE_MEDIUM" : {
			_fire 	= "MediumDestructionFire";
			_smoke 	= "MediumDestructionSmoke";
			_brightness	= 1.0;
			_intensity	= 400;
			_attenuation	= [0,0,0,2];
		};
		case "FIRE_BIG" : {
			_fire 	= "BigDestructionFire";
			_smoke 	= "BigDestructionSmoke";
			_brightness	= 1.0;
			_intensity	= 1600;
			_attenuation	= [0,0,0,1.6];
		};
		case "SMOKE_SMALL" : {
			_smoke 	= "SmallDestructionSmoke";
		};
		case "SMOKE_MEDIUM" : {
			//_smoke 	= "MediumSmoke";
			_smoke 	= "MediumDestructionSmoke";
		};
		case "SMOKE_BIG" : {
			_smoke 	= "BigDestructionSmoke";
		};
	};

	if (_fire != "") then {
		_eFire = "#particlesource" createVehicleLocal _pos;
		_eFire setParticleClass _fire;
		_eFire setPosATL _pos;
		_obj = [_eFire];
	};

	if (_smoke != "") then {
		_eSmoke = "#particlesource" createVehicleLocal _pos;
		_eSmoke setParticleClass _smoke;
		_eSmoke setPosATL _pos;
		_obj = _obj + [_eSmoke];
	};

	//create lightsource
	if (_effect in ["FIRE_BIG","FIRE_MEDIUM"]) then {
		_pos   = [_pos select 0,_pos select 1,(_pos select 2)+1];
		_light = createVehicle ["#lightpoint", _pos, [], 0, "CAN_COLLIDE"];
		_light setPosATL _pos;

		_light setLightBrightness _brightness;
		_light setLightColor _color;
		_light setLightAmbient _ambient;
		_light setLightIntensity _intensity;
		_light setLightAttenuation _attenuation;
		_light setLightDayLight false;
	};

	_obj;	// return effect object
};