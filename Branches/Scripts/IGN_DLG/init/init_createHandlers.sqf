// Default Handlers created


// EH for onBindValueChanged
// Passes following arguments:
// varName: the name of the bound variable
// val: the new value
// bindType: the type of binding (oneway to control, oneway to variable, twoway)

#include "IGN_Macros.h"

[IGN_Event_onBindValueChanged,
{
	params ["_varName", "_val", "_bindType"];
	// fetch binding data
	private _bindData = missionNamespace getVariable _varName;

#ifdef IGN_LIB_DEBUG
	diag_log text format ["------------IGN_DLG: onBindValueChanged: _val: %1	_bindData: %2", _val, _bindData];
#endif

	_bindData set[0, _val];
	{
		[_x select 0, _x select 1, _val] call IGN_fnc_setCtrlData;
	} foreach (_bindData select 1);	// dealing with potentially out of date data here...

	_bindData set[3, false];	// set flag to false
	missionNamespace setVariable [_varName, _bindData];
}] call IGN_fnc_addEventHandler;


/*
// garbage collecting handler - if a display is unloaded, destroy all registered handlers
// this is not needed, it destroys handlers that the user may have only initialized once - so if the dialog is created again all the handlers will be gone
[IGN_Event_onUnloadDisplay,
{
	//player sidechat "IGN_Event_onUnload raised";
	#ifdef IGN_fnc_DEBUG
	diag_log text format ["IGN_DLG: IGN_Event_onUnload raised %1", _this];
	#endif
	private["_displayID"];
	_displayID = _this select 2;
	{
		[_x, _displayID] call IGN_fnc_DestroyHandlers;
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
		IGN_Event_onMouseZChanged,
		IGN_Event_onCanDestroy,
		IGN_Event_onDestroy,
		IGN_Event_onLBSelChanged,
		IGN_Event_onLBListSelChanged,
		IGN_Event_onLBDblClick,
		IGN_Event_onLBDrag,
		IGN_Event_onLBDragging
	];
}] call IGN_fnc_addEventHandler;
*/

/*
	switch (_bindType) do
	{
		// one-way bind to control
		case 0:
		{
			// convert to string if necessary

			if (typename _val != typename "") then
			{
				_val = str _val;
			};

			{
				[(_x select 0), (_x select 1), _val] call IGN_fnc_setCtrlData;
			} foreach (_bindData select 1);
		};
		// one-way bind to variable
		case 1:
		{
			//player sidechat "onBindValueChanged: Setting variable";
			_bindData set [0, _val];
			missionNamespace setVariable [_varName, _bindData];
			[IGN_Event_onBindValueChanged, [_varName, _val, 0]] call IGN_fnc_raiseEvent;
			//[_varName, _val] call IGN_fnc_setBindingVariable;
		};
		// two-way bind
		case 2:
		{
			private _varChangedInCode = _bindData select 3;


			missionNamespace setVariable [_varName, _bindData];
			if (!_varChangedInCode) then
			{
				_bindData set [0, _val];
			}
			else
			{
				[(_x select 0), (_x select 1), _val] call IGN_fnc_setCtrlData;
			} foreach (_bindData select 1);	// dealing with potentially out of date data here...
		};
	};

*/