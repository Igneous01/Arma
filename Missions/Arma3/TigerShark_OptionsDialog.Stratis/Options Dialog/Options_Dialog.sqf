// Options Dialog Script

#include "Options_Dialog_Macros.hpp";

// Create Dialog
_optionsDialog = CreateDialog "OPTIONS_GUI";

/*
_optionsObj = createVehicle ["Land_HelipadEmpty_F", [0,0,0], [], 0, "NONE"];

_optionsObj setVariable ["time", 0];
_optionsObj setVariable ["weather", 0];
_optionsObj setVariable ["forecast", 0];

_optionsObj setVariable ["aa_probability", 0];
_optionsObj setVariable ["cas_probability", 0];
_optionsObj setVariable ["cas_time", 0];

_optionsObj setVariable ["mech_probability", 0];
_optionsObj setVariable ["mech_part", ""];
*/

// Dialog open
waituntil {!(isNull (findDisplay IDD_OPTIONS))};

// load combo boxes
private ["_item", "_itemDefault"];	// prevent corruption



// Time
_item = lbAdd[IDC_OPTIONSDIALOG_CB_TIME, "Dawn"];
lbSetValue [IDC_OPTIONSDIALOG_CB_TIME, _item, 0];

_item = lbAdd[IDC_OPTIONSDIALOG_CB_TIME, "Noon"];
lbSetValue [IDC_OPTIONSDIALOG_CB_TIME, _item, 1];

_item = lbAdd[IDC_OPTIONSDIALOG_CB_TIME, "Dusk"];
lbSetValue [IDC_OPTIONSDIALOG_CB_TIME, _item, 2];

_item = lbAdd[IDC_OPTIONSDIALOG_CB_TIME, "Midnight"];
lbSetValue [IDC_OPTIONSDIALOG_CB_TIME, _item, 3];

_itemDefault = lbAdd[IDC_OPTIONSDIALOG_CB_TIME, "Random"];			// default selected
lbSetValue [IDC_OPTIONSDIALOG_CB_TIME, _itemDefault, 4];

lbSetCurSel [IDC_OPTIONSDIALOG_CB_TIME, _itemDefault];

// switch block
_fnc_time =
{
	private ["_index", "_value"];
	_index = _this;
	_value = 0;	// skiptime value
	switch (_index) do
	{
		case 0:
		{
			_value = 6;		// skipTime + 6 hrs
		};
		case 1:
		{
			_value = 12;
		};
		case 2:
		{
			_value = 18;
		};
		case 3:
		{
			_value = 0;
		};
		case 4:
		{
			_value = (random 23.9);
		};
	};

	_value;
};




// Weather & Forecast
{
	_item = lbAdd[_x, "Clear"];
	lbSetValue [_x, _item, 0];

	_item = lbAdd[_x, "Cloudy"];
	lbSetValue [_x, _item, 1];

	_item = lbAdd[_x, "Rain"];
	lbSetValue [_x, _item, 2];

	_item = lbAdd[_x, "Thunderstorm"];
	lbSetValue [_x, _item, 3];

	_itemDefault = lbAdd[_x, "Random"];			// default selected
	lbSetValue [_x, _itemDefault, 4];

	lbSetCurSel [_x, _itemDefault];
} foreach [IDC_OPTIONSDIALOG_CB_WEATHER, IDC_OPTIONSDIALOG_CB_FORECAST];

// switch block (for both weather and forecast)
_fnc_weather =
{
	private ["_index", "_value"];
	_index = _this;
	_value = 0;	// overcast value
	switch (_index) do
	{
		case 0:
		{
			_value = 0;		// no overcast
		};
		case 1:
		{
			_value = 0.3;
		};
		case 2:
		{
			_value = 0.5;
		};
		case 3:
		{
			_value = 0.9;
		};
		case 4:
		{
			_value = (random 1);
		};
	};

	_value;
};



// Probability Combo Boxes
{
	_item = lbAdd[_x, "None"];
	lbSetValue [_x, _item, 0];

	_item = lbAdd[_x, "Low"];
	lbSetValue [_x, _item, 1];

	_itemDefault = lbAdd[_x, "Medium"];			// Default selected
	lbSetValue [_x, _itemDefault, 2];

	_item = lbAdd[_x, "High"];
	lbSetValue [_x, _item, 3];

	_item = lbAdd[_x, "Very High"];
	lbSetValue [_x, _item, 4];

	_item = lbAdd[_x, "Always"];
	lbSetValue [_x, _item, 5];

	_item = lbAdd[_x, "Random"];
	lbSetValue [_x, _item, 6];

	lbSetCurSel [_x, _itemDefault];
} foreach [IDC_OPTIONSDIALOG_CB_AA_CHANCE, IDC_OPTIONSDIALOG_CB_CAS_CHANCE, IDC_OPTIONSDIALOG_CB_MECH_CHANCE];

