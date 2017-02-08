_man = _this select 0;
_id = _this select 2;
_sleepanim = "AidlPpneMstpSnonWnonDnon_SleepA_sleep2";
_wakeupanim = "AidlPpneMstpSnonWnonDnon_SleepC_standUp";
_wakeupanimprone = "AidlPpneMstpSrasWrflDnon01";
DZ_timer = 0;
DZ_actionpressed = 0;

_ActionID1 = player addAction ["Sleep 1 Hour","gen_action.sqf","DZ_timer = 1; DZ_actionpressed = 1"];
_ActionID2 = player addAction ["Sleep 2 Hour","gen_action.sqf","DZ_timer = 2; DZ_actionpressed = 1"];
_ActionID3 = player addAction ["Sleep 3 Hour","gen_action.sqf","DZ_timer = 3; DZ_actionpressed = 1"];
_ActionID4 = player addAction ["Sleep 4 Hour","gen_action.sqf","DZ_timer = 4; DZ_actionpressed = 1"];
_ActionID5 = player addAction ["Sleep 5 Hour","gen_action.sqf","DZ_timer = 5; DZ_actionpressed = 1"];
_ActionID6 = player addAction ["Sleep 6 Hour","gen_action.sqf","DZ_timer = 6; DZ_actionpressed = 1"];
_ActionID7 = player addAction ["Cancel","gen_action.sqf","DZ_actionpressed = 2"];
player removeaction _id;
// player setVariable ["SleepAction1",_ActionID1];
waitUntil {DZ_actionpressed != 0}; // waits until an action is used

// debug
hint format ["action state: %1", DZ_actionpressed];

if (DZ_actionpressed == 1) then {
    // main loop
    player playmove _sleepanim;
    sleep 8;
    titleText ["", "BLACK OUT", 5];
    sleep 5;
    skipTime DZ_timer;
    titleText ["", "WHITE IN", 5];
    sleep 1;
    player switchmove _wakeupanim;
    waitUntil {animationState player != _wakeupanim};
    player switchmove "";
} else {};


// remove all excessive actions
player removeaction _ActionID1;
player removeaction _ActionID2;
player removeaction _ActionID3;
player removeaction _ActionID4;
player removeaction _ActionID5;
player removeaction _ActionID6;
player removeaction _ActionID7;

player addaction ["Sleep", "Sleep.sqf"];

