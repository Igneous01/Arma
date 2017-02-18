// Checks if object is the specified type

	private ["_obj", "_type"];
	_obj = _this select 0;
	_type = _this select 1;
	if (isNil {_obj}) exitWith {false};
	if (typename _obj != typename objNull) exitWith {false};
	if (isNull _obj) exitWith {false};
	if (isNil {_obj getVariable _type}) exitWith {false};
	true;
