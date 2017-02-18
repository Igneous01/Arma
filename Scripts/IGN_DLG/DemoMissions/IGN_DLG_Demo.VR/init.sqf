"scripted\IGN_EH" call compile preprocessfilelinenumbers "scripted\IGN_EH\IGN_EH_INIT.sqf";
"scripted\IGN_DLG" call compile preprocessfilelinenumbers "scripted\IGN_DLG\IGN_DLG_INIT.sqf";

//player setVariable ["control_setSpace", controlNull];

dlg_TESTGUIDIALOG = 10000;
dlg_DATABINDING_GUI = 7002;
dlg_OPTIONSDIALOG = 4050;
dlg_SAMPLEITEMLIST = 8002;

call compile preprocessfilelinenumbers "TESTGUIDIALOG_handlers.sqf";
call compile preprocessfilelinenumbers "DATABINDING_GUI_handlers.sqf";
call compile preprocessfilelinenumbers "OPTIONSDIALOG_handlers.sqf";
call compile preprocessfilelinenumbers "SAMPLEITEMLIST_handlers.sqf";

/*
[IGN_Event_onMouseButtonDown,
{
	disableSerialization;
	private ["_dlg", "_ctrl", "_button", "_xCoord", "_yCoord", "_shiftOn", "_ctrlOn", "_altOn"];
	_dlg = _this select 0;
	_ctrl = _this select 1;
	_button = _this select 2;	// lmb = 0, rmb = 1
	_xCoord = _this select 3;
	_yCoord = _this select 4;
	_shiftOn = _this select 5;	// bool
	_ctrlOn = _this select 6;	// bool
	_altOn = _this select 7;	// bool

	hint format ["onMouseButtonDown:	display: %1 	control: %2 	buttonPressed: %3	x: %4	y: %5	shift: %6	ctrl: %7	alt: %8",
		_dlg, _ctrl, _button, _xCoord, _yCoord, _shiftOn, _ctrlOn, _altOn];

}] call IGN_fnc_addEventHandler;
*/
