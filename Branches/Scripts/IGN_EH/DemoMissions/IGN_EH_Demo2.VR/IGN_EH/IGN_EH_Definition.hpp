/*
	Author: Igneous01

	Definitions for the IGN Library
	Include in description.ext

	-- HEADER --

	Tag: IGN

*/


class CfgFunctions
{
	class IGN
	{
		class Event
		{
			class createEvent { file = "IGN_EH\event\fn_createEvent.sqf";};
			class createEventClient { file = "IGN_EH\event\fn_createEventClient.sqf"; };
			class createEventLocal { file = "IGN_EH\event\fn_createEventLocal.sqf"; };
			class createEventServer {file = "IGN_EH\event\fn_createEventServer.sqf";};
			class deleteEvent {file = "IGN_EH\event\fn_deleteEvent.sqf";};
			class addEventHandler {file = "IGN_EH\event\fn_addEventHandler.sqf";};
			class deleteEventHandler {file = "IGN_EH\event\fn_deleteEventHandler.sqf";};
			class getEventHandler {file = "IGN_EH\event\fn_getEventHandler.sqf";};
			class getEventHandlers {file = "IGN_EH\event\fn_getEventHandlers.sqf";};
			class getEventHandlerCount {file = "IGN_EH\event\fn_getEventHandlerCount.sqf";};
			class raiseEvent {file = "IGN_EH\event\fn_raiseEvent.sqf";};
		};

		class Event_Internal
		{
			class initEvent {file = "IGN_EH\event\internal\fn_initEvent.sqf";};
			class initServerEvent {file = "IGN_EH\event\internal\fn_initServerEvent.sqf";};
			class isEvent {file = "IGN_EH\event\internal\fn_isEvent.sqf";};
			class validateEvent {file = "IGN_EH\event\internal\fn_validateEvent.sqf";};
			class validateEventArgs {file = "IGN_EH\event\internal\fn_validateEventArgs.sqf";};
		};

		class Functor
		{
			class createFunctor {file = "IGN_EH\functor\fn_createFunctor.sqf";};
			class deleteFunctor {file = "IGN_EH\functor\fn_deleteFunctor.sqf";};
			class callFunctor {file = "IGN_EH\functor\fn_callFunctor.sqf";};
		};

		class Functor_Internal
		{
			class isFunctor {file = "IGN_EH\functor\internal\fn_isFunctor.sqf";};
			class validateFunctor {file = "IGN_EH\functor\internal\fn_validateFunctor.sqf";};
		};

		class Internal
		{
			class errorAndLogRPT {file = "IGN_EH\internal\fn_errorAndLogRPT.sqf";};
			class is {file = "IGN_EH\internal\fn_is.sqf";};
		};
	};
};
