// validates object, if failed, Error and RPT log
params ["_obj", "_displayType", "_fncName"];
["%1 : Invalid %2 object - (%3) is not a valid %2", _fncName, _displayType, _obj] call BIS_fnc_error;
diag_log text format ["%1 : Invalid %2 object - (%3) is not a valid %2", _fncName, _displayType, _obj];
