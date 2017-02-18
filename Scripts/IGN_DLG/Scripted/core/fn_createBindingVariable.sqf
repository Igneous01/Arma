/*
	IGN_fnc_createBindingVariable
	Creates a binding variable, to allow binding to controls

	Parameters:
	_varName (string) : the name of the variable
	_varInit (any) : the initial value of the variable

	Returns:
	nothing. To reference the variable name in other functions, only _varName is required

	Information:
	Sets a property in the missionNamespace scope.
	The value of this property is as follows:

	[value, [controlIDC1, controlIDC2, ...], bindType, flagWasModifiedInCode]

	_this select 0 is the value of the bindingVariable
	_this select 1 [controlIDC1, controlIDC2, ...] is the array of control idc's currently binded to this variable
	_this select 2 is the bindType value:
	-1 denotes the variable has no binding set
	 0 denotes the variable has a one-way bind to control (the variable modifies the control)
	 1 denotes the control has a one-way bind to the variable (the control modifies the variable)

	 Note that bindingVariable names MUST BE UNIQUE, re-defining a bindingVariable is UNDEFINED BEHAVIOUR


	 Example:
	 ["myBindingVar", 0] call IGN_fnc_createBindingVariable;	// missionNamespace will store "myBindingVar" and neccessary information about the bind
	 "myBindingVar" call IGN_fnc_getBindingVariable;	// returns 0
	 ["myBindingVar", 5] call IGN_fnc_setBindingVariable;	// myBindingVar is now 5
	 "myBindingVar" call IGN_fnc_getBindingVariable;	// returns 5

*/

#include "IGN_Macros.h"

	private _varName = param [0, "", [""]];	//string
	private _varInit = param [1, 0];	//anything

#ifdef IGN_LIB_DEBUG
	// confirm duplicate varName does not exist
	if (
	    	!isNil
	    	{
	    		missionNamespace getVariable (_varName call IGN_fnc_expandTokenName);
	    	}
	    ) then
	{
		private ["_error"];
		_error = format ["IGN_fnc_createBindingVariable: binding variable (%1) already exists", _varName];
		diag_log text _error;
		[_error] call BIS_fnc_error;
	};
#endif
	// bindData will always consist of [bindingVariableVal, [bindingControl1, bindingControl2, ... etc], bindType]
	// bindType values:
	// -1: no binding type
	// 0: one-way bind to control
	// 1: one-way bind to variable
	// 2: two-way binding
	// bindData [varVal, [controls...], bindType]
	private _bindData = [_varInit, [], -1, false];
	missionNamespace setVariable [format ["IGN_DLG_BIND_%1", _varName], _bindData];	// IGN_fnc_BIND_myVarName
