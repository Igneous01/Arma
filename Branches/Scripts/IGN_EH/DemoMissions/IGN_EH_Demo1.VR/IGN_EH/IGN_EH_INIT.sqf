/*
	Author: Igneous01

	Initializes the IGN library

	Tag: IGN

*/

// uncomment next line to enable debugging and logging
//#define IGN_LIB_DEBUG
#define IGN_BUILD compileFinal preprocessfilelinenumbers

private ["_LIB_PATH", "_IGN_PATH"];
_LIB_PATH = _this param[0, "IGN_EH\", [""]];	// if path parameter not provided, assume default build path of \Mission\IGN_EH
diag_log text format ["IGN_EH: IGN_EH_INIT.sqf called [libPath='%1'", _LIB_PATH];


// internal build
_IGN_PATH = _LIB_PATH + "\internal";
diag_log text format ["IGN_EH: Building Scripts In '%1'", _IGN_PATH];
IGN_fnc_errorAndLogRPT = IGN_BUILD (_IGN_PATH + "\fn_errorAndLogRPT.sqf");


// event\internal build
_IGN_PATH = _LIB_PATH + "\event\internal";
diag_log text format ["IGN_EH: Building Scripts In '%1'", _IGN_PATH];
IGN_fnc_validateEvent = IGN_BUILD (_IGN_PATH + "\fn_validateEvent.sqf");
IGN_fnc_validateEventArgs = IGN_BUILD (_IGN_PATH + "\fn_validateEventArgs.sqf");


// event build
_IGN_PATH = _LIB_PATH + "\event";
diag_log text format ["IGN_EH: Building Scripts In '%1'", _IGN_PATH];
IGN_fnc_addEventHandler = IGN_BUILD (_IGN_PATH + "\fn_addEventHandler.sqf");
IGN_fnc_createEvent = IGN_BUILD (_IGN_PATH + "\fn_createEvent.sqf");
IGN_fnc_deleteEvent = IGN_BUILD (_IGN_PATH + "\fn_deleteEvent.sqf");
IGN_fnc_deleteEventHandler = IGN_BUILD (_IGN_PATH + "\fn_deleteEventHandler.sqf");
IGN_fnc_getEventHandler = IGN_BUILD (_IGN_PATH + "\fn_getEventHandler.sqf");
IGN_fnc_getEventHandlers = IGN_BUILD (_IGN_PATH + "\fn_getEventHandlers.sqf");
IGN_fnc_getEventHandlersClient = IGN_BUILD (_IGN_PATH + "\fn_getEventHandlersClient.sqf");
IGN_fnc_raiseEvent = IGN_BUILD (_IGN_PATH + "\fn_raiseEvent.sqf");


// event\display build
_IGN_PATH = _LIB_PATH + "\event\display";
diag_log text format ["IGN_EH: Building Scripts In '%1'", _IGN_PATH];
IGN_fnc_addRoutedEventHandler = IGN_BUILD (_IGN_PATH + "\fn_addRoutedEventHandler.sqf");
IGN_fnc_raiseRoutedEvent = IGN_BUILD (_IGN_PATH + "\fn_raiseRoutedEvent.sqf");


// functor\internal build
_IGN_PATH = _LIB_PATH + "\functor\internal";
diag_log text format ["IGN_EH: Building Scripts In '%1'", _IGN_PATH];
IGN_fnc_isFunctor = IGN_BUILD (_IGN_PATH + "\fn_isFunctor.sqf");
IGN_fnc_validateFunctor = IGN_BUILD (_IGN_PATH + "\fn_validateFunctor.sqf");


// functor build
_IGN_PATH = _LIB_PATH + "\functor";
diag_log text format ["IGN_EH: Building Scripts In '%1'", _IGN_PATH];
IGN_fnc_callFunctor = IGN_BUILD (_IGN_PATH + "\fn_callFunctor.sqf");
IGN_fnc_createFunctor = IGN_BUILD (_IGN_PATH + "\fn_createFunctor.sqf");
IGN_fnc_deleteFunctor = IGN_BUILD (_IGN_PATH + "\fn_deleteFunctor.sqf");


//#include "RoutedEvent.hpp"

#undef IGN_BUILD
