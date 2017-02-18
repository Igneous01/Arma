// validates functor, if failed, Error and RPT log

params ["_functor", "_fncName"];
if (
	(isNil {_functor}) ||
	( (typename _functor != typename objNull) && (typename _functor != typename locationNull) ) ||
	(isNull _functor) ||
	(isNil {_functor getVariable "IGN_FUNCTOR_TYPE"})
	)
then
{
	[_functor, "Functor", _fncName] call IGN_fnc_errorAndLogRPT;
};