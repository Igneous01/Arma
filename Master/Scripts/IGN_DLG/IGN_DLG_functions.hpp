/*
	IGN Dialog and Control functions

	Most of these functions relate to data binding

	Author: Igneous01
*/





// EH for onBindValueChanged
// Passes following arguments:
// varName: the name of the bound variable
// val: the new value
// bindType: the type of binding (oneway to control, oneway to variable, twoway)
[IGN_Event_onBindValueChanged,
{
	private ["_varName", "_val", "_bindData", "_bindType"];
	_varName = _this select 0;
	_val = _this select 1;
	_bindType = _this select 2;

	// fetch binding data
	_bindData = missionNamespace getVariable _varName;

	switch (_bindType) do
	{
		// one-way bind to control
		case 0:
		{
			//player sidechat "onBindValueChanged: Updating Controls";
			// convert to string if necessary
			diag_log text format ["------------IGN_DLG: onBindValueChanged: _val: %1", _val];
			diag_log text format ["------------IGN_DLG: onBindValueChanged: _bindData: %1", _bindData];
			if (typename _val != typename "") then
			{
				_val = str _val;
			};
			{
				[_x, _val] call IGN_DLG_updateControlValue;
			} foreach (_bindData select 1);
		};
		// one-way bind to variable
		case 1:
		{
			player sidechat "onBindValueChanged: Setting variable";
			_bindData set [0, _val];
			[_varName, _bindData] call IGN_DLG_updateVariableValue;
			[IGN_Event_onBindValueChanged, [_varName, _val, 0]] call IGN_fnc_raiseEvent;
			//[_varName, _val] call IGN_DLG_setBindingVariable;
		};
		// two-way bind
		case 2:
		{
			_bindData set [0, _val];
			[_varName, _bindData] call IGN_DLG_updateVariableValue;
			if (typename _val != typename "") then
			{
				_val = str _val;
			};
			{
				[_x, _val] call IGN_DLG_updateControlValue;
			} foreach (_bindData select 1);	// dealing with potentially out of date data here...
		};
	};

}] call IGN_fnc_addEventHandler;







/*
	IGN_DLG_createBindingVariable
	Creates a binding variable, to allow binding to controls

	Parameters:
	_varName (string) : the name of the variable
	_varInit (any) : the initial value of the variable

	Returns:
	nothing. To reference the variable name in other functions, only _varName is required

	Information:
	Sets a property in the missionNamespace scope.
	The value of this property is as follows:

	[value, [controlIDC1, controlIDC2, ...], bindType]

	_this select 0 is the value of the bindingVariable
	_this select 1 [controlIDC1, controlIDC2, ...] is the array of control idc's currently binded to this variable
	_this select 2 is the bindType value:
	-1 denotes the variable has no binding set
	 0 denotes the variable has a one-way bind to control (the variable modifies the control)
	 1 denotes the control has a one-way bind to the variable (the control modifies the variable)
	 2 denotes the variable has a two-way bind to a control (both control and variable can modify/update each other)

	 Note that bindingVariable names MUST BE UNIQUE, re-defining a bindingVariable is UNDEFINED BEHAVIOUR


	 Example:
	 ["myBindingVar", 0] call IGN_DLG_createBindingVariable;	// missionNamespace will store "myBindingVar" and neccessary information about the bind
	 "myBindingVar" call IGN_DLG_getBindingVariable;	// returns 0
	 ["myBindingVar", 5] call IGN_DLG_setBindingVariable;	// myBindingVar is now 5
	 "myBindingVar" call IGN_DLG_getBindingVariable;	// returns 5

*/
IGN_DLG_createBindingVariable =
{
	private ["_varName", "_varInit", "_bindData"];
	_varName = [_this, 0, "", [""]] call BIS_fnc_param;	//string
	_varInit = [_this, 1, 0];	//anything

	#ifdef IGN_DLG_DEBUG
	// confirm duplicate varName does not exist
	if (
	    	!isNil
	    	{
	    		missionNamespace getVariable (_varName call IGN_DLG_expandTokenName)
	    	}
	    ) then
	{
		private ["_error"];
		_error = format ["IGN_DLG_createBindingVariable: binding variable (%1) already exists", _varName];
		diag_log text _error;
		[_error] call BIS_fnc_error;
	};
	#endif
	// bindData will always consist of [bindingVariable, [bindingControl1, bindingControl2, ... etc], bindType]
	// bindType values:
	// -1: no binding type
	// 0: one-way bind to control
	// 1: one-way bind to variable
	// 2: two-way bind
	_bindData = [_varInit, [], -1];
	missionNamespace setVariable [format ["IGN_DLG_BIND_%1", _varName], _bindData];	// IGN_DLG_BIND_myVarName
};




// _this - unqualified variable name
IGN_DLG_deleteBindingVariable =
{
	#ifdef IGN_DLG_DEBUG
	[_this, "IGN_DLG_deleteBindingVariable"] call IGN_DLG_validBindingVariable;
	#endif
	missionNamespace setVariable [_this call IGN_DLG_expandTokenName, nil];
};




/*
	IGN_DLG_getBindingVariable
	gets the value of the bindingVariable

	Parameters:
	varName (string) : the bindingVariables name

	Returns:
	the value of the bindingVariable


	Example:
	"myBindingVar" call IGN_DLG_getBindingVariable;
*/
IGN_DLG_getBindingVariable =
{
	#ifdef IGN_DLG_DEBUG
	[_this, "IGN_DLG_getBindingVariable"] call IGN_DLG_validBindingVariable;
	#endif
	(missionNamespace getVariable (_this call IGN_DLG_expandTokenName)) select 0;
};




