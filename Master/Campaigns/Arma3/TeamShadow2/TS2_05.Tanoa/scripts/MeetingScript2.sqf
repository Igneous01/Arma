
// Meeting Script v1.0 by DZ
// Simplifies the task of making a meeting and accounts for all possible outcomes of the meeting

// how to use:
// null = [[unit1, exit1pos, "animation1"], [unit2, exit2pos, "animation2"], meetingpos, delaytime, meetingtime] execVM "meetscript.sqf"
// unit1/unit2 - the units you are dealing with (make sure they are group leaders)
// meetingpos - the name of a gamelogic (but can be any other object as well)
// animA/animB - The movename to play. ex "ActsPercMstpSnonWunaDnon_sceneNikitinDisloyalty_Nikitin" - make sure the quotes are inbetween the movename
// ExitA/ExitB - the names of gamelogics (or any object) for the units to leave/escape to
// delaytime - The amount of time to wait before the units will move to the meeting area
// Meetingtime - the amount of time the meeting will last

// To synchronize the meeting with waypoints:
// call the script within the act field of a waypoint. but change "null" to a more meaninful name ex. "meetinghandle"
// add another waypoint thats right beside the first one
// in the condition field put : ScriptDone meetinghandle
// add whatever other waypoints u want the unit to go to after the meeting has ended and they reached the final position.

// To make one unit go to meet another one, without the other unit moving:
// null = [[unit1, exit1pos, "animation1"], [unit2, exit2pos, "animation2"], unit2, delaytime, meetingtime] execVM "meetscript.sqf"
// where meetpos becomes the name of the unit you want to wait.
//
private ["_obj1properties", "_obj2properties", "_meet_pos", "_meet_start_time", "_meet_length_time",
"_units"];

// validate arguments
if (count _this != 5) exitWith
{
    hintC "MeetingScript: Invalid Arguments provided - expected array with format  [[unit1, exit1pos, 'animation1'], [unit2, exit2pos, 'animation2'], meetingpos, delaytime, meetingtime]";
};

_obj1properties = _this select 0; // array format [unit, exit_pos, animation]
_obj2properties = _this select 1;

if (count _obj1properties != 3) exitWith
{
    hintC "MeetingScript: Invalid Arguments provided for [obj1Array] - expected array with format [unit, exit_pos, animation]";
};
if (count _obj2properties != 3) exitWith
{
    hintC "MeetingScript: Invalid Arguments provided for [obj2Array] - expected array with format [unit, exit_pos, animation]";
};

if (typeName (_this select 2) == "OBJECT") then
{
    _meet_pos = getPos (_this select 2);
}
else
{
    _meet_pos = _this select 2;
};

_meet_start_time = _this select 3;
_meet_length_time = _this select 4;
_units = [_obj1properties select 0, _obj2properties select 0];

{
    private["_unit", "_exitPos", "_animation"];
    _unit = _x select 0;
    _exitPos = _x select 1;
    _animation = _x select 2;

    diag_log text format["MeetingScript: Initial Arguments: [unit: %1, pos: %2, anim: %3]", _unit, _exitPos, _animation];

    if (typeName _exitPos == "OBJECT") then
    {
        _unit setVariable ["MeetingScript_exit", getPos _exitPos];
    }
    else
    {
        _unit setVariable ["MeetingScript_exit", _exitPos];
    };
    _unit setVariable ["MeetingScript_animation", _animation];
} forEach [_obj1properties, _obj2properties];

