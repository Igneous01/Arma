//#ifndef __IGN_LIB_EVENT_HEADER__
//#define __IGN_LIB_EVENT_HEADER__
/*
	Author: Igneous01
	Event Header


	Events

	"An event is a message sent by an object to signal the occurrence of an action.
	The action could be caused by user interaction, such as a mouse click, or it
	could be triggered by some other program logic. The object that raises the
	event is called the event sender. The object that captures the event and
	responds to it is called the event receiver." - MSDN -Events and Delegates for .NET


	This is an 'API' specifically designed for scripters to create and manage their own custom events.
	These set of calls will allow you to specify an event for any situation, as well as allow you to:
	- Register handlers
	- Manipulate handles in the event
	- Delete handlers
	- Raise Event and specify what arguments to pass to handlers
	- Delete Events
	- Create Events for Server, Client, Local with appropriate broadcasts
*/





// SCRIPTER INTERFACE (Use these functions) ***************************************************************************************

/*
	createEvent
	Creates an event object, allowing registration of handlers and raising
	Does not broadcast in multiplayer

	Parameters
	args (Array) (Optional) - Argument types that the event will send to all handlers
					default value - [] (no arguments)
	name (String) (Optional) - The name of the object (this will set the vehicle's variable name)
					default value - "" (no name)

	Returns
	The created event object, with these getters in its namespace:
	"name" - the name of the event (Argument passed)
	"handlers" - an array containing all handlers currently registered to the event
	"arg_types" - an array containing the argument types
	"raised" - a bool value determining if the event is currently being raised

	Example:
	myEvent = call IGN_fnc_createEvent;	// no args, no vehicle var name
	myEvent = [[objNull, []]] call IGN_fnc_createEvent; // will send arguments of type object (_this select 0) and array (_this select 1)
	[objNull, "myEvent"] call IGN_fnc_createEvent;	// myEvent can be referenced, will send argument of type object (_this)
	[[objNull], []], "myEvent"] call IGN_fnc_createEvent; // vehicle var name will be myEvent - can now reference myEvent in code

*/
IGN_fnc_createEvent =
{
	private ["_arg_types", "_name", "_event"];
	if (!isNil {_this}) then
	{
		_arg_types = [_this, 0, []] call BIS_fnc_param;
		_name = [_this, 1, "", [""]] call BIS_fnc_param;
	}
	else
	{
		_name = "";
		_arg_types = [];
	};

	_event = createVehicle ["Land_HelipadEmpty_F", [0,0,0], [], 0, "NONE"];

	if (_name != "") then
	{
		_event setVehicleVarName _name;
		_event Call Compile Format ["%1=_This",_name];
	};

	[_event, _name, _arg_types] call IGN_fnc_initEvent;	// return event
};





/*
	createEventServer
	Creates an event object on the server only, allowing registration of handlers and raising
	Broadcasts vehicleVarName (if exists) and setVariables in object space

	Parameters
	args (Array) (Optional) - Argument types that the event will send to all handlers
						default value - [] (no arguments)
	name (String) (Optional) - The name of the object (this will set the vehicle's variable name) - Will be broadcasted in MP
						default value - "" (no name)

	Returns
	The created event object, with these getters in its namespace:
	"name" - the name of the event (Argument passed)
	"handlers" - an array containing all handlers currently registered to the event
	"arg_types" - an array containing the argument types
	"raised" - a bool value determining if the event is currently being raised

	Example:
	myEvent = call IGN_fnc_createEventServer;	// no args, no vehicle var name
	myEvent = [[objNull, []]] call IGN_fnc_createEventServer; // will send arguments of type object (_this select 0) and array (_this select 1)
	[[objNull], []], "myEvent"] call IGN_fnc_createEventServer; // vehicle var name will be myEvent
*/
IGN_fnc_createEventServer =
{
	if (!isServer) exitWith {};
	private ["_arg_types", "_name", "_event"];
	if (!isNil {_this}) then
	{
		_arg_types = [_this, 0, []] call BIS_fnc_param;
		_name = [_this, 1, "", [""]] call BIS_fnc_param;
	}
	else
	{
		_name = "";
		_arg_types = [];
	};

	_event = createVehicle ["Land_HelipadEmpty_F", [0,0,0], [], 0, "NONE"];

	if (_name != "") then
	{
		_event setVehicleVarName _name;
		_event Call Compile Format ["%1=_This; publicVariable ""%1""",_name];
	};

	[_event, _name, _arg_types] call IGN_fnc_initServerEvent;	// return event
};





