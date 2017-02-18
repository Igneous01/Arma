
params ["_event", "_displayID"];
// delete all event handlers that belong to this display
{
	if ( (_x select 0) == _displayID ) then
	{
        [_event, _forEachIndex] call IGN_fnc_deleteEventHandler;
	};
} foreach (_event getVariable "handlers");