{
    private["_veh"];
    _veh = assignedVehicle _x;
    // Possible values for MeetingScript_status
    // 0 - Default State, safe
    // 1 - Unit is ready and is performing meeting, safe
    // 2 - Units have finished their meeting and are going back, safe
    // 3 - Unit is retreating due to enemy spotted, shots fired, wounded, etc, notsafe
    // 4 - Unit has reached final destination, end script
    _x setVariable ["MeetingScript_status", 0];
    _x setVariable ["MeetingScript_invehicle", false];
    _x setVariable ["MeetingScript_vehiclename", _veh];
    _x setVariable ["MeetingScript_group", group _x];
    _x setVariable ["MeetingScript_allunits", units group _x];

    // if the unit has an assigned vehicle that is either helicopter or landvehicle type, set the vehicle crew properties
    if (_veh isKindOf "Helicopter" Or _veh isKindOf "LandVehicle") then
    {
        private ["_driver", "_gunner", "_veh_units", "_defenders"];
        _veh_units = [];
        _driver = assignedDriver _veh;
        _gunner = assignedGunner _veh;
        // do not include driver in list if the unit is the assigned driver
        if (_driver != _x) then
        {
            _veh_units set [count _veh_units, _driver];
        };
        // include gunner in list if exists, but not if the unit is the assigned gunner
        if (!(isNull _gunner)) then
        {
            if (_gunner != _x) then
            {
                _veh_units set [count _veh_units, _gunner];
            };
        };
        _defenders = (_x getVariable "MeetingScript_allunits") - _veh_units;
        _defenders = _defenders - [_x];
        _x setVariable ["MeetingScript_vehicleunits", _veh_units];  // save driver and gunner as seperate list
        _x setVariable ["MeetingScript_getoutunits", (_x getVariable "MeetingScript_allunits") - _veh_units];   // units that can get out of vehicle
         _x setVariable ["MeetingScript_defenderunits", _defenders]; // defenders - units that will stay behind to defend while the unit and vehicle crew escape
         _x setVariable ["MeetingScript_hasvehicle", true];
    }
    else
    {
        _x setVariable ["MeetingScript_vehicleunits", []]; // save driver and gunner as seperate list
        _x setVariable ["MeetingScript_getoutunits", []];
         _x setVariable ["MeetingScript_defenderunits", []];
         _x setVariable ["MeetingScript_hasvehicle", false];
    };
} foreach _units;

// Near Position threaded method - invoked only with spawn
THD_DZ_Near = {
    private ["_unit", "_pos", "_dist", "_group", "_getoutunits", "_vehicleunits", "_defenders", "_veh", "_hasvehicle"];
    _unit = _this select 0;
    _pos = _this select 1;
    _group = _unit getVariable "MeetingScript_group";
    _getoutunits = _unit getVariable "MeetingScript_getoutunits";
    _vehicleunits = _unit getVariable "MeetingScript_vehicleunits";
    _defenders = _unit getVariable "MeetingScript_defenderunits";
    _veh = _unit getVariable "MeetingScript_vehiclename";
    _hasvehicle = _unit getVariable "MeetingScript_hasvehicle";

    diag_log text format["Meeting Script: Spawned new thread THD_DZ_Near for %1", _unit];
    diag_log text format["Meeting Script: THD_DZ_Near Arguments [unit: %1, pos: %2, group: %3, getoutunits: %4, vehicleunits: %5, defenders: %6, vehicle: %7]",
    _unit, _pos, _group, _getoutunits, _vehicleunits, _defenders, _veh];

    // calculate distance to meeting position if in defualt state
    if ((_unit getVariable "MeetingScript_status") == 0) then {
        while {(_unit getVariable "MeetingScript_status") == 0} do {
            _dist = _unit distance _pos;

            // check if the unit is in a vehicle before determining what distance to check
            if (_hasvehicle) then
            {
                // if unit is in a helicopter
                if ((_unit getVariable "MeetingScript_invehicle") == 1 && vehicle _unit isKindOf "Helicopter" && _dist < 180) then {
                    _getoutunits orderGetIn false;
                    _veh land "Land";  // land helicopter
                    // stop the pilot from staying in formation

                    // wait until the pilot has landed, the pilot is dead, the group has detected enemy, or the unit is dead
                    waituntil {unitReady assignedDriver _veh or _unit getVariable "MeetingScript_status" == 3 or !alive _unit or !alive assignedDriver _veh};

                    // if the pilot is ready, proceed with unloading units
                    if (unitReady assignedDriver _veh) then {
                        sleep 10;
                        // wait until the unit is out of the chopper
                        waitUntil {vehicle _unit == _unit or !alive _unit or (_unit getVariable "MeetingScript_status") == 3 };
                        diag_log text format ["Unit [%1] has left helicopter", _unit];
                        if (!alive _unit) then {
                            _unit setVariable ["MeetingScript_status", 3];
                        };
                        _group setSpeedMode "LIMITED";
                        _unit setVariable ["MeetingScript_invehicle", 0];
                    };
                    // if the pilot/unit is dead or enemies have been detected, abort the landing
                    if (_unit getVariable "MeetingScript_status" == 3 or !alive _unit or !alive assignedDriver _veh) then {
                        _veh land "NONE";
                        _unit setVariable ["MeetingScript_status", 3];
                        _getoutunits orderGetIn true;
                    };
                };

                // If the unit is in a land vehicle
                if ((_unit getVariable "MeetingScript_invehicle") == 1 && vehicle _unit isKindOf "LandVehicle" && _dist < 45) then {
                    diag_log "MeetingScript: Land Vehicle is in range of meeting position";

                    // stop driver from returning to formation with leader
                    {_x forceSpeed 0; doStop _x;} foreach _vehicleunits;
                    _getoutunits orderGetIn false;

                    waitUntil {
                        {vehicle _x == _x} count _getoutunits == count _getoutunits
                        or !alive _unit
                        or (_unit getVariable "MeetingScript_status") == 3
                    };
                    diag_log text format ["Unit [%1] has left ground vehicle", _unit];
                    sleep 8;
                    _unit MoveTo _pos;
                    _unit DoMove _pos;  // order them to continue moving to position again

                    // if the driver/unit is dead or enemies detected abort getting out
                    if (_unit getVariable "MeetingScript_status" == 3 or !alive _unit or !alive assignedDriver _veh) then {
                        _unit setVariable ["MeetingScript_status", 3];
                    }
                    // if everything is okay
                    else {
                        _group setSpeedMode "LIMITED";
                        _unit setVariable ["MeetingScript_invehicle", 0];
                    };
                };
            };
            // check the distance the units needs to be in in order to be ready for the meeting
            if (_dist < 6) then {
                _unit setVariable ["MeetingScript_status", 1];
            };
            sleep 0.5;
        };
    };
};