/*
	createEventClient
	Creates an event object on the client(s) only, allowing registration of handlers and raising
	Does not broadcast the object in multiplayer

	Parameters
	args (Array) (Optional) - Argument types that the event will send to all handlers
						default value - [] (no arguments)
	name (String) (Optional) - The name of the object (this will set the vehicle's variable name)
						default value - "" (no name)

	Returns
	The created event object, with these getters in its namespace:
	"name" - the name of the event (Argument passed)
	"handlers" - an array containing all handlers currently registered to the event
	"arg_types" - an array containing the argument types
	"raised" - a bool value determining if the event is currently being raised

	Example:
	myEvent = call IGN_fnc_createEventClient;	// no args, no vehicle var name
	myEvent = [[objNull, []]] call IGN_fnc_createEventClient; // will send arguments of type object (_this select 0) and array (_this select 1)
	[[objNull], []], "myEvent"] call IGN_fnc_createEventClient; // vehicle var name will be myEvent
*/
IGN_fnc_createEventClient =
{
	if (isServer) exitWith {};
	private ["_name"];
	_name = [_this, 0, "", [""]] call BIS_fnc_param;
	_name call IGN_fnc_createEvent;
};





/*
	createEventLocal
	Creates a local event object using CreateVehicleLocal (not broadcasted in MP), allowing registration of handlers and raising
	Does not broadcast the object in multiplayer

	Parameters
	args (Array) (Optional) - Argument types that the event will send to all handlers
						default value - [] (no arguments)
	name (String) (Optional) - The name of the object (this will set the vehicle's variable name)
						default value - "" (no name)

	Returns
	The created event object, with these getters in its namespace:
	"name" - the name of the event (Argument passed)
	"handlers" - an array containing all handlers currently registered to the event
	"arg_types" - an array containing the argument types
	"raised" - a bool value determining if the event is currently being raised

	Example:
	myEvent = call IGN_fnc_createEventLocal;	// no args, no vehicle var name
	myEvent = [[objNull, []]] call IGN_fnc_createEventLocal; // will send arguments of type object (_this select 0) and array (_this select 1)
	[[objNull], []], "myEvent"] call IGN_fnc_createEventLocal; // vehicle var name will be myEvent
*/
IGN_fnc_createEventLocal =
{
	private ["_arg_types", "_name", "_event"];
	if (!isNil {_this}) then
	{
		_arg_types = [_this, 0, []] call BIS_fnc_param;
		_name = [_this, 1, "", [""]] call BIS_fnc_param;
	}
	else
	{
		_name = "";
		_arg_types = [];
	};

	_event = "Land_HelipadEmpty_F" createVehicleLocal [0,0,0];

	if (_name != "") then
	{
		_event setVehicleVarName _name;
		_event Call Compile Format ["%1=_This;",_name];
	};

	[_event, _name, _arg_types] call IGN_fnc_initEvent;	// return event
};





/*
	deleteEvent
	Deletes an existing event object
	If an invalid event object is passed, it will not be deleted

	Parameters
	event (object) - the event to be deleted

	Returns
	nothing

	Example:
	myEvent call IGN_fnc_deleteEvent;
	[myEvent] call IGN_fnc_deleteEvent;
*/
IGN_fnc_deleteEvent =
{
	private ["_event"];
	_event = _this;
	if (typename _event == typename []) then {_event = _this select 0;};

	#ifdef IGN_LIB_DEBUG
	[_event, "IGN_fnc_deleteEvent"] call IGN_fnc_validateEvent;
	#endif

	deleteVehicle _event;
};






