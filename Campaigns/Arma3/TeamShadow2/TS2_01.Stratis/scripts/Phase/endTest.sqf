#define TEXTLINE1 1100
#define TEXTLINE2 1101
#define TEXTLINE3 1102
#define TEXTLINE4 1103

if (TIME_TEST_END != -1) exitWith {};	// here in case trigger invokes end test even though it already may have ended

TIME_TEST_END = time;
TIME_TEST = (TIME_TEST_END - TIME_TEST_START) + ([] call TS2_fnc_getAllPhaseScores);
diag_log text format ["ALL PHASE SCORES: %1 GLOBAL VAR SCORES: %2", ([] call TS2_fnc_getAllPhaseScores), (TEST_PENALTIES - TEST_BONUSES)];
diag_log text format ["TEST DONE - BASE TIME (%1) TIME (%2)",
 [(TIME_TEST_END - TIME_TEST_START), "MM:SS.MS"] call BIS_fnc_secondsToString, [TIME_TEST, "MM:SS.MS"] call BIS_fnc_secondsToString];
{
	private _report = _x call TS2_fnc_getPhaseScoreReport;
	{ diag_log text _x; } forEach _report;	// print the report
} forEach
[logic_phase1, logic_phase2, logic_phase3,
logic_phase4, logic_phase5, logic_phase6,
logic_phase7, logic_phase8, logic_phase9,
logic_phase10];

// delay a few seconds, then update HUD
sleep 3;

private _rscTime =
		[
			getText (missionConfigFile >> "TS2Config" >> "Resource" >> "Bonus" >> "color"),
			getText (missionConfigFile >> "TS2Config" >> "Resource" >> "Bonus" >> "image")
		];

private _rscGold =
		[
			getText (missionConfigFile >> "TS2Config" >> "Resource" >> "GoldMedal" >> "color"),
			getText (missionConfigFile >> "TS2Config" >> "Resource" >> "GoldMedal" >> "image")
		];

private _rscSilver =
		[
			getText (missionConfigFile >> "TS2Config" >> "Resource" >> "SilverMedal" >> "color"),
			getText (missionConfigFile >> "TS2Config" >> "Resource" >> "SilverMedal" >> "image")
		];

private _rscBronze =
		[
			getText (missionConfigFile >> "TS2Config" >> "Resource" >> "BronzeMedal" >> "color"),
			getText (missionConfigFile >> "TS2Config" >> "Resource" >> "BronzeMedal" >> "image")
		];

private _rscNone =
		[
			getText (missionConfigFile >> "TS2Config" >> "Resource" >> "NoneMedal" >> "color"),
			getText (missionConfigFile >> "TS2Config" >> "Resource" >> "NoneMedal" >> "image")
		];

private _baseTimeText = "<t color='" + (_rscTime select 0)  + "'><img image='" + (_rscTime select 1) + "' /> Base: " + ([(TIME_TEST_END - TIME_TEST_START), "MM:SS.MS"] call BIS_fnc_secondsToString) + "</t>";

private _actualTimeText = "";
if (TIME_TEST < (TIME_GOLD select 1)) then
{
	_actualTimeText = "<t color='" + (_rscGold select 0)  + "'><img image='" + (_rscGold select 1) + "' /> Actual: " + ([TIME_TEST, "MM:SS.MS"] call BIS_fnc_secondsToString) + "</t>";
}
else
{
	if (TIME_TEST < (TIME_SILVER select 1)) then
	{
		_actualTimeText = "<t color='" + (_rscSilver select 0)  + "'><img image='" + (_rscSilver select 1) + "' /> Actual: " + ([TIME_TEST, "MM:SS.MS"] call BIS_fnc_secondsToString) + "</t>";
	}
	else
	{
		if (TIME_TEST < (TIME_BRONZE select 1)) then
		{
			_actualTimeText = "<t color='" + (_rscBronze select 0)  + "'><img image='" + (_rscBronze select 1) + "' /> Actual: " + ([TIME_TEST, "MM:SS.MS"] call BIS_fnc_secondsToString) + "</t>";
		}
		else
		{
			_actualTimeText = "<t color='" + (_rscNone select 0)  + "'><img image='" + (_rscNone select 1) + "' /> Actual: " + ([TIME_TEST, "MM:SS.MS"] call BIS_fnc_secondsToString) + "</t>";
		};
	};
};

((uiNamespace getVariable "HUDTIMETRIAL") displayCtrl TEXTLINE1) ctrlSetStructuredText (parseText "FINISH");
((uiNamespace getVariable "HUDTIMETRIAL") displayCtrl TEXTLINE2) ctrlSetStructuredText (parseText _baseTimeText);
((uiNamespace getVariable "HUDTIMETRIAL") displayCtrl TEXTLINE3) ctrlSetStructuredText (parseText _actualTimeText);
((uiNamespace getVariable "HUDTIMETRIAL") displayCtrl TEXTLINE4) ctrlSetStructuredText (parseText "");

sleep 5;

if (TIME_TEST < TIME_GOLD) then
{
	"SUCCEEDED" call TS2_fnc_setTaskState;
}
else
{
	"FAILED" call TS2_fnc_setTaskState;
};