// thread to check if units were assigned a vehicle, and move them inside the vehicle if they are not in it
THD_DZ_VehicleStatus = {
    private ["_unit", "_vehiclename", "_unitgrouplist", "_driver", "_unitdefenders", "_groupdefenders"];
    _unit = _this select 0;
    _vehiclename = _unit getVariable "MeetingScript_vehiclename";
    _unitgrouplist = _unit getVariable "MeetingScript_allunits";

    diag_log text format["Meeting Script: Called FNC_DZ_VehicleStatus for %1", _unit];

    // if the unit has no vehicle
    if (isNull _vehiclename) then
    {
        _unit setVariable ["MeetingScript_invehicle", 0];
    }
    // if the unit has a vehicle
    else
    {
        _driver = assignedDriver _vehiclename;

        // prepare to split groups if enemy detected
        _unitdefenders = _unit getVariable "MeetingScript_defenderunits";

        // if the unit is in the vehicle
        if (_unit in _vehiclename) then
        {
            (group _unit) setSpeedMode "NORMAL";
            _unit setVariable ["MeetingScript_invehicle", 1];
        }
        // if not in vehicle check for further parameters
        else
        {
            // if unit has detected enemy or is under fire
            if ((_unit getVariable "MeetingScript_status") == 3 or !alive _unit) then
            {
                // split group to make guards defend the units escape
                _unitdefenders join grpnull;
                {unassignVehicle _x} foreach _unitdefenders;
                _groupdefenders = group (_unitdefenders select 0);
                _unitdefenders join _groupdefenders;
                _groupdefenders setCombatMode "RED";
                _groupdefenders setBehaviour "COMBAT";
                [_unit] ordergetin true;

                // wait until the unit is in the vehicle or is not alive or vehicle is immobile
                waitUntil
                {
                    (_unit in _vehiclename)
                    or (!alive _unit)
                    or (!alive _driver)
                    or !(canMove (_unit getVariable "MeetingScript_vehiclename"))
                };

                // if unit in vehicle
                if (_unit in _vehiclename) then
                {
                    _unit setVariable ["MeetingScript_invehicle", 1];
                }
                // if unit not in vehicle
                else
                {
                    _unit setVariable ["MeetingScript_invehicle", 0];
                    [_unit] ordergetin false;
                };

                // once in vehicle make the ai avoid combat and quickly escape
                (group _unit) setSpeedMode "FULL";
                (group _unit) setBehaviour "CARELESS";
            }
            // if the unit has not detected any enemies and is not in any danger
            else
            {
                _unitgrouplist orderGetIn true;
                // waituntil the unit is in the vehicle or is not alive or vehicle destroyed
                waitUntil {(_unit in _vehiclename) or !alive _unit or !alive _driver};
                if (_unit in _vehiclename) then
                {
                    _unit setVariable ["MeetingScript_invehicle", 1];
                    (group _unit) setSpeedMode "NORMAL";
                }
                else
                {
                    _unit setVariable ["MeetingScript_invehicle", 0];
                    [_unit] ordergetin false;
                    (group _unit) setSpeedMode "FULL";
                };
            };
        };
        // have the vehicle units follow the leader again so they can receive commands
        //_unitgrouplist doFollow _unit;
        {_x forceSpeed -1; _x doFollow _unit;} foreach (_unit getVariable "MeetingScript_vehicleunits");
    };
};








