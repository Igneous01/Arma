// RUIS script (Random Unit Invasion Script)

// example: nul = ["RU", [spawn1, spawn2, spawn3], attackwp, spawntimer, Scripttime] execVM "RUIS.sqf"
// "RU" - faction name
// [spawn1, ...] - gamelogics for units to spawn on
// attackwp - spawned units will move to this waypoint 
// spawntimer - amount of time to wait until the spawning of a new unit 
// scripttime - amount of time the script will run until it terminates

private ["_spawntime", "_logicS", "_logicE", "_temptime", "_scripttime", "_unit", "_perc"];
_unit = _this select 0;
_logicS = _this select 1;
_logicE = _this select 2;
_spawntime = _this select 3;
_scripttime = _this select 4;

// check what side was chosen, and assimilate proper values

// Russian faction
//if (true) then {
    _unit setVariable ["infantry", ["RU_InfSection_MG", "RU_InfSection_AT", "RU_InfSection"], true];
    _unit setVariable ["lightarmor", ["RU_MotInfSection_Recon", "RU_MotInfSection_Patrol"], true];
    _unit setVariable ["armor",  ["RU_TankPlatoon"], true];
    _unit setVariable ["air", ["RU_Mi24VSquadron", "RU_Mi24PSquadron"], true];
//};

// Functions for spawn

if (isnil "DZ_Spawn_INF") then {
	DZ_Spawn_INF = {
        private ["_unit", "_loc", "_wp", "_spawned", "_logicS", "_logicE", "_unitarray"];
        _unit = _this select 0;
        _logicS = _this select 1;
        _logicE = _this select 2;
	// spawn infantry a random of 3 times
    for "_i" from 1 to (ceil(random 4)) do 
        {
            _unitarray = (_unit getVariable "infantry") select floor(random(count (_unit getVariable "infantry")));
            _loc = _logicS select floor(random(count _logicS));
            // spawn random units
            _spawned = [getPos _loc, EAST, (configFile >> "CfgGroups" >> "East" >> "RU" >> "Infantry" >> _unitarray),[],[],[],[],[],180] call BIS_fnc_spawnGroup;
            // move units to waypoint
            _wp = _spawned addWaypoint [position _logicE, 0];
            _wp setWaypointType "SAD"; 
            _wp setWaypointSpeed "NORMAL";
            [_spawned, 0] setWaypointBehaviour "AWARE";
            sleep (random 20);
        };
    };	
};

if (isnil "DZ_Spawn_LA") then {
    DZ_Spawn_LA = {
        private ["_unit", "_loc", "_wp", "_spawned", "_logicS", "_logicE", "_unitarray"];
        _unit = _this select 0;
        _logicS = _this select 1;
        _logicE = _this select 2;
        
        // spawn vehicle a random of 3 times
    for "_i" from 1 to (ceil(random 3)) do 
        {
            _unitarray = (_unit getVariable "lightarmor") select floor(random(count (_unit getVariable "lightarmor")));
            _loc = _logicS select floor(random(count _logicS));
            // spawn random units
            _spawned = [getPos _loc, EAST, (configFile >> "CfgGroups" >> "East" >> "RU" >> "Motorized" >> _unitarray),[],[],[],[],[],180] call BIS_fnc_spawnGroup;
            
            // move units to waypoint
            _wp = _spawned addWaypoint [getpos _logicE, 0];
            _wp setWaypointType "SAD"; 
            _wp setWaypointSpeed "NORMAL";
            [_spawned, 0] setWaypointBehaviour "AWARE";
            sleep (random 50);
        };
    };	
};

if (isnil "DZ_Spawn_ARM") then {
    DZ_Spawn_ARM = {
        private ["_unit", "_loc", "_wp", "_spawned", "_logicS", "_logicE", "_unitarray"];
        _unit = _this select 0;
        _logicS = _this select 1;
        _logicE = _this select 2;
        // spawn armor a random of 3 times
        _unitarray = (_unit getVariable "armor") select floor(random(count (_unit getVariable "armor")));
        _loc = _logicS select floor(random(count _logicS));
        // spawn random units
        _spawned = [getPos _loc, EAST, (configFile >> "CfgGroups" >> "East" >> "RU" >> "Armored" >> _unitarray),[],[],[],[],[],180] call BIS_fnc_spawnGroup;
        // move units to waypoint
        _wp = _spawned addWaypoint [getpos _logicE, 0];
        _wp setWaypointType "SAD"; 
        _wp setWaypointSpeed "NORMAL";
        [_spawned, 0] setWaypointBehaviour "AWARE";
    };	
};

if (isnil "DZ_Spawn_AIR") then {
    DZ_Spawn_AIR = {
        private ["_unit", "_loc", "_wp", "_spawned", "_logicS", "_logicE", "_unitarray"];
        _unit = _this select 0;
        _logicS = _this select 1;
        _logicE = _this select 2;
        // spawn air a random of 3 times
        _unitarray = (_unit getVariable "air") select floor(random(count (_unit getVariable "air")));
        _loc = _logicS select floor(random(count _logicS));
        // spawn random units
        _spawned = [getPos _loc, EAST, (configFile >> "CfgGroups" >> "East" >> "RU" >> "Air" >> _unitarray),[],[],[],[],[],180] call BIS_fnc_spawnGroup;
        // move units to waypoint
        _wp = _spawned addWaypoint [getpos _logicE, 0];
        _wp setWaypointType "SAD"; 
        _wp setWaypointSpeed "NORMAL";
        [_spawned, 0] setWaypointBehaviour "AWARE";
    };	
};

while {_scripttime > 0} do {
    _perc = round(random 100);
    //x=round(random 5)
    _scripttime = _scripttime - 1;
    _temptime = _spawntime;
    //hint format ["percentage: %1", _perc];
    
    _infspawn = [_unit, _logicS, _logicE] spawn DZ_Spawn_INF;
    if (_perc < 31) then {
        _laspawn = [_unit, _logicS, _logicE] spawn DZ_Spawn_LA;
    };
    waitUntil {sleep 1; _temptime = _temptime - 1; _temptime < 1};
};
