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


hint "300 metres";

//Loop for range 1
while {passtest == 1} do
{
if ((_unit getVariable "Hit") == 1 && (_unit getVariable "Rnd") == 1) exitWith {Test2Hits = 1};
if ((_unit getVariable "Hit") == 0 && (_unit getVariable "Rnd") == 1) exitWith {passtest = 0;};
sleep 0.125;
};

//IF successful, moving target to next location
if (passtest == 1 && Test2Hits == 1) then {
_target setpos getmarkerpos "t2p2";
t2help setpos getmarkerpos "t2p2";
_unit setVariable ["Rnd", 0];
_unit setVariable ["Hit", 0];
hint "400 metres";
};

//Loop for range 2
while {passtest == 1} do
{
if ((_unit getVariable "Hit") == 1 && (_unit getVariable "Rnd") == 1) exitWith {Test2Hits = 2};
if ((_unit getVariable "Hit") == 0 && (_unit getVariable "Rnd") == 1) exitWith {passtest = 0;};
sleep 0.125;
};

//If successful, moving target to next location
if (passtest == 1 && Test2Hits == 2) then {
_target setpos getmarkerpos "t2p3";
t2help setpos getmarkerpos "t2p3";
_unit setVariable ["Rnd", 0];
_unit setVariable ["Hit", 0];
hint "500 metres";
};

//Loop for range 3
while {passtest == 1} do
{
if ((_unit getVariable "Hit") == 1 && (_unit getVariable "Rnd") == 1) exitWith {Test2Hits = 3};
if ((_unit getVariable "Hit") == 0 && (_unit getVariable "Rnd") == 1) exitWith {passtest = 0;};
sleep 0.125;
};

//If successful, moving target to next location
if (passtest == 1 && Test2Hits == 3) then {
_target setpos getmarkerpos "t2p4";
t2help setpos getmarkerpos "t2p4";
_unit setVariable ["Rnd", 0];
_unit setVariable ["Hit", 0];
hint "600 metres";
};

//Loop for range 4
while {passtest == 1} do
{
if ((_unit getVariable "Hit") == 1 && (_unit getVariable "Rnd") == 1) exitWith {Test2Hits = 4};
if ((_unit getVariable "Hit") == 0 && (_unit getVariable "Rnd") == 1) exitWith {passtest = 0;};
sleep 0.125;
};

//If successful, moving target to next location
if (passtest == 1 && Test2Hits == 4) then {
_target setpos getmarkerpos "t2p5";
t2help setpos getmarkerpos "t2p5";
_unit setVariable ["Rnd", 0];
_unit setVariable ["Hit", 0];
hint "700 metres";
};

//Loop for range 5
while {passtest == 1} do
{
if ((_unit getVariable "Hit") == 1 && (_unit getVariable "Rnd") == 1) exitWith {Test2Hits = 5};
if ((_unit getVariable "Hit") == 0 && (_unit getVariable "Rnd") == 1) exitWith {passtest = 0;};
sleep 0.125;
};

//If successful, moving target to next location
if (passtest == 1 && Test2Hits == 5) then {
_target setpos getmarkerpos "t2p6";
t2help setpos getmarkerpos "t2p6";
_unit setVariable ["Rnd", 0];
_unit setVariable ["Hit", 0];
hint "800 metres";
};

//Loop for range 6
while {passtest == 1} do
{
if ((_unit getVariable "Hit") == 1 && (_unit getVariable "Rnd") == 1) exitWith {Test2Hits = 6};
if ((_unit getVariable "Hit") == 0 && (_unit getVariable "Rnd") == 1) exitWith {passtest = 0;};
sleep 0.125;
};

//If successful, moving target to next location
if (passtest == 1 && Test2Hits == 6) then {
_target setpos getmarkerpos "t2p7";
t2help setpos getmarkerpos "t2p7";
_unit setVariable ["Rnd", 0];
_unit setVariable ["Hit", 0];
hint "900 metres";
};

//Loop for range 7
while {passtest == 1} do
{
hint "900 metres";
if ((_unit getVariable "Hit") == 1 && (_unit getVariable "Rnd") == 1) exitWith {Test2Hits = 7};
if ((_unit getVariable "Hit") == 0 && (_unit getVariable "Rnd") == 1) exitWith {passtest = 0;};
sleep 0.125;
};

//If Perfect Score
if (passtest == 1 && Test2Hits == 7) then {
_unit setVariable ["Rnd", 0];
_unit setVariable ["Hit", 0];
hint "Perfect Score";
};

//If Failure
if (passtest == 0) then {
hint "Missed Shot"; 
};

_unit removeeventhandler ["fired", EHFireCheck];
_target removeeventhandler ["hit", EHFireHit];

deletevehicle _target;
deletevehicle t2help;



