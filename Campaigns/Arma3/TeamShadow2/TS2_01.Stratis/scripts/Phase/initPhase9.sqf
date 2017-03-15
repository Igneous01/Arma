// scheduled call
private _railArrayHandles = [];
_railArrayHandles pushback ([phase9rail1,6,0,31,[1.2,-1,1,-1,objNull]] execVM "scripts\MovingTarget\initTargetRailExt.sqf");
_railArrayHandles pushback ([phase9rail2,13,0,31,[1.5,-1,0.5,-1,objNull]] execVM "scripts\MovingTarget\initTargetRailExt.sqf");
_railArrayHandles pushback ([phase9rail3,8,0,31,[2,-1,1.5,-1,objNull]] execVM "scripts\MovingTarget\initTargetRailExt.sqf");
{
	waitUntil {scriptDone _x;};
} forEach _railArrayHandles;

// swivel target parent class: "Target_Swivel_01_base_F"
// target base class: "TargetBase"
// rails are also part of TargetBase, so we need to filter these out ("Target_Rail_F")
private _targets = trgPhase9 nearObjects ["TargetBase", ((triggerArea trgPhase9) select 0)]; // returns all popup/moving targets in area
for "_i" from ((count _targets) - 1) to 0 step -1 do
{
	if ( (_targets select _i) isKindOf "Target_Rail_F" ) then
	{
		_targets deleteAt _i;
	};
};

//_targets append (trgPhase10 nearObjects ["Target_Swivel_01_base_F", ((triggerArea trgPhase10) select 0)]);

{
	_x animate ["terc", 1];
	_x setVariable ["TS2_logicphase", logic_phase9];	// set a reference to the logic that houses this target (used in hitpart EH)
	_x call TS2_fnc_initTargetZones;
} forEach _targets;

[logic_phase9, _targets, "Handgun"] call TS2_fnc_initPhaseLogic;
