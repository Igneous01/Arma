// Creates ambient AI shooting on shooting range
THD_AI_FIRE =
{
	params["_unit", "_tgt", "_min", "_max"];
	private _weapon = currentWeapon _unit;
	private _ammo = _unit ammo _weapon;
	_unit doWatch _tgt;
	_unit doTarget _tgt;
	sleep 5;
	_unit disableAI "MOVE";
	while {alive _unit} do
	{
		sleep (_min + (random _max));
		_unit forceWeaponFire [_weapon, "Single"];
	};
};

{
	_x spawn THD_AI_FIRE;
} forEach
[
	[shooter1, aitarget1, 10, 60],
	[shooter2, aitarget2, 15, 85],
	[shooter3, aitarget3, 20, 90],
	[shooter4, aitarget4, 15, 85],
	[shooter5, aitarget5, 10, 90],
	[shooter6, aitarget6, 15, 85]
];

/*
make sure you choose an appropriate rifle and scope - ranges go out to 1.3 km
once you start with your selected weapon, you cannot change to a different one

ranges from 500m to 1.2 km

the target is very small
*/
IGN_fnc_briefing =
{
	titleText ["Welcome to the range. Today we'll be examining your long range shooting skills.", "PLAIN DOWN", 0.5];
	sleep 5;
	titleText ["This assessment will test your accuracy, speed, and discipline to hit your target. Scoring hits earns points, scoring NO hits earns 0 points.", "PLAIN DOWN", 0.8];
	sleep 8;
	titleText ["There are 5 rounds: Each round a single target appears. You will have 5 minutes to calculate a firing solution and hit your target. You will have 3 shots at firing at your target. If you run out of time, or out of shots, the round is over.", "PLAIN DOWN", 1.5];
	sleep 15;
	titleText ["You gain score by getting hits quickly. You will be penalized for missing shots. The goal is to get 4000 points to graduate from Sniper School. Good Luck.", "PLAIN DOWN", 1];
	sleep 5;
	true call IGN_fnc_setTestTaskState;
	sleep 3;

	// duplicate the hint, because it will disappear after a few seconds, so keep it up longer
	for "_i" from 0 to 3 do
	{
		hint parseText "<t size='2' color='#ffff00'>UKD Assessment</t><br/><br/><t size='1.5' color='#ffff00'>Rules</t><br/>You can only use one rifle for this test. Once you start the test, you cannot leave the shooting position until it is completed. Leaving your position is an automatic failure.";
		sleep 3;
	};
};
