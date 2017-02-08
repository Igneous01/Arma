//new meeting script

// Meeting Script v1.0 by DZ
// Simplifies the task of making a meeting and accounts for all possible outcomes of the meeting

// how to use:
// null = [unita, unitb, meetpos, "animA", "animB", ExitA, ExitB, StartTime, MeetingTime] execVM "meetscript.sqf"
// unitA/unitB - the units you are dealing with (make sure they are group leaders)
// meetpos - the name of a gamelogic (but can be any other object as well)
// animA/animB - The movename to play. ex "ActsPercMstpSnonWunaDnon_sceneNikitinDisloyalty_Nikitin" - make sure the quotes are inbetween the movename
// ExitA/ExitB - the names of gamelogics (or any object) for the units to leave/escape to
// StartTime - The amount of time to wait before the units will move to the meeting area
// Meetingtime - the amount of time the meeting will last

// To synchronize the meeting with waypoints:
// call the script within the act field of a waypoint. but change "null" to a more meaninful name ex. "meetinghandle"
// add another waypoint thats right beside the first one
// in the condition field put : ScriptDone meetinghandle
// add whatever other waypoints u want the unit to go to after the meeting has ended and they reached the final position.

// To make one unit go to meet another one, without the other unit moving:
// null = [unita, unitb, unita, "animA", "animB", ExitA, ExitB, StartTime, MeetingTime] execVM "meetscript.sqf"
// where meetpos becomes the name of the unit you want to wait.

private ["_unitA", "_unitB", "_meetpos", "_animA", "_animB", "_exposA", "_exposB", "_starttime", "_meettime", "_unitarray", "_nearmeethandleA", "_nearmeethandleB", "_Avehiclehandle", "_Bvehiclehandle", "_Aspookhandle", "_Bspookhandle", "_Animhandle", "_Bnimhandle", "_timerhandle"];
_unitA = _this select 0;
_unitB = _this select 1;
_meetpos = _this select 2;
_animA = _this select 3;
_animB = _this select 4;
_exposA = _this select 5;
_exposB = _this select 6;
_starttime = _this select 7;
_meettime = _this select 8;
_unitarray = [_unitA, _unitB];

{
	private["_veh_units", "_veh"];
	_veh = assignedVehicle _x;
	_x setVariable ["MeetingScript_status", 0];
	_x setVariable ["MeetingScript_invehicle", 0];
	_x setVariable ["MeetingScript_vehiclename", _veh];
	_x setVariable ["MeetingScript_group", group _x];

	if (_veh isKindOf "Helicopter" Or _veh isKindOf "LandVehicle") then
	{
		// if a gunner exists for the vehicle
	    if (isnull assignedGunner _veh) then {
	    	_veh_units = [assignedDriver _veh];
		} else {
	    	_veh_units = [assignedDriver _veh, assignedGunner _veh];
		};
		_x setVariable ["MeetingScript_vehicleunits", _veh_units];	// save driver and gunner as seperate list
		_x setVariable ["MeetingScript_getoutunits", (units (group _x)) - _veh_units];	// save driver and gunner as seperate list
	}
	else
	{
		_x setVariable ["MeetingScript_vehicleunits", nil];	// save driver and gunner as seperate list
		_x setVariable ["MeetingScript_getoutunits", nil];
	};
} foreach _unitarray;

// Possible values for status
// 0 - Default State, safe
// 1 - Unit is ready and is performing meeting, safe
// 2 - Units have finished their meeting and are going back, safe
// 3 - Unit is retreating due to enemy spotted, shots fired, wounded, etc, notsafe
// 4 - Unit has reached final destination, end script

// Delay script until startime
sleep _starttime;

// FUNCTIONS