// Timer Function
THD_DZ_Timer = {
private ["_timeleft"];
diag_log text "Meeting Script: Called FNC_DZ_Timer";
_timeleft = _this select 0;
    while {_timeleft > 0} do {
    sleep 1;
        _timeleft = _timeleft - 1;
    };
};


// Function to check if units have been spooked
THD_DZ_Spooked = {
    private ["_unitA", "_unitB", "_unitgroup", "_unitside", "_enemygroups", "_enemy"];
    _unitA = _this select 0;
    _unitB = _this select 1;
    _unitgroup = group _unitA;
    _unitside = side _unitA;

    diag_log text format["Meeting Script: Called FNC_DZ_Spooked for %1", _unitA];

    // Check Faction of unit, and consider all groups that are enemy of him, then check and update all enemies around them
    switch (_unitside) do {
        case EAST: {
            _enemy = west;
        };
        case WEST: {
            _enemy = east;
        };
        case resistance: {
            private ["_isenemy"];
            _isenemy = _unitside getfriend east;
            if (_isenemy < 0.6) then {
                _enemy = east;
            };
            _isenemy = _unitside getfriend west;
            if (_isenemy < 0.6) then {
                _enemy = west;
            };
            if (isNil {_isenemy}) then
            {
                hint "Error: Unit has no enemies";
            }
        };
    };

    // update area and check for units
    while {(_unitA getVariable "MeetingScript_status") != 3} do {
        _enemygroups = nearestObjects [getpos _unitA, ["Man","Tank", "Air", "Car"], 500];
        {
            if (side _x == _enemy) then {
                if (_unitgroup knowsabout _x > 0.1) then {
                    _unitA setVariable ["MeetingScript_status", 3];
                    _unitB setVariable ["MeetingScript_status", 3];
                    _unitgroup setbehaviour "DANGER";
                };
            };
        } forEach _enemygroups;
        sleep 1;
    };
};


THD_DZ_PlayAnimation =
{
    private ["_unit", "_anim"];
    _unit = _this select 0;
    _anim = _this select 1;
    diag_log text format["MeetingScript: Spawned THD_DZ_PlayAnimation for unit [%1] with status [%2]",
    _unit, (_unit getVariable "MeetingScript_status")];
    while{(_unit getVariable "MeetingScript_status") == 1} do
    {
        diag_log text format["MeetingScript.THD_DZ_PlayAnimation: Attempting to play animation [%1] for unit [%2]", _anim, _unit];
        _unit playMove _anim;
        waitUntil {animationState _unit != _anim};
        diag_log text format["MeetingScript.THD_DZ_PlayAnimation: animation [%1] ended for unit [%2]", _anim, _unit];
        sleep 0.125;
    };
};




// PROCEDURE
private ["_unitA", "_unitB", "_exposA", "_exposB", "_animA", "_animB", "_nearmeethandleA", "_nearmeethandleB", "_Avehiclehandle", "_Bvehiclehandle", "_Aspookhandle",
"_Bspookhandle", "_Animhandle", "_Bnimhandle", "_timerhandle"];
_unitA = _obj1properties select 0;
_unitB = _obj2properties select 0;
_exposA = _unitA getVariable "MeetingScript_exit";
_exposB = _unitB getVariable "MeetingScript_exit";
_animA = _obj1properties select 2;
_animB = _obj2properties select 2;

// delay execution
sleep _meet_start_time;

