/*
* Efnc_getDir
* Find the direction between two things
* This function is overloaded to support (markers, objects, positions)
* _direction = [marker1, marker2] call Fnc_GetDir
*/
private ["_obj1", "_obj2", "_x1", "_x2", "_y1", "_y2", "_dir", "_posCommand"];
_obj1 = _this select 0;
_obj2 = _this select 1;
_posCommand = "";
switch (typeName _obj1) do
{
	case "STRING":
	{
		_posCommand = "getMarkerPos";
	};
	case "OBJECT":
	{
		_posCommand = "getPos";
	};
	case "ARRAY":
	{
		_posCommand = "";
	};
	default
	{
		diag_log text "Efnc_getDir - unknown data type given";
	};
};
_x1 = call compile format ["%1 _obj1 select 0;", _posCommand];
_y1 = call compile format ["%1 _obj1 select 1;", _posCommand];

switch (typeName _obj2) do
{
	case "STRING":
	{
		_posCommand = "getMarkerPos";
	};
	case "OBJECT":
	{
		_posCommand = "getPos";
	};
	case "ARRAY":
	{
		_posCommand = "";
	};
	default
	{
		diag_log text "Efnc_getDir - unknown data type given";
	};
};
_x2 = call compile format ["%1 _obj2 select 0;", _posCommand];
_y2 = call compile format ["%1 _obj2 select 1;", _posCommand];

_dir = (_x2 - _x1) ATan2 (_y2 - _y1);
_dir
