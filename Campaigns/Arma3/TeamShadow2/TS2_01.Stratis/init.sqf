
// Globals
CURRENT_PHASE = objNull;	// controlled in triggers
TIME_TEST_START = -1;
TIME_TEST_END = -1;
TIME_TEST = 0;				// global that controls whether player has passed mission or not

// CONSTANTS
BONUS_HIT = 5;
BONUS_ACCURACY = 10;
PENALTY_SKIPPED_TARGET = 15;
PENALTY_MISSED_SHOT = 10;
PENALTY_WRONG_WEAPON = 5;

call compile preprocessfilelinenumbers "scripts\functions.sqf";
call compile preprocessfilelinenumbers "scripts\phase.sqf";
//timeString = [myTime, "MM:SS"] call BIS_fnc_secondsToString;

// bis defined global variable - controls whether targets should popup again after being hit
nopop=true;


IGN_fnc_startTest =
{
	// teleport player
	// draw hud
	// display start hint
	hintC "Start!";
	TIME_TEST_START = time;	// set start time
	(group player) setCurrentWaypoint [(group player), 1];	// set the player waypoint back to the beginning
	player addEventHandler ["Fired",
	{
		params ["_unit", "_weapon"];
		if (_unit isEqualTo player) then
		{
			if (! (isNull CURRENT_PHASE)) then
			{
				CURRENT_PHASE setVariable ["TS2_shotsFired", (CURRENT_PHASE getVariable "TS2_shotsFired") + 1];
				private _weapon = ((currentWeapon player) call BIS_fnc_itemtype) select 1;
				// in order to get accuracy bonus, the correct weapon must be selected
				if ( ! (_weapon isEqualTo (_l getVariable "TS2_weapon")) ) then
				{
					CURRENT_PHASE setVariable ["TS2_penaltyWrongWeapon", (CURRENT_PHASE getVariable "TS2_penaltyWrongWeapon") + 1];
				};
			}
			else
			{
				// add them to player? track them and penalize?
			};
		};

	}];
};

IGN_fnc_endTest =
{
	hintC "Test Completed!";
	TIME_TEST_END = time;
	TIME_TEST = (TIME_TEST_END - TIME_TEST_START) + ([] call IGN_fnc_getAllPhaseScores);
	diag_log text format ["TEST DONE - BASE TIME (%1) TIME (%2)", (TIME_TEST_END - TIME_TEST_START), TIME_TEST];
	{
		private _report = _x call IGN_fnc_getPhaseScoreReport;
		{ diag_log text _x; } forEach _report;	// print the report
	} forEach [logic_phase1, logic_phase2, logic_phase3, logic_phase4, logic_phase5, logic_phase6, logic_phase7, logic_phase8, logic_phase9, logic_phase10]
};