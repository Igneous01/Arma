/*
	IGN_DLG_validBindingVariable
	Checks if variable exists
	If not, log error in rpt
*/

	params ["_varName", "_fncName"];
	if (
	    	isNil
	    	{
	    		missionNamespace getVariable (_varName call IGN_fnc_expandTokenName);
	    	}
	   ) then
	{
		private _error = format ["%1: binding variable (%2) does not exist", _fncName, _varName];
        diag_log text format ["IGN_DLG: %1", _error];
        [_error] call BIS_fnc_error;
	};

