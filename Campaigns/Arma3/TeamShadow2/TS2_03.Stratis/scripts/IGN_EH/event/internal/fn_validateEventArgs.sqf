// validate event arguments and arguments passed, if fail, Error and RPT log
params ["_event", "_argsSupplied", "_fncName"];
if (typename _argsSupplied != typename []) then {_argsSupplied = [_argsSupplied];};
private _argsRequired = _event getVariable "arg_types";
if (typename _argsRequired != typename []) then {_argsRequired = [_argsRequired];};

// do not validate if event has [] as arg types
if (count _argsRequired == 0) exitWith {};

//diag_log text format ["IGN_fnc_validateEventArgs : _argsSupplied - %1 , _argsRequired - %2", _argsSupplied, _argsRequired];

if (count _argsSupplied != count _argsRequired) exitWith
{
	["%1 : Invalid arguments passed - expected %2 - got %3", _fncName, _argsRequired, _argsSupplied] call BIS_fnc_error;
	diag_log text format ["%1 : Invalid arguments passed - expected %2 - got %3", _fncName, _argsRequired, _argsSupplied];
};

for [{_i = 0}, {_i < count _argsSupplied}, {_i = _i + 1}] do
{
	if (typename (_argsSupplied select _i) != typename (_argsRequired select _i)) then
	{
		["%1 - Invalid argument passed - expected %2 - got %3", _fncName, typename (_argsRequired select _i), typename (_argsSupplied select _i)] call BIS_fnc_error;
		diag_log text format ["%1 - Invalid argument passed - expected %2 - got %3", _fncName, typename (_argsRequired select _i), typename (_argsSupplied select _i)];
	};
};