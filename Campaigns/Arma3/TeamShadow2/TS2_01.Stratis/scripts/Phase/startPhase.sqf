private _logic = _this;
if ( (_logic getVariable "TS2_time") > 0) exitWith {};
//hintC "Starting Phase";
_logic setVariable ["TS2_time", time];	// start tracking time
{
	private _h = _x addEventHandler ["HitPart", TS2_hdl_hitPartHandler];
	private _h2 = _x addEventHandler ["HitPart", TS2_hdl_targetHitPartHandler];
	_x setVariable ["TS2_hitPartHandler", _h];	// check to see this will work (not sure if forEach will allow this)
} forEach (_logic getVariable "TS2_targets");

if (_logic == logic_phase1 || _logic == logic_phase2 || _logic == logic_phase5 || _logic == logic_phase10) then
{
	{_x animate ["terc", 0];} forEach (_logic getVariable "TS2_targets");
};

if (_logic == logic_phase9) then
{
	_logic spawn
	{
		{
			sleep (random 3);
			_x animate ["terc", 0];
		} forEach (_this getVariable "TS2_targets");
	};
};

CURRENT_PHASE = _logic;
