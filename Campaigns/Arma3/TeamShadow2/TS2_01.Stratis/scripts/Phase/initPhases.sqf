// initializes all phases - called in trigger
// scheduled call
private _handle = [] spawn TS2_async_initPhase1;
waitUntil {scriptDone _handle};

{
	private _logic = _x select 0;
	private _trg = _x select 1;
	private _weap = _x select 2;
	private _targets = _trg nearObjects ["TargetBase", ((triggerArea _trg) select 0)]; // returns all popup/moving targets in area
	{
		private _t = _x;
		_t animate ["terc", 1];						// set down
		_t setVariable ["TS2_logicphase", _logic];	// set a reference to the logic that houses this target (used in hitpart EH)
		_t call TS2_fnc_initTargetZones;
	} forEach _targets;

	[_logic, _targets, _weap] call TS2_fnc_initPhaseLogic;
} foreach
[
	[logic_phase2, trgPhase2, "SniperRifle"],
	[logic_phase3, trgPhase3, "SniperRifle"],
	[logic_phase4, trgPhase4, "Handgun"],
	[logic_phase5, trgPhase5, "SniperRifle"],
	[logic_phase6, trgPhase6, "Handgun"],
	[logic_phase7, trgPhase7, "SniperRifle"],
	[logic_phase8, trgPhase8, "Handgun"]
];
_handle = [] spawn TS2_async_initPhase9;
waitUntil {scriptDone _handle};
_handle = [] spawn TS2_async_initPhase10;
waitUntil {scriptDone _handle};
