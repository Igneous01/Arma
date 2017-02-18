#define LISTBOX 1500
#define TEXTBOX 1400
#define BTNADD 1600
#define BTNDEL 1601
#define BTNOK 1602
#define STATUSLABEL 1000

G_ITEMLIST = ["Joe", "Bob", "Harman", "Dave", "John", "Mark", "Sean", "Justin", "Greg"];

// onLoad handler for display
[IGN_Event_onLoadDisplay,
{
	//player sidechat (str _this);
	//diag_log text format ["_this: %1 (_this select 2): %2 dlg_DATABINDING_GUI: %3", _this, _this select 2, dlg_DATABINDING_GUI];
	if (_this select 1 == dlg_SAMPLEITEMLIST) then
	{
		player sidechat "IGN_Event_onLoad was raised (Display 8002).";
		disableSerialization;
		private ["_display"];
		_display = _this select 0;
		["listmodel", G_ITEMLIST] call IGN_fnc_createBindingVariable;
		["listmodel", 2, LISTBOX, dlg_SAMPLEITEMLIST] call IGN_fnc_bind;
		[IGN_Event_onButtonClick, dlg_SAMPLEITEMLIST,
		{
			disableSerialization;
		    params["_display", "_control"];
		    switch (ctrlIDC _control) do
		    {
		    	case BTNADD:
		    	{
		    		private _model = "listmodel" call IGN_fnc_getBindingVariable;
					private _text = [TEXTBOX, dlg_SAMPLEITEMLIST] call IGN_fnc_getCtrlData;
					if (_text isEqualTo "") exitWith
					{
						[STATUSLABEL, dlg_SAMPLEITEMLIST, "No Item Added - blank name given"] call IGN_fnc_setCtrlData;
					};
					_model pushback _text;
					["listmodel", _model] call IGN_fnc_setBindingVariable;
					[STATUSLABEL, dlg_SAMPLEITEMLIST, "Item Added"] call IGN_fnc_setCtrlData;
		    	};
		    	case BTNDEL:
		    	{
		    		private _lbIndex = lbCurSel LISTBOX;
					if (_lbIndex < 0) exitWith
					{
						[STATUSLABEL, dlg_SAMPLEITEMLIST, "No Item Deleted - nothing selected"] call IGN_fnc_setCtrlData;
					};
					lbDelete [LISTBOX, _lbIndex];
					[STATUSLABEL, dlg_SAMPLEITEMLIST, "Item successfully deleted"] call IGN_fnc_setCtrlData;
		    	};
		    	case BTNOK:
		    	{
		    		G_ITEMLIST = "listmodel" call IGN_fnc_getBindingVariable;
					closeDialog 1;
		    	};
			};
		}] call IGN_fnc_addRoutedEventHandler;

	};
}] call IGN_fnc_addEventHandler;


[IGN_Event_onUnloadDisplay,
{
	disableSerialization;
	if (_this select 1 == dlg_SAMPLEITEMLIST) then
	{
		[IGN_Event_onButtonClick, dlg_SAMPLEITEMLIST] call IGN_fnc_DestroyHandlers;
		"listmodel" call IGN_fnc_deleteBindingVariable;
	};
}] call IGN_fnc_addEventHandler;

/*
[IGN_Event_onKeyDown,
{
	["editTextVar", ("editTextVar" call IGN_fnc_getBindingVariable) + 1] call IGN_fnc_setBindingVariable;
	//hint (ctrlText 7003); works
}] call IGN_fnc_addEventHandler;
*/