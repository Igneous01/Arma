/*
	IGN_DLG_monitorControlProperty
	Monitors a controls data property, if the value was changed, raises event IGN_Event_onBindValueChanged
	If it fails to acquire controls text property (control destroyed, control nil, or invalid) routine will terminate
*/
// [ctrl IDC, display IDD, fully qualified variable name]
#include "IGN_Macros.h"

params["_controlID", "_displayID", "_variable"];
private _onEachFrameID = format ["onEachFrame_%1_ctrl_%2", _variable, _controlID];

[_onEachFrameID, "onEachFrame",
	{
		params ["_controlID", "_displayID", "_variable", "_id"];
		if (!ctrlVisible _controlID) exitWith
		{
			[_id, "onEachFrame"] call BIS_fnc_removeStackedEventHandler;

#ifdef IGN_LIB_DEBUG
			diag_log text "------------------IGN_DLG: onEachFrame stacked handler terminated.";
#endif

		};
		private _ctrlVal = [_controlID, _displayID] call IGN_fnc_getCtrlData;
		private _varVal = (missionNamespace getVariable _variable) select 0;
		//diag_log text format ["monitorControlProperty: _ctrlVal: %1 _varVal %2", _ctrlVal, _varVal];
		if (!(_ctrlVal isEqualTo _varVal)) then
		{
			// if the value has changed, and it was not by the control, do not raise this
			if(! ((missionNamespace getVariable _variable) select 3) ) then
			{
				// currently the argument '1' is ignored in onBindValueChanged event
				[IGN_Event_onBindValueChanged, [_variable, _ctrlVal, 1]] call IGN_fnc_raiseEvent;
			};
		};
	},
	[_controlID, _displayID, _variable, _onEachFrameID]
] call BIS_fnc_addStackedEventHandler;