#define IDC_OPTIONSDIALOG_CB_TIME 4064
#define IDC_OPTIONSDIALOG_CB_WEATHER 4065
#define IDC_OPTIONSDIALOG_CB_FORECAST 4066
#define IDC_OPTIONSDIALOG_CB_AA_CHANCE 4067
#define IDC_OPTIONSDIALOG_CB_CAS_CHANCE 4068
#define IDC_OPTIONSDIALOG_CB_CAS_RESPONSE 4069
#define IDC_OPTIONSDIALOG_CB_MECH_CHANCE 4070
#define IDC_OPTIONSDIALOG_CB_MECH_PART 4071

#define IDC_OPTIONSDIALOG_BUTTON_OK 4072

G_TIME = 0;
G_WEATHER = 0.5;
G_FORECAST = 0.5;
G_AACHANCE = 0.1;
G_CASCHANCE = 0.1;
G_CASRESPONSE = 300;
G_MECHCHANCE= 0.1;
G_MECHPART = "Engine";
G_HANDLES = [];

// onLoad handler for display
[IGN_Event_onLoadDisplay,
{
	//player sidechat (str _this);
	diag_log text format ["IGN_Event_onLoadDisplay for DisplayID : %1", _this select 1];
	if (_this select 1 == dlg_OPTIONSDIALOG) then
	{
		disableSerialization;
		params["_display", "_displayID"];

		private _timeSource = ["Morning - 8:00", "Afternoon - 12:00", "Evening - 6:00", "Night - 2:00"];
		private _weatherSource = ["Clear", "Cloudy", "Rain", "Thunderstorm"];
		private _probabilitySource = ["Low", "Medium", "High"];
		private _preferenceSource = ["Engine", "Rotor", "Electronics"];
		private _responseSource = ["Fast", "Normal", "Slow"];

		[IDC_OPTIONSDIALOG_CB_TIME, dlg_OPTIONSDIALOG, _timeSource] call IGN_fnc_setCtrlData;
		[IDC_OPTIONSDIALOG_CB_WEATHER, dlg_OPTIONSDIALOG, _weatherSource] call IGN_fnc_setCtrlData;
		[IDC_OPTIONSDIALOG_CB_FORECAST, dlg_OPTIONSDIALOG, _weatherSource] call IGN_fnc_setCtrlData;
		[IDC_OPTIONSDIALOG_CB_AA_CHANCE, dlg_OPTIONSDIALOG, _probabilitySource] call IGN_fnc_setCtrlData;
		[IDC_OPTIONSDIALOG_CB_CAS_CHANCE, dlg_OPTIONSDIALOG, _probabilitySource] call IGN_fnc_setCtrlData;
		[IDC_OPTIONSDIALOG_CB_CAS_RESPONSE, dlg_OPTIONSDIALOG, _responseSource] call IGN_fnc_setCtrlData;
		[IDC_OPTIONSDIALOG_CB_MECH_CHANCE, dlg_OPTIONSDIALOG, _probabilitySource] call IGN_fnc_setCtrlData;
		[IDC_OPTIONSDIALOG_CB_MECH_PART, dlg_OPTIONSDIALOG, _preferenceSource] call IGN_fnc_setCtrlData;

		G_HANDLES pushback ([IGN_Event_onLBSelChanged, dlg_OPTIONSDIALOG,
		{
			disableSerialization;
			params ["_display", "_ctrl", "_index"];
			diag_log text format["onLBSelChanged (%1)", _this];
			private _element = _ctrl lbText _index;
			private _ctrlID = ctrlIDC _ctrl;
			diag_log text format["onLBSelChanged (ctrlID: %1, element: %2)", _ctrlID, _element];
			switch (_ctrlID) do
			{
				case IDC_OPTIONSDIALOG_CB_TIME: {G_TIME = _element;};
				case IDC_OPTIONSDIALOG_CB_WEATHER: {G_WEATHER = _element;};
				case IDC_OPTIONSDIALOG_CB_FORECAST: {G_FORECAST = _element;};
				case IDC_OPTIONSDIALOG_CB_AA_CHANCE: {G_AACHANCE = _element;};
				case IDC_OPTIONSDIALOG_CB_CAS_CHANCE: {G_CASCHANCE = _element;};
				case IDC_OPTIONSDIALOG_CB_CAS_RESPONSE: {G_CASRESPONSE = _element;};
				case IDC_OPTIONSDIALOG_CB_MECH_CHANCE: {G_MECHCHANCE = _element;};
				case IDC_OPTIONSDIALOG_CB_MECH_PART: {G_MECHPART = _element;};
				default {};
			};

		}] call IGN_fnc_addRoutedEventHandler);

		G_HANDLES pushback ([IGN_Event_onButtonClick, dlg_OPTIONSDIALOG,
		{
			disableSerialization;
		    params["_display", "_control"];
		    diag_log text format["onButtonClick (%1)", _this];
			if (ctrlIDC _control == IDC_OPTIONSDIALOG_BUTTON_OK) then
			{
				closeDialog 1;
				hintC format ["%1 %2 %3 %4 %5 %6 %7 %8", G_TIME, G_WEATHER, G_FORECAST, G_AACHANCE, G_CASCHANCE, G_CASRESPONSE, G_MECHCHANCE, G_MECHPART];
			};
		}] call IGN_fnc_addRoutedEventHandler);

		diag_log text "OPTIONS DIALOG: onLoad - initializing data and handlers";
	}
}] call IGN_fnc_addEventHandler;


[IGN_Event_onUnloadDisplay,
{
	disableSerialization;
	diag_log text format["onUnloadDisplay (%1)", _this];
	if (_this select 1 == dlg_OPTIONSDIALOG) then
	{
		[IGN_Event_onLBSelectionChanged, dlg_OPTIONSDIALOG] call IGN_fnc_DestroyHandlers;
		[IGN_Event_onButtonClick, dlg_OPTIONSDIALOG] call IGN_fnc_DestroyHandlers;
		diag_log text "OPTIONS DIALOG: onUnload - destroying handlers";
	};
}] call IGN_fnc_addEventHandler;