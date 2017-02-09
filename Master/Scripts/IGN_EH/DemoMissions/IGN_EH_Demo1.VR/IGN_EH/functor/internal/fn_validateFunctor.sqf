// validates functor, if failed, Error and RPT log

	private ["_functor", "_fncName"];
	_functor = _this select 0;
	_fncName = _this select 1;
	if (!(_functor call IGN_fnc_isFunctor)) then
	{
		[_functor, "Functor", _fncName] call IGN_fnc_errorAndLogRPT;
	};