/*
	raiseEvent
	Raises an existing event, calling all handlers in sequence with specified arguments
	When an event object is raised, it will set its namespace attribute "raised" to true, until all handlers calls are finished
	When all handlers have received the event, the attribute "raised" will be set to false

	Parameters
	event (object) - the event to be raised
	arguments (anything) (optional) - the arguments to be passed to each handler
						default value - [] (no arguments will be passed)

	Returns
	nothing

	Example
	[myEvent] call IGN_fnc_raiseEvent;	// raises myEvent, no arguments are passed to handlers
	myEvent call IGN_fnc_raiseEvent;	// same as above, but without array brackets
	[myEvent, [myString, myTank]] call IGN_fnc_raiseEvent;	// raises myEvent, passes myString as (_this select 0), myTank as (_this select 1) to all handlers
	[myEvent, myTank] call IGN_fnc_raiseEvent;	// raises myEvent, passes myTank as _this to all handlers


	****** dealing with ASYNCHRONOUS/NON-SCHEDULED/THREADED calls to an event

	This is particularly useful if you have spawn 'ed threads that may raise the event and want to synchronize calls

	Example of Unsafe non-scheduled calls to an event:

	// thread 1 only tracks player death
	_thread_1 = spawn {
		waitUntil {!alive player};
		[eventUnitDead, player] call IGN_fnc_raiseEvent;	// this can be called at the same time as the other one!
	};

	// thread 2 tracks any dead in enemyUnits
	_thread_2 = spawn {
		private ["_grpAliveCount"];
		_grpAliveCount = count enemyUnits;
		while {_grpAliveCount > 0} do
		{
			{
				if (!alive _x) then
				{
					_grpAliveCount = _grpAliveCount - 1;
					[eventUnitDead, _x] call IGN_fnc_raiseEvent;	// this can be called at the same time as the other one!
				};
			} foreach enemyUnits;
		};
	};

	// Potential for thread 1 and thread 2 to raise eventUnitDead at the same time! not safe!

	Example of safer non-scheduled calls to an event

	Here is a safer way of doing the above:

	// thread 1 only tracks player death
	_thread_1 = spawn {
		waitUntil {!alive player};
		waitUntil {!(eventUnitDead getVariable "raised")};	// block thread if event is busy
		[eventUnitDead, player] call IGN_fnc_raiseEvent;
	};

	// thread 2 tracks any dead in enemyUnits
	_thread_2 = spawn {
		private ["_grpAliveCount"];
		_grpAliveCount = count enemyUnits;
		while {_grpAliveCount > 0} do
		{
			{
				if (!alive _x) then
				{
					_grpAliveCount = _grpAliveCount - 1;
					waitUntil {!(eventUnitDead getVariable "raised")};	// block thread if event is busy
					[eventUnitDead, _x] call IGN_fnc_raiseEvent;
				};
			} foreach enemyUnits;
		};
	};
	******
*/
IGN_fnc_raiseEvent =
{
	private ["_event", "_params"];
	if (typename _this == typename []) then
	{
		_event = _this select 0;
		_params = [_this, 1, []] call BIS_fnc_param;
	}
	else
	{
		_event = _this;
		_params = [];
	};


	#ifdef IGN_LIB_DEBUG
	[_event, "fnc_RaiseEvent"] call IGN_fnc_validateEvent;
	[_event, _params, "fnc_RaiseEvent"] call IGN_fnc_validateEventArgs;
	#endif


	_event setVariable ["raised", true];

	{
		_params call _x;
	} foreach (_event getVariable "handlers");

	_event setVariable ["raised", false];	// return nothing
};





/*
	addEventHandler
	Adds a handler to the specified event, handlerID is returned

	Parameters
	event (object) - the event
	handle (code) - event handler code

	Returns
	handlerID (index of handler in this event)

	Example
	handlerID = [myEvent, {hint format ["%1", _this];}] call IGN_fnc_addEventHandler;	// everytime myEvent is raised, a hint will display the argument passed to the handler (assuming myEvent sends 1 argument or array)

	// Assuming myEvent was raised as such : [myEvent, ["weapon_class_tank_cannon", someTank]] call fnc_RaiseEvent;
	handlerID = [myEvent,
	{
		private ["_weaponName", "_tank"];
		_weaponName = _this select 0;		// raise of myEvent sends weapon string as arg 0
		_tank = _this select 1;				// tank object is sent as arg 1
		//...
	}] call IGN_fnc_addEventHandler;
*/
IGN_fnc_addEventHandler =
{
	private ["_event", "_handle"];
	_event = _this select 0;
	_handle = [_this, 1, {}, [{}]] call BIS_fnc_param;

	#ifdef IGN_LIB_DEBUG
	[_event, "IGN_fnc_addEventHandler"] call IGN_fnc_validateEvent;
	#endif

	(_event getVariable "handlers") set [count (_event getVariable "handlers"), _handle];
	count (_event getVariable "handlers") - 1;	// return id
};





/*
	deleteEventHandler
	removes a handler from the specified event

	Parameters
	event (object) - the event
	handleID (number) - event handler id

	Returns
	nothing

	Example
	[myEvent, handlerID] call IGN_fnc_deleteEventHandler;	// removes handlerID from myEvent
*/
IGN_fnc_deleteEventHandler =
{
	private ["_event", "_id", "_handlers"];
	_event = _this select 0;
	_id = [_this, 1, 0, [0]] call BIS_fnc_param;

	#ifdef IGN_LIB_DEBUG
	_event call fnc_ValidateEvent;
	[_event, "IGN_fnc_deleteEventHandler"] call IGN_fnc_validateEvent;
	#endif

	_handlers = (_event getVariable "handlers") - [((_event getVariable "handlers") select _id)];
	_event setVariable ["handlers", _handlers];
};





/*
	getEventHandlers
	returns the array of all event handlers registered to the current event

	Parameters
	event (object) - the event

	Returns
	array of code

	Example
	allHandlers = myEvent call IGN_fnc_getEventHandlers;
*/
IGN_fnc_getEventHandlers =
{
	private ["_event"];
	_event = _this;
	if (typename _event == typename []) then {_event = _this select 0;};

	#ifdef IGN_LIB_DEBUG
	[_event, "IGN_fnc_getEventHandlers"] call IGN_fnc_validateEvent;
	#endif

	_event getVariable "handlers";	// return
};