// switch block (for probability)
_fnc_chance =
{
	private ["_index", "_value"];
	_index = _this;
	_value = 0;	// chance value (0 - 100)
	switch (_index) do
	{
		case 0:
		{
			_value = 0;		// no chance
		};
		case 1:
		{
			_value = 10;	// low
		};
		case 2:
		{
			_value = 40;	// medium
		};
		case 3:
		{
			_value = 60;	// high
		};
		case 4:
		{
			_value = 80;	// very high
		};
		case 5:
		{
			_value = 100;	// always
		};
		case 6:
		{
			_value = (random 100);	// random
		};
	};

	_value;
};



// CAS Response Time Combo Box
_item = lbAdd[IDC_OPTIONSDIALOG_CB_CAS_RESPONSE, "Slow (2 min)"];
lbSetValue [IDC_OPTIONSDIALOG_CB_CAS_RESPONSE, _item, 0];

_itemDefault = lbAdd[IDC_OPTIONSDIALOG_CB_CAS_RESPONSE, "Normal (1 min)"];		// default selection
lbSetValue [IDC_OPTIONSDIALOG_CB_CAS_RESPONSE, _itemDefault, 1];

_item = lbAdd[IDC_OPTIONSDIALOG_CB_CAS_RESPONSE, "Fast (30 sec)"];
lbSetValue [IDC_OPTIONSDIALOG_CB_CAS_RESPONSE, _item, 2];

_item = lbAdd[IDC_OPTIONSDIALOG_CB_CAS_RESPONSE, "Random"];
lbSetValue [IDC_OPTIONSDIALOG_CB_CAS_RESPONSE, _item, 3];

lbSetCurSel [IDC_OPTIONSDIALOG_CB_CAS_RESPONSE, _itemDefault];

// switch block
_fnc_cas_time =
{
	private ["_index", "_value"];
	_index = _this;
	_value = 0;	// number of seconds
	switch (_index) do
	{
		case 0:
		{
			_value = 120;		// 2 minutes
		};
		case 1:
		{
			_value = 60;
		};
		case 2:
		{
			_value = 30;
		};
		case 3:
		{
			_value = 30 + ((random 10) * 10);		// may need to be tweaked
		};
	};

	_value;
};



// Preferred Mechanical Failure part combo box
_item = lbAdd[IDC_OPTIONSDIALOG_CB_MECH_PART, "Fuel Leak"];
lbSetValue [IDC_OPTIONSDIALOG_CB_MECH_PART, _item, 0];

_item = lbAdd[IDC_OPTIONSDIALOG_CB_MECH_PART, "Main Rotar"];
lbSetValue [IDC_OPTIONSDIALOG_CB_MECH_PART, _item, 1];

_item = lbAdd[IDC_OPTIONSDIALOG_CB_MECH_PART, "ATRQ Rotor"];
lbSetValue [IDC_OPTIONSDIALOG_CB_MECH_PART, _item, 2];

_item = lbAdd[IDC_OPTIONSDIALOG_CB_MECH_PART, "Instruments"];
lbSetValue [IDC_OPTIONSDIALOG_CB_MECH_PART, _item, 3];

_itemDefault = lbAdd[IDC_OPTIONSDIALOG_CB_MECH_PART, "All"];		// default selection
lbSetValue [IDC_OPTIONSDIALOG_CB_MECH_PART, _itemDefault, 4];

lbSetCurSel [IDC_OPTIONSDIALOG_CB_MECH_PART, _itemDefault];

// switch block
_fnc_mech_part =
{
	private ["_index", "_value"];
	_index = _this;
	_value = "";	// string selection of part
	switch (_index) do
	{
		case 0:
		{
			_value = "";		// fuel leak
		};
		case 1:
		{
			_value = "";		// main rotar
		};
		case 2:
		{
			_value = "";		// anti torque rotar (counter rotar/tail rotar)
		};
		case 3:
		{
			_value = "";		// instrumentation
		};
		case 4:
		{
			_value = "";		// all parts
		};
	};

	_value;
};


waitUntil
{

	GAME_TIMES = (lbCurSel IDC_OPTIONSDIALOG_CB_TIME) call _fnc_time;
	GAME_WEATHER = (lbCurSel IDC_OPTIONSDIALOG_CB_WEATHER) call _fnc_weather;
	GAME_FORECAST = (lbCurSel IDC_OPTIONSDIALOG_CB_FORECAST) call _fnc_weather;

	AA_CHANCE = (lbCurSel IDC_OPTIONSDIALOG_CB_AA_CHANCE) call _fnc_chance;
	REINFORCEMENT_CHANCE = (lbCurSel IDC_OPTIONSDIALOG_CB_CAS_CHANCE) call _fnc_chance;
	REINFORCEMENT_TIMES = (lbCurSel IDC_OPTIONSDIALOG_CB_CAS_RESPONSE) call _fnc_cas_time;

	MECHANICAL_CHANCE = (lbCurSel IDC_OPTIONSDIALOG_CB_MECH_CHANCE) call _fnc_chance;
	MECHANICAL_PART = (lbCurSel IDC_OPTIONSDIALOG_CB_MECH_PART) call _fnc_mech_part;

	sleep 0.1;
	!dialog;
};

// process

// time
skipTime GAME_TIMES;

// required to recompute cloud cover (ARMA 3)
86400 setOvercast GAME_WEATHER;
skipTime 24;
//

// Forecasted Weather - 1 hour in
3600 setOvercast GAME_FORECAST;