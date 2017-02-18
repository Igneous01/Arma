#ifndef __IGN_LIB_INTERNAL_HEADER__
#define __IGN_LIB_INTERNAL_HEADER__
/*
	Author: Igneous01
	Validation Functions Header
*/

// Checks if object is the specified type
IGN_fnc_is =
{
	private ["_obj", "_type"];
	_obj = _this select 0;
	_type = _this select 1;
	if (isNil {_obj}) exitWith {false};
	if (typename _obj != typename objNull) exitWith {false};
	if (isNull _obj) exitWith {false};
	if (isNil {_obj getVariable _type}) exitWith {false};
	true;
};

// validates object, if failed, Error and RPT log
IGN_fnc_errorAndLogRPT =
{
	private ["_obj", "_displayType", "_fncName"];
	_obj = _this select 0;
	_displayType = _this select 1;	// string
	_fncName = _this select 2;

	["%1 : Invalid %2 object - (%3) is not a valid %2", _fncName, _displayType, _obj] call BIS_fnc_error;
	diag_log text format ["%1 : Invalid %2 object - (%3) is not a valid %2", _fncName, _displayType, _obj];
};


#endif