// Near Position Function
if (isnil "FNC_DZ_Near") then {
    FNC_DZ_Near = {
        private ["_unit", "_pos", "_dist", "_group", "_getoutunits", "_vehicleunits", "_veh"];
        _unit = _this select 0;
        _pos = _this select 1;
        _group = _unit getVariable "MeetingScript_group";
        _getoutunits = _unit getVariable "MeetingScript_getoutunits";
        _vehicleunits = _unit getVariable "MeetingScript_vehicleunits";
        _veh = _unit getVariable "MeetingScript_vehiclename";

        diag_log text format["Meeting Script: Called FNC_DZ_Near for %1", _unit];

        // calculate distance to meeting position if in defualt state
        if ((_unit getVariable "MeetingScript_status") == 0) then {
            while {(_unit getVariable "MeetingScript_status") == 0} do {
                _dist = _unit distance _pos;

                // check if the unit is in a vehicle before determining what distance to check, if the unit has a driver and gunner assigned, these units will not leave the vehicle

                // if unit is in a helicopter
                if ((_unit getVariable "MeetingScript_invehicle") == 1 && vehicle _unit isKindOf "Helicopter" && _dist < 180) then {
                    _getoutunits orderGetIn false;
                    // land helicopter
                    _veh land "Land";
                    // stop the pilot from staying in formation

                    // wait until the pilot has landed, the pilot is dead, the group has detected enemy, or the unit is dead
                    waituntil {unitReady assignedDriver _veh or _unit getVariable "MeetingScript_status" == 3 or !alive _unit or !alive assignedDriver _veh};

                    // if the pilot is ready, proceed with unloading units
                    if (unitReady assignedDriver _veh) then {
                        sleep 10;
                        // wait until the unit is out of the chopper
                        waitUntil {vehicle _unit == _unit or !alive _unit or (_unit getVariable "MeetingScript_status") == 3 };
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

                    {_x forceSpeed 0;} foreach _vehicleunits;
                    _getoutunits orderGetIn false;

                    // stop driver from returning to formation with leader
                    //doStop _vehicleunits;

                    waitUntil {(vehicle _unit == _unit) or !alive _unit or (_unit getVariable "MeetingScript_status") == 3 };
                    _unit doMove (getpos _pos);	// order them to continue moving to position again

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
                // check the distance the units needs to be in in order to be ready for the meeting
                if (_dist < 6) then {
                    _unit setVariable ["MeetingScript_status", 1];
                };
                sleep 0.5;
            };
        };
    };
};

// Function to check if units were assigned a vehicle, and move them inside the vehicle if they are not in it
if (isnil "FNC_DZ_VehicleStatus") then {
    FNC_DZ_VehicleStatus = {
        private ["_unit", "_vehiclename", "_unitgrouplist", "_driver", "_gunner", "_unitcowards", "_unitdefenders", "_groupdefenders"];
        _unit = _this select 0;
        _vehiclename = _unit getVariable "MeetingScript_vehiclename";
        _unitgrouplist = units group _unit;

        diag_log text format["Meeting Script: Called FNC_DZ_VehicleStatus for %1", _unit];

        // if the unit has no vehicle
        if (isNull _vehiclename) then {
            _unit setVariable ["MeetingScript_invehicle", 0];
        }
        // if the unit has a vehicle
        else {
        	// have the vehicle units follow the leader again so they can receive commands
            //_unitgrouplist doFollow _unit;
            {_x forceSpeed -1;} foreach (_unit getVariable "MeetingScript_vehicleunits");
            _driver = assignedDriver _vehiclename;

            // check if gunner exists
            if (isnull (assignedGunner _vehiclename)) then {
                _gunner = nil;
                _unitcowards = [_unit, _driver];
            } else {
                _gunner = assignedGunner _vehiclename;
                _unitcowards = [_unit, _driver, _gunner];
            };

            // prepare to split groups if enemy detected
            _unitdefenders = _unitgrouplist - _unitcowards;

            // if the unit is in the vehicle
            if (_unit in (_unit getVariable "MeetingScript_vehiclename")) then {
                (group _unit) setSpeedMode "NORMAL";
                _unit setVariable ["MeetingScript_invehicle", 1];
            }
            // if not in vehicle check for further parameters
            else {
                // if unit has detected enemy or is under fire
                if ((_unit getVariable "MeetingScript_status") == 3 or !alive _unit) then {

                    // split group to make guards defend the units escape
                    _unitdefenders join grpnull;
                    {unassignVehicle _x} foreach _unitdefenders;
                    _groupdefenders = group (_unitdefenders select 0);
                    _unitdefenders join _groupdefenders;
                    [_unit] ordergetin true;

                    // wait until the unit is in the vehicle or is not alive or vehicle is immobile
                    waitUntil {(_unit in (_unit getVariable "MeetingScript_vehiclename")) or (!alive _unit) or (!alive _driver) or !(canMove (_unit getVariable "MeetingScript_vehiclename"))};

                    // if unit in vehicle
                    if ((_unit in (_unit getVariable "MeetingScript_vehiclename"))) then {
                        _unit setVariable ["MeetingScript_invehicle", 1];
                    }
                    // if unit not in vehicle
                    else {
                        _unit setVariable ["MeetingScript_invehicle", 0];
                        [_unit] ordergetin false;
                    };

                    // once in vehicle make the ai avoid combat and quickly escape
                    (group _unit) setSpeedMode "FULL";
                    (group _unit) setBehaviour "CARELESS";
                }
                // if the unit has not detected any enemies and is not in any danger
                else {
                    _unitgrouplist orderGetIn true;
                    // waituntil the unit is in the vehicle or is not alive or vehicle destroyed
                    waitUntil {(_unit in (_unit getVariable "MeetingScript_vehiclename")) or !alive _unit or !alive _driver};
                    if ((_unit in (_unit getVariable "MeetingScript_vehiclename"))) then {
                        _unit setVariable ["MeetingScript_invehicle", 1];
                        (group _unit) setSpeedMode "NORMAL";
                    } else {
                        _unit setVariable ["MeetingScript_invehicle", 0];
                        [_unit] ordergetin false;
                        (group _unit) setSpeedMode "FULL";
                    };
                };
            };
        };
    };
};

// Timer Function
if (isnil "FNC_DZ_Timer") then {
    FNC_DZ_Timer = {
    private ["_timeleft"];
    diag_log text "Meeting Script: Called FNC_DZ_Timer";
    _timeleft = _this select 0;
        while {_timeleft > 0} do {
        sleep 1;
            _timeleft = _timeleft - 1;
        };
    };
};

// Function to check if units have been spooked
if (isnil "FNC_DZ_Spooked") then {
    FNC_DZ_Spooked = {
        private ["_unit", "_unitA", "_unitB", "_unitgroup", "_unitside", "_enemygroups", "_enemy"];
        _unit = _this select 0;
        _unitA = _this select 1;
        _unitB = _this select 2;
        _unitgroup = group _unit;
        _unitside = side _unit;

        diag_log text format["Meeting Script: Called FNC_DZ_Spooked for %1", _unit];

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
                } else {
                    _enemy = nil;
                    hint "Error: Unit has no enemies";
                };
            };
        };

        // update area and check for units
        while {(_unit getVariable "MeetingScript_status") != 3} do {
            _enemygroups = nearestObjects [getpos _unit, ["Man","Tank", "Air", "Car"], 500];
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
};

// PROCEDURES

// Setting default values and moving units to position

// wait until the check for unit vehicle is completed
_Avehiclehandle = [_unitA] spawn FNC_DZ_VehicleStatus;
waitUntil {(scriptDone _Avehiclehandle)};
_Bvehiclehandle = [_unitB] spawn FNC_DZ_VehicleStatus;
waitUntil {(scriptDone _Bvehiclehandle)};

{_x DoMove (getpos _meetpos); _x setSpeedMode "LIMITED"; _x setBehaviour "SAFE"} foreach _unitarray;

// spawning function for units
_nearmeethandleA = [_unitA, _meetpos] spawn FNC_DZ_Near;
_nearmeethandleB = [_unitB, _meetpos] spawn FNC_DZ_Near;


// adding spooked function to units
_Aspookhandle = [_unitA, _unitA, _unitB] spawn FNC_DZ_Spooked;
_Bspookhandle = [_unitB, _unitA, _unitB] spawn FNC_DZ_Spooked;

// Waituntil unit is out of default state
waitUntil {((_unitA getVariable "MeetingScript_status") != 0 and (_unitB getVariable "MeetingScript_status") != 0) or !alive _unitA or !alive _unitB};

// main loop

// if Both units are at the meeting position and are both ready
if ((_unitA getVariable "MeetingScript_status") == 1 && (_unitB getVariable "MeetingScript_status") == 1)  then {
    _unitA dowatch _unitB;
    _unitB dowatch _unitA;
    sleep 1.5;
    //{_x disableai "MOVE"} foreach _unitarray;

    // play animations
    _Animhandle = [_unitA, _animA] execVM "script_meeting\animation.sqf";
    _Bnimhandle = [_unitB, _animB] execVM "script_meeting\animation.sqf";
    _timerhandle = [_meettime] spawn FNC_DZ_Timer;

    // stop playing animation when the timer runs out, the unit is not alive, or unit is no longer ready for meeting
    waitUntil {scriptDone _timerhandle or (_unitA getVariable "MeetingScript_status") != 1 or (_unitB getVariable "MeetingScript_status") != 1 or !alive _unitA or !alive _unitB};
    terminate _Animhandle;
    terminate _Bnimhandle;
    terminate _timerhandle;
    {_x playMoveNow "AmovPercMstpSlowWrflDnon"; _x switchMove ""} foreach _unitarray;

    // if the timer script finished successfully, that means no threat was detected during the meeting, proceed to status 2 and exit casually
    if (scriptDone _timerhandle) then {
        //{_x enableAI "MOVE"} forEach _unitarray;
        _unitA setVariable ["MeetingScript_status", 2];
        _unitB setVariable ["MeetingScript_status", 2];
    }
    // if the timer was not successfully completed, then the meeting was interrupted. proceed to status 3 and exit cautiously
    else {
        //{_x enableAI "MOVE"} forEach _unitarray;
        _unitA setVariable ["MeetingScript_status", 3];
        _unitB setVariable ["MeetingScript_status", 3];
    };
};

// if the Units have finished their meeting
if ((_unitA getVariable "MeetingScript_status") == 2 && (_unitB getVariable "MeetingScript_status") == 2) then {
    _unitA Move (getpos _exposA);
    _unitB Move (getpos _exposB);
    {_x setSpeedMode "LIMITED"; _x setBehaviour "SAFE"} foreach _unitarray;
    _Avehiclehandle = [_unitA] spawn FNC_DZ_VehicleStatus;
    _Bvehiclehandle = [_unitB] spawn FNC_DZ_VehicleStatus;
    // wait until the check for unit vehicle is completed
    waitUntil {(scriptDone _Avehiclehandle) && (scriptDone _Bvehiclehandle)};
};

// if one or both units are scared off
if ((_unitA getVariable "MeetingScript_status") == 3 or (_unitB getVariable "MeetingScript_status") == 3) then {
    // terminate all unneccessary scripts
    terminate _Aspookhandle;
    terminate _Bspookhandle;
    terminate _nearmeethandleA;
    terminate _nearmeethandleB;
    terminate _Animhandle;
    terminate _Bnimhandle;
    _unitA DoMove (getpos _exposA);
    _unitB DoMove (getpos _exposB);
    _Avehiclehandle = [_unitA] spawn FNC_DZ_VehicleStatus;
    _Bvehiclehandle = [_unitB] spawn FNC_DZ_VehicleStatus;
    {_x setSpeedMode "FULL"} foreach _unitarray;
    // wait until the check for unit vehicle is completed
    waitUntil {(scriptDone _Avehiclehandle) && (scriptDone _Bvehiclehandle)};
};

// create variables to check for unit(s) distance to final destination
private ["_distA", "_distB"];
_distA = _unitA distance _exposA;
_distB = _unitB distance _exposB;

// continue looping until a unit has reached final destination, or is no longer alive
while {((_unitA getVariable "MeetingScript_status") != 4) && ((_unitB getVariable "MeetingScript_status") != 4)} do {
    _distA = _unitA distance _exposA;
    _distB = _unitB distance _exposB;
    if ((_distA < 100)  or (!alive _unitA)) then {
        _unitA setVariable ["MeetingScript_status", 4];
    };
    if ((_distB < 100) or (!alive _unitB)) then {
        _unitB setVariable ["MeetingScript_status", 4];
    };
    sleep 3;
};

terminate _Avehiclehandle;
terminate _Bvehiclehandle;
terminate _Aspookhandle;
terminate _Bspookhandle