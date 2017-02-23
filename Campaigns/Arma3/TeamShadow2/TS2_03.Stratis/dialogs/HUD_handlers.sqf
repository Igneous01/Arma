#define TXTROUND 1000
#define TXTSHOTS 1001
#define TXTTIME 1002
disableSerialization;

IGN_fnc_resetHud =
{
	params ["_round"];
	((uiNamespace getVariable "HUDLONGRANGE") displayCtrl TXTROUND) ctrlSetText ("Round: " + _round);
	((uiNamespace getVariable "HUDLONGRANGE") displayCtrl TXTSHOTS) ctrlSetText "Shots Left: 3";
	((uiNamespace getVariable "HUDLONGRANGE") displayCtrl TXTTIME) ctrlSetText "Time Left: 5:00";

};

IGN_fnc_stopHud =
{
	params ["_status"];
	((uiNamespace getVariable "HUDLONGRANGE") displayCtrl TXTROUND) ctrlSetText _status;
	((uiNamespace getVariable "HUDLONGRANGE") displayCtrl TXTSHOTS) ctrlSetText "";
	((uiNamespace getVariable "HUDLONGRANGE") displayCtrl TXTTIME) ctrlSetText "";


	[] spawn
	{
		private _strT = "Starting In: 0:";
		for [{_i = 30}, {_i > 0}, {_i = _i - 1}] do
		{
			sleep 1;
			((uiNamespace getVariable "HUDLONGRANGE") displayCtrl TXTTIME) ctrlSetText (_strT + str _i);
		};

		// reset HUD
		["ONE"] call IGN_fnc_resetHud;
	};
};


/*
[IGN_Event_onKeyDown,
{
	["editTextVar", ("editTextVar" call IGN_fnc_getBindingVariable) + 1] call IGN_fnc_setBindingVariable;
	//hint (ctrlText 7003); works
}] call IGN_fnc_addEventHandler;
*/