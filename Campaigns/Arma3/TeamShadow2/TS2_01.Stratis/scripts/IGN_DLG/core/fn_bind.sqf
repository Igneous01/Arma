/*
	IGN_fnc_bind
	Binds a control to a variable

	Parameters:
	_varName (string) : the variable name
	_bindType (number) : the binding type
	_control (number) : the control idc
	_display (number) : the display idd that houses the control

	Returns:
	nothing

	Information:
	Upon establishing the binding, the controls text property will be replaced with bindingVariables current value.
	The display and the current control must be loaded in order for the binding to be successful

	Example:
	myControlIDC = 42;	// a control in the display class has an idc of 42 defined
	["myBindingVar", myControlIDC] call IGN_fnc_bind; // now any time myBindingVar is changed, the control's text will also change


*/

#include "IGN_Macros.h"

// TODO: Support control object as parameter (NOPE: cant setVariable controls directly)

	disableSerialization;
	params ["_varName", "_bindType", "_controlID", "_displayID"];

#ifdef IGN_LIB_DEBUG
	// check to make sure _value exists in missionNamespace
	// check to make sure control is valid (and exists)
	[_varName, "IGN_fnc_bind"] call IGN_fnc_validBindingVariable;
	["IGN_fnc_bind", _controlID] call IGN_fnc_validControl;
#endif

	_varName = _varName call IGN_fnc_expandTokenName;
	private _bindData = missionNamespace getVariable _varName;
	private _bindingControls = _bindData select 1;
	// store as IDC (idc, controls cannot be stored via setVariable !!!!)
	_bindingControls pushback [_controlID, _displayID];
	private _value = _bindData select 0;

	// only do this on bindType 1
	if (_bindType == 1) then
	{
		 _value = [_controlID, _displayID] call IGN_fnc_getCtrlData;
	};

	missionNamespace setVariable [_varName, [_value, _bindingControls, _bindType]];
	[IGN_Event_onBind, [_varName, _controlID, _displayID, _bindType]] call IGN_fnc_raiseEvent;
	[IGN_Event_onBindValueChanged, [_varName, _value, _bindType]] call IGN_fnc_raiseEvent;

	// CONTROL MUST BE LOADED FOR THIS TO WORK!
	if (_bindType >= 1) then
	{
		[_controlID, _displayID, _varName] call IGN_fnc_monitorControlProperty;
	};
