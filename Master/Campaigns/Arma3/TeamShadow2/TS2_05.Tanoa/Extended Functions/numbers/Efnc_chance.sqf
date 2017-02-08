/*
* EF_fnc_chance
* return true/false, based on probability provided
* coinToss = probability call EF_fnc_chance
* probability: Number - the probability to be used (ie. 30% chance, 50% chance) - if probability is 100 or more, will always return true
* Returns: Boolean - true or false
* If invalid parameter is provided, defaults to 50%
*/

private ["_chance", "_res"];
_chance = [_this, 50, [0]] call EF_fnc_singleParam;
_res = false;
if ((random(100)) < _chance) then {_res = true;};
_res;

