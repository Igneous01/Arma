
// catch all handlers
// creates a handler for each event, that displays in sidechat
{
	private ["_strCode"];
	_strCode = format
	[
	"[%1, %2,
	{
		disableSerialization;
		private ['_dlg', '_ctrl', '_dID'];
		_dlg = _this select 0;
		_ctrl = _this select 1;
		_dID = ctrlIDD _dlg;
		player sidechat '%1 raised (dlg: ' + (str _dID) + ' ctrl: ' + (str _ctrl) + ')';
	}] call IGN_fnc_addRoutedEventHandler;", _x, dlg_TESTGUIDIALOG];	// add routed event handlers for display 10000 (test gui display)

	call compile _strCode;
} foreach
[
	IGN_Event_onButtonClick,
	IGN_Event_onButtonDown,
	IGN_Event_onButtonUp,
	IGN_Event_onMouseEnter,
	IGN_Event_onMouseExit,
	IGN_Event_onSetFocus,
	IGN_Event_onKillFocus,
	IGN_Event_onTimer,
	IGN_Event_onLBDrop,
	IGN_Event_onKeyDown,
	IGN_Event_onKeyUp,
	IGN_Event_onChar,
	IGN_Event_onMouseButtonDown,
	IGN_Event_onMouseButtonUp,
	IGN_Event_onMouseButtonClick,
	IGN_Event_onMouseButtonDblClick,
	//IGN_Event_onMouseMoving,
	//IGN_Event_onMouseHolding,
	IGN_Event_onMouseZChanged,
	IGN_Event_onCanDestroy,
	IGN_Event_onDestroy,
	IGN_Event_onLBSelChanged,
	IGN_Event_onLBListSelChanged,
	IGN_Event_onLBDblClick,
	IGN_Event_onLBDrag,
	IGN_Event_onLBDragging
];


// onLoad handler for display - sets data sources on combo boxes and list boxes, etc
[IGN_Event_onLoadDisplay,
{
	player sidechat (str _this);
	if (_this select 1 == dlg_TESTGUIDIALOG) then
	{
		player sidechat "IGN_Event_onLoad was raised (Display 10000).";
		_sampleData = ["Item1", "Item2", "Item3", "Item4", "Item5", "Item6", "Item7", "Item8", "Item9", "Item10"];
		_sampleTable =
		[
			["Name", "Age", "Obj"],
			["Dave", "22", "objNull"],
			["John", "34", "objNull"],
			["Joe", "54", "objTank"],
			["Darmi", "13", "pid"],
			["Lakshri", "26", "test"],
			["Kahn", "28", "eve"],
			["Tozo", "33", "rererer"],
			["Johnny", "17", "objTank"],
			["Fushai", "24", "objTank"]
		];

		["sampleTable", _sampleTable] call IGN_fnc_createBindingVariable;
		["sampleTable", 0, 1501, dlg_TESTGUIDIALOG] call IGN_fnc_bind;

		// combo boxes
		[2100, dlg_TESTGUIDIALOG, _sampleData] call IGN_fnc_setCtrlData;
		[2101, dlg_TESTGUIDIALOG, _sampleData] call IGN_fnc_setCtrlData;
		[1500, dlg_TESTGUIDIALOG, _sampleData] call IGN_fnc_setCtrlData;	// listbox
		//[1501, _sampleTable, 1] call IGN_fnc_SetSource;	//listNbox
		[1502, dlg_TESTGUIDIALOG,  _sampleData] call IGN_fnc_setCtrlData;	// xlistbox

		// lets see what happens when we modify _sampleTable after it's been passed into listbox as source, will it update in UI?
		_sampleTable pushback ["Fushai", "24", "objTank"];

		["sampleTable", _sampleTable] call IGN_fnc_setBindingVariable;

		// progress bar
		[1004, dlg_TESTGUIDIALOG, 0.65] call IGN_fnc_setCtrlData;

	};
}] call IGN_fnc_addEventHandler;

[IGN_Event_onUnloadDisplay,
{
	private _displayID = _this select 1;
	if (_displayID == dlg_TESTGUIDIALOG) then
	{
		player sidechat "IGN_Event_onUnload raised (dlg: " + str _displayID + ")";
		"sampleTable" call IGN_fnc_deleteBindingVariable;
	};
}] call IGN_fnc_addEventHandler;