/*
	IGN_DLG_setBindingVariable
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
	["myBindingVar", "the answer to life is 42"] call IGN_DLG_setBindingVariable;

	// to increment the existing bindingVariable's value
	["myBindingVar", ("myBindingVar" call IGN_DLG_getBindingVariable) + 1] call IGN_DLG_setBindingVariable;
*/
IGN_DLG_setBindingVariable =
{
	#ifdef IGN_DLG_DEBUG
	[_this select 0, "IGN_DLG_getBindingVariable"] call IGN_DLG_validBindingVariable;
	#endif
	private ["_var", "_value", "_bindData", "_bindType"];
	_value = _this select 1;
	_var = ((_this select 0) call IGN_DLG_expandTokenName);
	_bindData = missionNamespace getVariable _var;

	#ifdef IGN_DLG_DEBUG
	if ((_bindData select 2) == 1) exitWith 
	{
		private ["error"];
		error = format ["IGN_DLG_setBindingVariable: variable (%1) is bound to a control - it cannot be modified", _this select 0];
	};	// if the variable is bound to a control, it cannot be changed
	#endif

	_bindData set[0, _value];
	_bindType = _bindData select 2;
	missionNamespace setVariable [_var, _bindData];
	[IGN_Event_onBindValueChanged, [_var, _value, _bindType]] call IGN_fnc_raiseEvent;	// onBindValueChanged event raise

};




/*
	IGN_DLG_bindOneWayControl
	Binds a control to a variable
	only the variable manipulates the controls property,
	the control property cannot be modifed outside of this
	(DO NOT EVEN TRY, LEST YOU RISK BREAKING YOUR OWN GUI with bizarre errors)

	Parameters:
	_varName (string) : the variable name
	_control (number) : the control idc

	Returns:
	nothing

	Information:
	Upon establishing the binding, the controls text property will be replaced with bindingVariables current value.
	The display and the current control must be loaded in order for the binding to be successful

	Example:
	myControlIDC = 42;	// a control in the display class has an idc of 42 defined
	["myBindingVar", myControlIDC] call IGN_DLG_bindOneWayControl; // now any time myBindingVar is changed, the control's text will also change


*/
// TODO: Support control object as parameter (NOPE: cant setVariable controls directly)
IGN_DLG_bindOneWayControl =
{
	disableSerialization;
	#ifdef IGN_DLG_DEBUG
	[_this select 0, "IGN_DLG_getBindingVariable"] call IGN_DLG_validBindingVariable;
	#endif
	private ["_control", "_varName"];
	_varName = _this select 0;	// string
	_control = _this select 1;	// control idc

	// check to make sure _value exists in missionNamespace
	// check to make sure control is valid (and exists)

	private ["_bindData", "_value", "_bindingControls"];
	_varName = _varName call IGN_DLG_expandTokenName;
	_bindData = missionNamespace getVariable _varName;
	_value = _bindData select 0;
	_bindingControls = _bindData select 1;

	// store as IDC (idc, controls cannot be stored via setVariable !!!!)
	_bindingControls set [count _bindingControls, _control];

	missionNamespace setVariable [_varName, [_value, _bindingControls, 0]];
	[IGN_Event_onBind, [_varName, _control, 0]] call IGN_fnc_raiseEvent;

	// CONTROL MUST BE LOADED FOR THIS TO WORK!
	// if _control is not idc, need to convert it to idc
	[IGN_Event_onBindValueChanged, [_varName, _value, 0]] call IGN_fnc_raiseEvent;
};



/*
	IGN_DLG_bindOneWayVariable
	Binds a variable to a control
	only the control manipulates the variables value,
	the variable property cannot be modifed outside of this
	(DO NOT EVEN TRY, LEST YOU RISK BREAKING YOUR OWN GUI with bizarre errors)

	Parameters:
	_varName (string) : the variable name
	_control (number) : the control idc

	Returns:
	nothing

	Information:
	Upon establishing the binding, the bindingVariables value will be changed to the controls text property value.
	The display and the current control must be loaded in order for the binding to be successful

	Example:
	myControlIDC = 42;	// a control in the display class has an idc of 42 defined
	["myBindingVar", myControlIDC] call IGN_DLG_bindOneWayVariable; // now any time controls text is changed, myBindingVar is updated to reflect this


*/
IGN_DLG_bindOneWayVariable =
{
	disableSerialization;
	#ifdef IGN_DLG_DEBUG
	[_this select 0, "IGN_DLG_getBindingVariable"] call IGN_DLG_validBindingVariable;
	#endif
	private ["_control", "_varName"];
	_varName = _this select 0;	// string
	_control = _this select 1;	// control idc

	// check to make sure _value exists in missionNamespace
	// check to make sure control is valid (and exists)
	#ifdef IGN_DLG_DEBUG
	["IGN_DLG_bindOneWayVariable", _control] call IGN_DLG_validControl;
	#endif

	private ["_bindData", "_value", "_bindingControls"];
	_varName = _varName call IGN_DLG_expandTokenName;
	_bindData = missionNamespace getVariable _varName;

	_value = ctrlText _control;
	_bindingControls = _bindData select 1;

	// store as IDC (idc, controls cannot be stored via setVariable !!!!)
	_bindingControls set [count _bindingControls, _control];

	missionNamespace setVariable [_varName, [_value, _bindingControls, 1]];
	[IGN_Event_onBind, [_varName, _control, 1]] call IGN_fnc_raiseEvent;

	// need to somehow monitor controls input
	[_control, _varName] call IGN_DLG_monitorControlProperty;

};

