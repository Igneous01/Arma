/*
	Author: Igneous01

	Initializes the IGN library

	Tag: IGN

*/

// uncomment next line to enable debugging and logging
//#define IGN_LIB_DEBUG
#define IGN_BUILD compile preprocessfilelinenumbers

private ["_IGN_PATH"];
// internal build
_IGN_PATH = "internal";
IGN_fnc_errorAndLogRPT = IGN_BUILD _IGN_PATH + "\fn_errorAndLogRPT.sqf";
IGN_fnc_is =  IGN_BUILD _IGN_PATH + "\fn_is.sqf";

// event\internal build
_IGN_PATH = "event\internal";
IGN_fnc_initEvent = IGN_BUILD _IGN_PATH + "\fn_initEvent.sqf";
IGN_fnc_initServerEvent = IGN_BUILD _IGN_PATH + "\fn_initServerEvent.sqf";
IGN_fnc_isEvent = IGN_BUILD _IGN_PATH + "\fn_isEvent.sqf";
IGN_fnc_validateEvent = IGN_BUILD _IGN_PATH + "\fn_validateEvent.sqf";
IGN_fnc_validateEventArgs = IGN_BUILD _IGN_PATH + "\fn_validateEventArgs.sqf";

// event build
_IGN_PATH = "event";
IGN_fnc_addEventHandler = IGN_BUILD _IGN_PATH + "\fn_addEventHandler.sqf";
IGN_fnc_createEvent = IGN_BUILD _IGN_PATH + "\fn_createEvent.sqf";
IGN_fnc_createEventClient = IGN_BUILD _IGN_PATH + "\fn_createEventClient.sqf";
IGN_fnc_createEventLocal = IGN_BUILD _IGN_PATH + "\fn_createEventLocal.sqf";
IGN_fnc_createEventServer = IGN_BUILD _IGN_PATH + "\fn_createEventServer.sqf";
IGN_fnc_deleteEvent = IGN_BUILD _IGN_PATH + "\fn_deleteEvent.sqf";
IGN_fnc_deleteEventHandler = IGN_BUILD _IGN_PATH + "\fn_deleteEventHandler.sqf";
IGN_fnc_getEventHandler = IGN_BUILD _IGN_PATH + "\fn_getEventHandler.sqf";
IGN_fnc_getEventHandlerCount = IGN_BUILD _IGN_PATH + "\fn_getEventHandlerCount.sqf";
IGN_fnc_getEventHandlers = IGN_BUILD _IGN_PATH + "\fn_getEventHandlers.sqf";
IGN_fnc_raiseEvent = IGN_BUILD _IGN_PATH + "\fn_raiseEvent.sqf";

// functor\internal build
_IGN_PATH = "functor\internal";
IGN_fnc_isFunctor = IGN_BUILD _IGN_PATH + "\fn_isFunctor.sqf";
IGN_fnc_validateFunctor = IGN_BUILD _IGN_PATH + "\fn_validateFunctor.sqf";

// functor build
_IGN_PATH = "functor";
IGN_fnc_callFunctor = IGN_BUILD _IGN_PATH + "\fn_callFunctor.sqf";
IGN_fnc_createFunctor = IGN_BUILD _IGN_PATH + "\fn_createFunctor.sqf";
IGN_fnc_deleteFunctor = IGN_BUILD _IGN_PATH + "\fn_deleteFunctor.sqf";

#undef IGN_BUILD
