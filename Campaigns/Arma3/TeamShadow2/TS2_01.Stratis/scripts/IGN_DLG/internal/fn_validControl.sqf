
	params ["_fncName", "_control"];
	if (!ctrlVisible _control) then
	{
		private _error = format ["%1: control (%2) does not exist", _fncName, _varName];
        diag_log text ("------------------IGN_DLG: " + _error);
        [_error] call BIS_fnc_error;
	};
