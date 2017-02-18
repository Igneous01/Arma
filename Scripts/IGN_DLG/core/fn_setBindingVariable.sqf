/*
	IGN_fnc_setBindingVariable
	assigns a new value to the bindingVariable

	Parameters:
	_varName (string): the variable name
	_value (any value): the new value to be assigned

	Returns:
	Nothing

	Information:
	Sets the value for the specified bindingVariable.
	Note that if the bindingVariable is bound to a control (bindOneWayVariable) then this will have no effect,
	as only the control has the permissions to modify the bindingVariable. If you want to modify the variable
	as well as the control, then you need to make a two-way binding between the variable and control.


	Example:
	["myBindingVar", "the answer to life is 42"] call IGN_fnc_setBindingVariable;

	// to increment the existing bindingVariable's value
	["myBindingVar", ("myBindingVar" call IGN_fnc_getBindingVariable) + 1] call IGN_fnc_setBindingVariable;
*/

#include "IGN_Macros.h"

#ifdef IGN_LIB_DEBUG
	[_this select 0, "IGN_fnc_getBindingVariable"] call IGN_fnc_validBindingVariable;
#endif
	private _var = ((_this select 0) call IGN_fnc_expandTokenName);
	private _value = _this select 1;
	private _bindData = missionNamespace getVariable _var;

#ifdef IGN_LIB_DEBUG
	if ((_bindData select 2) == 1) exitWith
	{
		private _error = format ["IGN_fnc_setBindingVariable: variable (%1) is bound to a control - it cannot be modified", _this select 0];
		diag_log text format ["%1", _error];
		[_error] call BIS_fnc_error;
	};
#endif
	_bindData set [3, true];	// flag that this variable was modified in code, not by control
	missionNamespace setVariable [_var, _bindData];
	[IGN_Event_onBindValueChanged, [_var, _value, (_bindData select 2)]] call IGN_fnc_raiseEvent;	// onBindValueChanged event raise

