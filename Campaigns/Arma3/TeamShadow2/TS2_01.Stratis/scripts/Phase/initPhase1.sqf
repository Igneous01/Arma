// scheduled call
// first create the railings and moving targets
private _createRailhandle1 = [phase1rail1,11,0,31,[1.2,-1,0,-1,objNull]] execVM "scripts\MovingTarget\initTargetRailExt.sqf";	// side to side sandbags middle
private _createRailhandle2 = [phase1rail2,7,0,21,[1,-1,2,-1,objNull]] execVM "scripts\MovingTarget\initTargetRailExt.sqf";	// side to side rocks right
private _createRailhandle3 = [phase1rail3,11,0,11,[2,-1,3,-1,objNull]] execVM "scripts\MovingTarget\initTargetRailExt.sqf";	// side to side long far left
private _createRailhandle4 = [phase1rail4,8,2,11,[2.5,-1,0,-1,objNull]] execVM "scripts\MovingTarget\initTargetRailExt.sqf";	// side to side next to bunker
private _createRailhandle5 = [phase1rail5,20,3,11,[1,-1,1,-1,objNull]] execVM "scripts\MovingTarget\initTargetRailExt.sqf";	// forward moving target

{
	waitUntil {scriptDone _x;};
} forEach [_createRailhandle1, _createRailhandle2, _createRailhandle3, _createRailhandle4, _createRailhandle5];

// swivel target parent class: "Target_Swivel_01_base_F"
// target base classL "TargetBase"
// rails are also part of TargetBase, so we need to filter these out ("Target_Rail_F")
private _targets = trgPhase1 nearObjects ["TargetBase", ((triggerArea trgPhase1) select 0)]; // returns all popup/moving targets in area
for "_i" from ((count _targets) - 1) to 0 step -1 do
{
	if ( (_targets select _i) isKindOf "Target_Rail_F" ) then
	{
		_targets deleteAt _i;
	};
};
{
	_x animate ["terc", 1];
	_x setVariable ["TS2_logicphase", logic_phase1];	// set a reference to the logic that houses this target (used in hitpart EH)
	_x call TS2_fnc_initTargetZones;
} forEach _targets;

[logic_phase1, _targets, "SniperRifle"] call TS2_fnc_initPhaseLogic;
//["Rifle_Long_Base_F","Rifle_Base_F","Rifle","RifleCore","Default"]
