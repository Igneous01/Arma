// validates event, if failed, Error and RPT log

private ["_event", "_fncName"];
_event = _this select 0;
_fncName = _this select 1;
if (!(_event call IGN_fnc_isEvent)) then
{
	[_event, "Event", _fncName] call IGN_fnc_errorAndLogRPT;
};