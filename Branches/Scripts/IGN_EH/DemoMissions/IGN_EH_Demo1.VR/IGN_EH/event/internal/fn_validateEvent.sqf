// validates event, if failed, Error and RPT log

params ["_event", "_fncName"];
if (
	(isNil {_event}) ||
	(typename _event != typename locationNull) ||
	(isNull _event) ||
	(isNil {_event getVariable "IGN_EVENT_TYPE"})
	)
then
{
	[_event, "Event", _fncName] call IGN_fnc_errorAndLogRPT;
};