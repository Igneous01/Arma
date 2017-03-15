if (isNull CURRENT_PHASE) exitWith {};
//hintC "Ending Phase";
private _logic = _this;
private _timeElapsed = time - (_logic getVariable "TS2_time");
_logic setVariable ["TS2_time", _timeElapsed];	// set the time the phase was completed in

// remove handlers from targets, and set them down (if not already set)
{
	if ((_x getVariable "TS2_hitPartHandler") != -1) then
	{
		_x removeEventHandler ["HitPart", (_x getVariable "TS2_hitPartHandler")];
	};
	_x animate ["terc", 1];
} forEach (_logic getVariable "TS2_targets");

_logic call TS2_fnc_calculateScore;

if (_logic == logic_phase10) then
{
	[] spawn TS2_async_endTest;
};

CURRENT_PHASE = objNull;