// wait until the check for unit vehicle is completed
_Avehiclehandle = [_unitA] spawn THD_DZ_VehicleStatus;
waitUntil {(scriptDone _Avehiclehandle)};
_Bvehiclehandle = [_obj2properties select 0] spawn THD_DZ_VehicleStatus;
waitUntil {(scriptDone _Bvehiclehandle)};

{
    _x DoMove _meet_pos;
    (group _x) setSpeedMode "LIMITED";
    (group _x) setBehaviour "SAFE"
} foreach _units;

// spawning function for units
_nearmeethandleA = [_unitA, _meet_pos] spawn THD_DZ_Near;
_nearmeethandleB = [_unitB, _meet_pos] spawn THD_DZ_Near;

// adding spooked function to units
_Aspookhandle = [_unitA, _unitB] spawn THD_DZ_Spooked;
_Bspookhandle = [_unitB, _unitA] spawn THD_DZ_Spooked;

// Waituntil unit is out of default state
waitUntil {((_unitA getVariable "MeetingScript_status") != 0 and (_unitB getVariable "MeetingScript_status") != 0) or !alive _unitA or !alive _unitB};

// main loop

// if Both units are at the meeting position and are both ready
if ((_unitA getVariable "MeetingScript_status") == 1 && (_unitB getVariable "MeetingScript_status") == 1)  then {
    _unitA dowatch _unitB;
    _unitB dowatch _unitA;
    sleep 2;
    //{_x disableai "MOVE"} foreach _unitarray;

    // play animations
    _Animhandle = [_unitA, _animA] spawn THD_DZ_PlayAnimation;
    _Bnimhandle = [_unitB, _animB] spawn THD_DZ_PlayAnimation;
    _timerhandle = [_meet_length_time] spawn THD_DZ_Timer;

    // stop playing animation when the timer runs out, the unit is not alive, or unit is no longer ready for meeting
    waitUntil {
        scriptDone _timerhandle
        or (_unitA getVariable "MeetingScript_status") != 1
        or (_unitB getVariable "MeetingScript_status") != 1
        or !alive _unitA
        or !alive _unitB
    };
    terminate _Animhandle;
    terminate _Bnimhandle;
    {
        //_x playMoveNow "AmovPercMstpSlowWrflDnon";
        _x switchMove ""
    } foreach _units;

    // if the timer script finished successfully, that means no threat was detected during the meeting, proceed to status 2 and exit casually
    if (scriptDone _timerhandle) then {
        //{_x enableAI "MOVE"} forEach _unitarray;
        _unitA setVariable ["MeetingScript_status", 2];
        _unitB setVariable ["MeetingScript_status", 2];
    }
    // if the timer was not successfully completed, then the meeting was interrupted. proceed to status 3 and exit cautiously
    else {
        terminate _timerhandle;
        //{_x enableAI "MOVE"} forEach _unitarray;
        _unitA setVariable ["MeetingScript_status", 3];
        _unitB setVariable ["MeetingScript_status", 3];
    };
};

// if the Units have finished their meeting
if ((_unitA getVariable "MeetingScript_status") == 2 && (_unitB getVariable "MeetingScript_status") == 2) then {
    {
        _x setSpeedMode "LIMITED";
        _x setBehaviour "SAFE"
    } foreach _units;
};

// if one or both units are scared off
if ((_unitA getVariable "MeetingScript_status") == 3 or (_unitB getVariable "MeetingScript_status") == 3 or !alive _unitA or !alive _unitB) then {
    // terminate all unneccessary scripts
    terminate _Aspookhandle;
    terminate _Bspookhandle;
    terminate _nearmeethandleA;
    terminate _nearmeethandleB;
    {_x setSpeedMode "FULL"; _x setVariable ["MeetingScript_status", 3];} foreach _units;
};

_Avehiclehandle = [_unitA] spawn THD_DZ_VehicleStatus;
_Bvehiclehandle = [_unitB] spawn THD_DZ_VehicleStatus;
waitUntil {(scriptDone _Avehiclehandle) && (scriptDone _Bvehiclehandle)};
(units (_unitA getVariable "MeetingScript_group")) DoMove _exposA;
(units (_unitB getVariable "MeetingScript_group")) DoMove _exposB;

terminate _Aspookhandle;
terminate _Bspookhandle;


