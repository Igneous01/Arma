// scheduled call
private _railArrayHandles = [];
_railArrayHandles pushback ([phase2rail1,8,0,31,[1.2,-1,1,-1,objNull]] execVM "scripts\MovingTarget\initTargetRailExt.sqf"); // side to side top right building
_railArrayHandles pushback ([phase2rail2,7,0,31,[1.5,-1,0.5,-1,objNull]] execVM "scripts\MovingTarget\initTargetRailExt.sqf"); // side to side bottom left building
_railArrayHandles pushback ([phase2rail3,9,3,31,[2,-1,1.5,-1,objNull]] execVM "scripts\MovingTarget\initTargetRailExt.sqf"); // forward moving left building
_railArrayHandles pushback ([phase2rail4,8,0,31,[1,-1,0,-1,objNull]] execVM "scripts\MovingTarget\initTargetRailExt.sqf"); // side to side bottom right building
_railArrayHandles pushback ([phase2rail5,13,0,31,[2,-1,0.75,-1,objNull]] execVM "scripts\MovingTarget\initTargetRailExt.sqf"); // side to side right
_railArrayHandles pushback ([phase2rail6,7,0,31,[0.75,-1,1,-1,objNull]] execVM "scripts\MovingTarget\initTargetRailExt.sqf"); // side to side top right building
_railArrayHandles pushback ([phase2rail7,12,0,31,[1.2,-1,0.75,-1,objNull]] execVM "scripts\MovingTarget\initTargetRailExt.sqf"); // side to side top right building
_railArrayHandles pushback ([phase2rail8,15,3,31,[1.5,-1,1.5,-1,objNull]] execVM "scripts\MovingTarget\initTargetRailExt.sqf"); // forward moving left building
{
	waitUntil {scriptDone _x;};
} forEach _railArrayHandles;

// swivel target parent class: "Target_Swivel_01_base_F"
// target base class: "TargetBase"
// rails are also part of TargetBase, so we need to filter these out ("Target_Rail_F")
private _targets = trgPhase10 nearObjects ["TargetBase", ((triggerArea trgPhase10) select 0)]; // returns all popup/moving targets in area
for "_i" from ((count _targets) - 1) to 0 step -1 do
{
	if ( (_targets select _i) isKindOf "Target_Rail_F" ) then
	{
		_targets deleteAt _i;
	};
};

_targets append (trgPhase10 nearObjects ["Target_Swivel_01_base_F", ((triggerArea trgPhase10) select 0)]);

{
	_x animate ["terc", 1];
	_x setVariable ["TS2_logicphase", logic_phase10];	// set a reference to the logic that houses this target (used in hitpart EH)
	_x call TS2_fnc_initTargetZones;
} forEach _targets;

[logic_phase10, _targets, "SniperRifle"] call TS2_fnc_initPhaseLogic;
//["Rifle_Long_Base_F","Rifle_Base_F","Rifle","RifleCore","Default"]