/*
	getEventHandler
	returns the specified handler at the specified index

	Parameters
	event (object) - the event
	id (number) - index of handler

	Returns
	code

	Example
	handler = [myEvent, 0] call IGN_fnc_getEventHandler;	// returns first registered handler
*/
IGN_fnc_getEventHandler =
{
	private ["_event", "_index"];
	_event = _this select 0;
	_index = _this select 1;

	#ifdef IGN_LIB_DEBUG
	[_event, "IGN_fnc_getEventHandler"] call IGN_fnc_validateEvent;
	#endif

	(_event getVariable "handlers") select _index;	// return
};





/*
	getEventHandlerCount
	returns the size of the handler array

	Parameters
	event (object) - the event

	Returns
	size (number)

	Example
	numHandles = myEvent call IGN_fnc_getEventHandlerCount;
*/
IGN_fnc_getEventHandlerCount =
{
	private ["_event"];
	_event = _this;
	if (typename _event == typename []) then {_event = _this select 0;};

	#ifdef IGN_LIB_DEBUG
	[_event, "IGN_fnc_getEventHandlerCount"] call IGN_fnc_validateEvent;
	#endif

	count (_event getVariable "handlers");	// return
};






// END OF INTERFACE ****************************************************************************









// INTERNAL FUNCTIONS - Not recommended for use!

// Initializes event
IGN_fnc_initEvent =
{
	private ["_event", "_name", "_arg_types"];
	_event = _this select 0;
	_name = _this select 1;
	_arg_types = _this select 2;
	_event setVariable ["IGN_EVENT_TYPE", 0];		// event identifier
	_event setVariable ["name", _name];
	_event setVariable ["arg_types", _arg_types];
	_event setVariable ["raised", false];			// asynchronous check
	_event setVariable ["handlers", []];
	_event;
};

// Initializes server event (setVariable will be broadcast to all clients)
IGN_fnc_initServerEvent =
{
	private ["_event", "_name", "_arg_types"];
	_event = _this select 0;
	_name = _this select 1;
	_arg_types = _this select 2;
	_event setVariable ["IGN_EVENT_TYPE", 0, true];		// event identifier
	_event setVariable ["name", _name, true];
	_event setVariable ["arg_types", _arg_types, true];
	_event setVariable ["raised", false, true];			// asynchronous check
	_event setVariable ["handlers", [], true];
	_event;
};

// Checks if object is event
IGN_fnc_isEvent =
{
	[_this, "IGN_EVENT_TYPE"] call IGN_fnc_is;
};

// validates event, if failed, Error and RPT log
IGN_fnc_validateEvent =
{
	private ["_event", "_fncName"];
	_event = _this select 0;
	_fncName = _this select 1;
	if (!(_event call IGN_fnc_isEvent)) then
	{
		[_event, "Event", _fncName] call IGN_fnc_errorAndLogRPT;
	};
};

// validate event arguments and arguments passed, if fail, Error and RPT log
IGN_fnc_validateEventArgs =
{
	private ["_event","_argsSupplied", "_argsRequired", "_i", "_fncName"];
	_event = _this select 0;
	_argsSupplied = _this select 1;
	if (typename _argsSupplied != typename []) then {_argsSupplied = [_argsSupplied];};
	_argsRequired = _event getVariable "arg_types";
	if (typename _argsRequired != typename []) then {_argsRequired = [_argsRequired];};
	_fncName = _this select 2;

	//diag_log text format ["IGN_fnc_validateEventArgs : _argsSupplied - %1 , _argsRequired - %2", _argsSupplied, _argsRequired];

	if (count _argsSupplied != count _argsRequired) exitWith
	{
		["%1 : Invalid arguments passed - expected %2 - got %3", _fncName, _argsRequired, _argsSupplied] call BIS_fnc_error;
		diag_log text format ["%1 : Invalid arguments passed - expected %2 - got %3", _fncName, _argsRequired, _argsSupplied];
	};

	for [{_i = 0}, {_i < count _argsSupplied}, {_i = _i + 1}] do
	{
		if (typename (_argsSupplied select _i) != typename (_argsRequired select _i)) then
		{
			["%1 - Invalid argument passed - expected %2 - got %3", _fncName, typename (_argsRequired select _i), typename (_argsSupplied select _i)] call BIS_fnc_error;
			diag_log text format ["%1 - Invalid argument passed - expected %2 - got %3", _fncName, typename (_argsRequired select _i), typename (_argsSupplied select _i)];
		};
	};
};

//#endif