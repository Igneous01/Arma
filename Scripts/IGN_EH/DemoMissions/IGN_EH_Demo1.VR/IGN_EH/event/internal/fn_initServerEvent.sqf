// Initializes server event (setVariable will be broadcast to all clients)

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
