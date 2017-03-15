#define TEXTLINE1 1100
#define TEXTLINE2 1101
#define TEXTLINE3 1102
#define TEXTLINE4 1103

params ["_handlerID", "_startTime", "_rscGold", "_rscSilver", "_rscBronze", "_rscNone", "_rscPenalty", "_rscBonus", "_rscTarget"];
private _t = time - _startTime;
private _timeString = [_t, "MM:SS.MS"] call BIS_fnc_secondsToString;
private _timeText = "";
private _penaltyText = "";
private _bonusText = "";
private _targetText = "";
if (_t > (TIME_GOLD select 0) && _t < (TIME_GOLD select 1)) then
{
	_timeText = "<t color='" + (_rscGold select 0)  + "'><img image='" + (_rscGold select 1) + "' /> " + _timeString + "</t>";
}
else
{
	if (_t >= (TIME_SILVER select 0) && _t <= (TIME_SILVER select 1)) then
	{
		_timeText = "<t color='" + (_rscSilver select 0)  + "'><img image='" + (_rscSilver select 1) + "' /> " + _timeString + "</t>";
	}
	else
	{
		if (_t > (TIME_BRONZE select 0) && _t < (TIME_BRONZE select 1)) then
		{
			_timeText = "<t color='" + (_rscBronze select 0)  + "'><img image='" + (_rscBronze select 1) + "' /> " + _timeString + "</t>";
		}
		else
		{
			_timeText = "<t color='" + (_rscNone select 0)  + "'><img image='" + (_rscNone select 1) + "' /> " + _timeString + "</t>";
		};
	};
};

private _penaltyString = [TEST_PENALTIES, "MM:SS.MS"] call BIS_fnc_secondsToString;
_penaltyText = "<t color='" + (_rscPenalty select 0)  + "'><img image='" + (_rscPenalty select 1) + "' /> +" + _penaltyString + "</t>";

private _bonusString = [TEST_BONUSES, "MM:SS.MS"] call BIS_fnc_secondsToString;
_bonusText = "<t color='" + (_rscBonus select 0)  + "'><img image='" + (_rscBonus select 1) + "' /> -" + _bonusString + "</t>";

if (! (isNull CURRENT_PHASE)) then
{
	private _targetsString = (CURRENT_PHASE getVariable "TS2_targetsCount") - (CURRENT_PHASE getVariable "TS2_hits");
	_targetText = "<t color='" + (_rscTarget select 0) + "'>Targets <img image='" + (_rscTarget select 1) + "' /> " + (str _targetsString) + "</t>";
};


if (TIME_TEST_END != -1) then
{
	[_handlerID, "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
};

((uiNamespace getVariable "HUDTIMETRIAL") displayCtrl TEXTLINE1) ctrlSetStructuredText (parseText _timeText);
((uiNamespace getVariable "HUDTIMETRIAL") displayCtrl TEXTLINE2) ctrlSetStructuredText (parseText _bonusText);
((uiNamespace getVariable "HUDTIMETRIAL") displayCtrl TEXTLINE3) ctrlSetStructuredText (parseText _penaltyText);
((uiNamespace getVariable "HUDTIMETRIAL") displayCtrl TEXTLINE4) ctrlSetStructuredText (parseText _targetText);