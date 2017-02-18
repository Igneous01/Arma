// IGN Dialog and Control initialization
// Author: Igneous01

// uncomment next line to enable debugging
//#define IGN_DLG_DEBUG

// Determines what game the library is being used for (Leave this definition alone if you are on A3!)
//#define ___GAME_ARMA3___

#include "IGN_Macros.h"
#ifdef IGN_LIB_DEBUG
diag_log text "IGN_DLG: Building library with DEBUG = true";
#else
diag_log text "IGN_DLG: Building library with DEBUG = false";
#endif

#define IGN_BUILD compileFinal preprocessfilelinenumbers

private ["_LIB_PATH", "_IGN_PATH"];
_LIB_PATH = param[0, "IGN_DLG", [""]];	// if path parameter not provided, assume default build path of \Mission\IGN_DLG
diag_log text format ["IGN_DLG: IGN_DLG_INIT.sqf called libPath='%1'", _LIB_PATH];


// internal build - raiseEvent and raiseEventDisplay not compiled, as ui handlers calls execVM on these scripts
_IGN_PATH = _LIB_PATH + "\internal";
diag_log text format ["IGN_DLG: Building Scripts In '%1'", _IGN_PATH];
IGN_fnc_destroyHandlers = IGN_BUILD (_IGN_PATH + "\fn_destroyHandlers.sqf");
IGN_fnc_expandTokenName = IGN_BUILD (_IGN_PATH + "\fn_expandTokenName.sqf");
IGN_fnc_monitorControlProperty = IGN_BUILD (_IGN_PATH + "\fn_monitorControlProperty.sqf");
IGN_fnc_validBindingVariable = IGN_BUILD (_IGN_PATH + "\fn_validBindingVariable.sqf");
IGN_fnc_validControl = IGN_BUILD (_IGN_PATH + "\fn_validControl.sqf");


// core build
_IGN_PATH = _LIB_PATH + "\core";
diag_log text format ["IGN_DLG: Building Scripts In '%1'", _IGN_PATH];
IGN_fnc_bind = IGN_BUILD (_IGN_PATH + "\fn_bind.sqf");
IGN_fnc_convertCtrl = IGN_BUILD (_IGN_PATH + "\fn_convertCtrl.sqf");
IGN_fnc_createBindingVariable = IGN_BUILD (_IGN_PATH + "\fn_createBindingVariable.sqf");
IGN_fnc_createPresenter = IGN_BUILD (_IGN_PATH + "\fn_createPresenter.sqf");
IGN_fnc_deleteBindingVariable = IGN_BUILD (_IGN_PATH + "\fn_deleteBindingVariable.sqf");
IGN_fnc_getBindingVariable = IGN_BUILD (_IGN_PATH + "\fn_getBindingVariable.sqf");
IGN_fnc_getCtrlData = IGN_BUILD (_IGN_PATH + "\fn_getCtrlData.sqf");
IGN_fnc_setBindingVariable = IGN_BUILD (_IGN_PATH + "\fn_setBindingVariable.sqf");
IGN_fnc_setCtrlData = IGN_BUILD (_IGN_PATH + "\fn_setCtrlData.sqf");


// init build
_IGN_PATH = _LIB_PATH + "\init";
diag_log text format ["IGN_DLG: Calling Init Scripts In '%1'", _IGN_PATH];
call compile preprocessfilelinenumbers(_IGN_PATH + "\init_createEvents.sqf");
call compile preprocessfilelinenumbers (_IGN_PATH + "\init_createHandlers.sqf");


#undef IGN_BUILD
/*
	TODO:

	-Databindings for Listbox, ListNBox, ComboBox, etc...

	-Abstract these controls with functions (Set Num columns, set default spacing, add new column, add row, etc)

	-inherit sliders (create ignScrollBar and ignListScrollBar) + scroll bar events
	-TwoWayBinding


	------Custom Control templates------

	-MessageBox (with function call to instantiate)
	-Table (with functions addColumn, setColumn(), etc)
	-Form Field (with optional field paramaters as arguments + style template to use)



	-Make Routed Events local to dialog only - needs testing
	-Destructor definition of routed events and binding variables



*/