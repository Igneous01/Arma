/*
* Efnc_advHints
* creates advanced hints that display to the player
*  [header, info, action, duration] call Efnc_advHints;
* header: String - The main header for the hint
* info: String - Secondary header
* action: String - Description of action/etc
* duration: Number - Time in seconds that hint will last for
* returns: nothing
* Example: ["Mission Available", "Attend Briefing", "Go to the briefing room", 5] spawn EF_fnc_AdvancedHints;
*/

private ["_header", "_info", "_action", "_duration"];
_header = _this select 0;
_info = _this select 1;
_action = _this select 2;
_duration = _this select 3;
[] call bis_fnc_hints;
BIS_AdvHints_THeader = _header;
BIS_AdvHints_TInfo = _info;
BIS_AdvHints_TAction = _action;
BIS_AdvHints_TBinds = "";
BIS_AdvHints_Duration = _duration;
BIS_AdvHints_HideCode = "hintSilent '';";
BIS_AdvHints_Text = call BIS_AdvHints_formatText;
BIS_AdvHints_HideCond = "";
call BIS_AdvHints_showHint;
