/*
* Efnc_randInRange
* returns a random number, constricted to the range specified
* numberFrom2To5 = [min, max, decimal] call Efnc_RndInRange
* min: number - minimum number
* max: number - maximum number
* decimal: boolean - true can return a decimal (double) or integer
* returns: number - the random number
*/

private ["_min", "_max", "_double", "_val"];
_min = _this select 0;
_max = _this select 1;
_double = _this select 2;
_val = (_min * 100) + ( (random 0.99) * (((_max * 100) - (_min * 100)) + 1) );	// formula for random with adjusted range
if (_double) then 
{
	_val = _val - (_val % 1);
};
_val = _val / 100;
_val
