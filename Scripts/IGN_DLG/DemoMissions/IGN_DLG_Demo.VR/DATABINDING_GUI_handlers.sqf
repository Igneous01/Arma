// onLoad handler for display
[IGN_Event_onLoadDisplay,
{
	//player sidechat (str _this);
	//diag_log text format ["_this: %1 (_this select 2): %2 dlg_DATABINDING_GUI: %3", _this, _this select 2, dlg_DATABINDING_GUI];
	if (_this select 1 == dlg_DATABINDING_GUI) then
	{
		player sidechat "IGN_Event_onLoad was raised (Display 7002).";
		disableSerialization;
		private ["_display"];
		_display = _this select 0;
		["editTextVar", 0] call IGN_fnc_createBindingVariable;
		["editTextVar2", 0] call IGN_fnc_createBindingVariable;
		diag_log text format ["Gui Handlers - %1 with properties %2", ("editTextVar" call IGN_fnc_expandTokenName), (missionNamespace getVariable ("editTextVar" call IGN_fnc_expandTokenName))];

		// editTextVar is bound to the top edit box in the gui, any changes made in the top edit box will change editTextVar
		["editTextVar", 1, 7003, dlg_DATABINDING_GUI] call IGN_fnc_bind;

		// the two bottom controls are bound to editTextVar's value, when its value is changed, these controls will update to reflect this
		["editTextVar", 0, 7004, dlg_DATABINDING_GUI] call IGN_fnc_bind;
		["editTextVar", 0, 7005, dlg_DATABINDING_GUI] call IGN_fnc_bind;

		// editTextVar2 is bound to the middle edit box - when its value is changed, editTextVar2 value will also change
		["editTextVar2", 1, 7004, dlg_DATABINDING_GUI] call IGN_fnc_bind;

		_arr = [["Name", "Age", "Obj"], ["Dave", 22, objNull], ["John", 34, objNull] ];
		_arr2 = ["Listbox 1","Listbox 2","Listbox 3", "Listbox 4", "Listbox 4", objNull, 222, "Listbox 4", "Listbox 4"];

		// set the list boxes withdata
		[7006, dlg_DATABINDING_GUI, _arr] call IGN_fnc_setCtrlData;
		[7007, dlg_DATABINDING_GUI, _arr2] call IGN_fnc_setCtrlData;



		/*
			This is the sequence of events that happen in the above:
			user modifies the top text box's text property
			-onBindValueChanged is raised, editTextVar value is updated to the new value
			-editTextVar raises onBindValueChanged again, this time signalling all controls must update their values
			-controls 7003,7004,7005 all update their values to the new one from the original user input
			-because control 7004 has a binding to editTextVar2, it raises onBindValueChanged
			-editTextVar2's value is updated to new value

			note that the control 7003 (the top edit box) gets updated twice here - the first time when the user changes it, and a second time
			as a result of editTextVar signalling controls to update. This will hopefully be fixed later on.
		*/

		[] spawn
		{
			while {ctrlVisible 7006} do
			{
				hint format ["editTextVar: %1        editTextVar2: %2", ("editTextVar" call IGN_fnc_getBindingVariable), ("editTextVar2" call IGN_fnc_getBindingVariable)];
				sleep 1;
			};
		};
	}
}] call IGN_fnc_addEventHandler;


[IGN_Event_onUnloadDisplay,
{
	if (_this select 1 == dlg_DATABINDING_GUI) then
	{
		"editTextVar" call IGN_fnc_deleteBindingVariable;
		"editTextVar2" call IGN_fnc_deleteBindingVariable;
	};
}] call IGN_fnc_addEventHandler;


/*
[IGN_Event_onKeyDown,
{
	["editTextVar", ("editTextVar" call IGN_fnc_getBindingVariable) + 1] call IGN_fnc_setBindingVariable;
	//hint (ctrlText 7003); works
}] call IGN_fnc_addEventHandler;
*/