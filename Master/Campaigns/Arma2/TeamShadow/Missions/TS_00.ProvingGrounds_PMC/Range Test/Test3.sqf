// range = [unit, target] execVM "Test2.sqf"

private ["_unit", "_target"];
_unit = _this select 0;
_target = _this select 1;
_unit setVariable ["Rnd", 0];
_unit setVariable ["Hit", 0];

// Function Fire Check
fnc_EH_Fire_Check = {
private ["_unit", "_bullet"];
_unit = _this select 0;
_bullet = _this select 6;
waitUntil {!alive _bullet};
_unit setVariable ["Rnd", 1];
};



// Function Fire Hit
fnc_EH_Fire_Hit = {
private ["_target", "_dealer"];
_target = _this select 0;
_dealer = _this select 1;
_dealer setVariable ["Hit", 1];
};



EHFireCheck = _unit addEventHandler ["fired", {_this spawn fnc_EH_Fire_Check}];

EHFireHit = _target addEventHandler ["hit", {_this call fnc_EH_Fire_Hit}];


//Loop Target Location 1
while {alive _unit} do
{
if ((_unit getVariable "Hit") == 1 && (_unit getVariable "Rnd") == 1) exitWith {Test3Hits = Test3Hits + 1};
if ((_unit getVariable "Hit") == 0 && (_unit getVariable "Rnd") == 1) exitWith {};
sleep 0.125;
};

hint "Second Target";
sleep 2;

_target setpos [getmarkerpos "t3p2" select 0, getmarkerpos "t3p2" select 1, + 3.6];
t3o2 setpos getmarkerpos "t3p2";
t3help setpos getmarkerpos "t3p2";
_unit setVariable ["Rnd", 0];
_unit setVariable ["Hit", 0];


//Loop for Target Location 2
while {alive _unit} do
{
if ((_unit getVariable "Hit") == 1 && (_unit getVariable "Rnd") == 1) exitWith {Test3Hits = Test3Hits + 1};
if ((_unit getVariable "Hit") == 0 && (_unit getVariable "Rnd") == 1) exitWith {};
sleep 0.125;
};
hint "Last Target";
sleep 2;
_target setpos [getmarkerpos "t3p3" select 0, getmarkerpos "t3p3" select 1, + 0.5];
t3o3 setpos [getmarkerpos "t3ob3" select 0, getmarkerpos "t3ob3" select 1, -0.3];
t3help setpos getmarkerpos "t3p3";
_unit setVariable ["Rnd", 0];
_unit setVariable ["Hit", 0];


//Loop for Target Location 3
while {alive _unit} do
{
if ((_unit getVariable "Hit") == 1 && (_unit getVariable "Rnd") == 1) exitWith {Test3Hits = Test3Hits + 1};
if ((_unit getVariable "Hit") == 0 && (_unit getVariable "Rnd") == 1) exitWith {};
sleep 0.125;
};


_unit setVariable ["Rnd", 0];
_unit setVariable ["Hit", 0];

_unit removeeventhandler ["fired", EHFireCheck];
_target removeeventhandler ["hit", EHFireHit];


deletevehicle _target;
deletevehicle t3help;
deletevehicle t3o1;
deletevehicle t3o2;
deletevehicle t3o3;
