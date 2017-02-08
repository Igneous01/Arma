/*
	Create_Effect

	Creates a particle effect, like smoke or fire on an object. Currently third parameter is not supported

	params:
	_obj - object to create effect on
	_type - string ("smoke" or "fire")
	_intensity - string ("low", "medium", "high")	- default is high

	[myCar, "fire", "medium"] call Create_Effect

	Igneous_01
	October 10,2013
*/

private ["_obj", "_type", "_intensity", "_effect"];
_obj = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_type = [_this, 1, "smoke", [""]] call BIS_fnc_param;
_intensity = [_this, 2, "high", [""]] call BIS_fnc_param;

if (_type == "smoke") then
{
	_effect = "test_EmptyObjectForSmoke";
	/*
		unimplemented
		if (_intensity == "low") exitWith {false};
		if (_intensity == "medium") exitWith {false};
		if (_intensity == "high") then {_effect = "test_EmptyObjectForSmoke";};
	*/
}
else
{
	if (_type == "fire") then
	{
		_effect = "test_EmptyObjectForFireBig";
		/*
			unimplemented
			if (_intensity == "low") exitWith {false};
			if (_intensity == "medium") exitWith {false};
			if (_intensity == "high") then {_effect = "test_EmptyObjectForFireBig";};
		*/

	}
};

_thing = _effect createVehicle getpos _obj;
_thing attachTo [_obj,[0,0,0.1]];

_thing;