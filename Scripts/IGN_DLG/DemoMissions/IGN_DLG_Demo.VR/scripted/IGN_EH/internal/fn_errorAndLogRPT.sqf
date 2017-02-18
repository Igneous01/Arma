// validates object, if failed, Error and RPT log

	private ["_obj", "_displayType", "_fncName"];
	_obj = _this select 0;
	_displayType = _this select 1;	// string
	_fncName = _this select 2;

	["%1 : Invalid %2 object - (%3) is not a valid %2", _fncName, _displayType, _obj] call BIS_fnc_error;
	diag_log text format ["%1 : Invalid %2 object - (%3) is not a valid %2", _fncName, _displayType, _obj];
