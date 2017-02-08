/*
	IGN Dialog and Controls internal functions
	These functions are not recommended for use, and may be modified without warning

	Author: Igneous01

*/



// IGN_DLG_updateControlValue
// Updates a controls text property to the specified value
// _this select 0 - control idc
// _this select 1 - value
// val must be sent in as string!!!! no conversion done here!
IGN_DLG_updateControlValue =
{
	//private ["_display"];
	//_display = findDisplay 7002;
	//(_display displayCtrl _x) ctrlSetText (str _val);
	ctrlSetText[_this select 0, _this select 1];
};



// IGN_DLG_updateVariableValue
// updates a bindingVariables value to the specified value
// _this select 0 - fully qualified variable name
// _this select 1 - binding Data (array)
IGN_DLG_updateVariableValue =
{
	missionNamespace setVariable [_this select 0, _this select 1];
};



// IGN_DLG_expandTokenName
// expands the variable name to its real name in missionNamespace
// _varName: the shorthand name of the variable (string)
// returns string
IGN_DLG_expandTokenName =
{
	private ["_varName"];
	_varName = _this;
	format ["IGN_DLG_BIND_%1", _varName];	// return expanded token name
};



/*
	IGN_DLG_monitorControlProperty
	Monitors a controls text property, if the value was changed, raises event IGN_Event_onBindValueChanged
	If it fails to acquire controls text property (control destroyed, control nil, or invalid) routine will terminate
*/
IGN_DLG_monitorControlProperty =
{
	private ["_control", "_variable", "_onEachFrameID"];
	_control = _this select 0;	// idc
	_variable = _this select 1;	// fully qualified variable name

	_onEachFrameID = format ["onEachFrame_%1", _variable];
	

	[_onEachFrameID, "onEachFrame", 
	{
		private ["_control", "_variable", "_varVal", "_ctrlVal", "_id"];
		_control = _this select 0;
		_variable = _this select 1;
		_id = _this select 2;

		_ctrlVal = ctrlText _control;
		_varVal = (missionNamespace getVariable _variable) select 0;

		
		if (!ctrlVisible _control) exitWith 
		{
			[_id, "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
			#ifdef IGN_DLG_DEBUG
			diag_log text "------------------IGN_DLG: onEachFrame stacked handler terminated.";
			#endif
		};	
		

		if (typename _varVal != "STRING") then
		{
			_varVal = str _varVal;
		};

		if (_ctrlVal != _varVal) then
		{
			player sidechat "onEachFrame: _ctrlVal != _varVal";
			[IGN_Event_onBindValueChanged, [_variable, _ctrlVal, 1]] call IGN_fnc_raiseEvent;	// need to change the 1 so that it can work for two-way binding
		};
	}, [_control, _variable, _onEachFrameID]] call BIS_fnc_addStackedEventHandler;
};


/*
	IGN_DLG_validBindingVariable
	Checks if variable exists
	If not, log error in rpt
*/
IGN_DLG_validBindingVariable =
{
	private ["_fncName", "_varName"];
	_varName = _this select 0;
	_fncName = _this select 1;

	if (
	    	isNil
	    	{
	    		missionNamespace getVariable (_varName call IGN_DLG_expandTokenName);
	    	}
	   ) then
	{
		private ["_error"];
		_error = format ["%1: binding variable (%2) does not exist", _fncName, _varName];
        diag_log text ("------------------IGN_DLG: " + _error);
	};


};




IGN_DLG_validControl =
{
	private ["_fncName", "_control"];
	_fncName = _this select 0;
	_control = _this select 1;

	if (!ctrlVisible _control) then
	{
		private ["_error"];
		_error = format ["%1: control (%2) does not exist", _fncName, _varName];
        diag_log text ("------------------IGN_DLG: " + _error);
	};

};



IGN_DLG_DestroyHandlers =
{
	private ["_event", "_displayID"];
	_event = _this select 0;
	_displayID = _this select 1;

	// delete all event handlers that belong to this display
	{
		if ( (_x select 0) == _displayID ) then
		{
            [_event, _forEachIndex] call IGN_fnc_deleteEventHandler;
		};
	} foreach (_event getVariable "handlers");


};