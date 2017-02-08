/*	
	Author: Igneous01
	Pointer Header File


*/

/*
	CreatePointer
	Creates a pointer object to the specified variable/value

	Parameters
	var (anything) - variable that pointer will reference

	Returns
	pointer object

	Example
	myPointer = myValue call fnc_CreatePointer;		// myPointer points to myValue
	myValue = 5;
	myPointer call fnc_GetPointerValue;				// returns 5
	[myPointer, 6] call fnc_SetPointerValue;		
	// myValue is now 6

	Example: Creating a pointer to a local variable in a script
	PointerToLocalVariable = _localVar call fnc_CreatePointer;

	// while current scope exists in script, in the activation of a trigger:
	{
		[PointerToLocalVariable, 87] call fnc_SetPointerValue;	// modifies _localVar
	}

	// later in script
	if (_localVar == 87) then {//...};
*/
fnc_CreatePointer =
{
	private ["_ptrObj"];
	_ptrObj = createVehicle ["Land_HelipadEmpty_F", [0,0,0], [], 0, "NONE"];
	_ptrObj setVariable ["IGN_POINTER_TYPE", 0];
	_ptrObj setVariable ["value", [_this]];
	_ptrObj;	// return pointer object
};





/*
	DeletePointer
	Deletes the specified pointer

	Parameters
	pointer (pointer object) - the pointer to be deleted

	Returns
	nothing

	Example
	myPointer call fnc_DeletePointer;		// myPointer = objNull
	[myPointer] call fnc_DeletePointer;		// myPointer = objNull
*/
fnc_DeletePointer =
{
	private ["_ptr"];
	_ptr = _this;
	if (typename _this == typename []) then {_ptr = _this select 0;};

	#ifdef IGN_LIB_DEBUG
	_ptr call fnc_ValidatePointer;
	#endif

	deleteVehicle _ptr;
};





/*
	GetPointerValue
	Dereferences the pointer, returning the value 

	Parameters
	pointer (pointer object) - the pointer to be dereferenced

	Returns
	anything (value)

	Example
	myVal = myPointer call fnc_GetPointerValue;
	myVal = [myPointer] call fnc_GetPointerValue;
*/
fnc_GetPointerValue =
{
	private ["_ptr"];
	_ptr = _this;
	if (typename _this == typename []) then {_ptr = _this select 0;};

	#ifdef IGN_LIB_DEBUG
	_ptr call fnc_ValidatePointer;
	if (_ptr call fnc_IsPointerNil) then
	{
		["Pointer %1 points to nil value", _ptr] call BIS_fnc_error;
		diag_log text format ["Pointer %1 points to nil value", _ptr];
	};
	#endif

	(_ptr getVariable "value") select 0;	// return value
};





/*
	SetPointerValue
	Modifies the value being pointed to

	Parameters
	pointer (pointer object) - the pointer to be modified
	value (anything) - new value

	Returns
	nothing

	Example
	[myPointer, "newval"] call fnc_SetPointerValue;
*/
fnc_SetPointerValue =
{
	private ["_ptr", "_val"];
	_ptr = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
	_val = [_this, 1, 0] call BIS_fnc_param;

	#ifdef IGN_LIB_DEBUG
	_ptr call fnc_ValidatePointer;
	#endif

	(_ptr getVariable "value") set [0, _val];
	//((_ptr getVariable "value") select 0) = _val;	// set value
};





/*
	SetPointer
	Modifies the pointer to point to another value/variable

	Parameters
	pointer (pointer object) - the pointer to be modified
	variable (anything) - new variable to point to

	Returns
	nothing

	Example
	[myPointer, Var] call fnc_SetPointer;	// myPointer points to Var
	[myPointer, newVar] call fnc_SetPointer;	// myPointer now points to newVar
*/
fnc_SetPointer =
{
	private ["_ptr", "_var"];
	_ptr = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
	_var = [_this, 1] call BIS_fnc_param;

	#ifdef IGN_LIB_DEBUG
	_ptr call fnc_ValidatePointer;
	#endif

	_ptr setVariable ["value", [_var]];
};





/*
	IsPointerNil
	Checks to see if the pointer points to a nil variable

	Parameters
	pointer (pointer object) - the pointer to be checked

	Returns
	true if the pointer points to nothing, false if it points to valid value

	Example
	_isNilPtr = myPointer call IsPointerNil;
	_isNilPtr = [myPointer] call IsPointerNil;
*/
fnc_IsPointerNil =
{
	private ["_ptr", "_result"];
	_result = true;
	_ptr = _this;
	if (typename _this == typename []) then {_ptr = _this select 0;};

	#ifdef IGN_LIB_DEBUG
	_ptr call fnc_ValidatePointer;
	#endif
		
	if (!(isNil{_ptr getVariable "value"})) then {_result = false;};

	_result;
};







// INTERNAL FUNCTIONS - NOT RECOMMENDED FOR USE


// IsPointer
// Determines if the specified object is a pointer object
fnc_IsPointer =
{
	[_this, "IGN_POINTER_TYPE"] call fnc_Is;
};

// ValidatePointer
// Validates the object, if failed, Errors and Logs to RPT
fnc_ValidatePointer = 
{
	if (!(_this call fnc_IsPointer)) exitWith
	{
		[_this, "Pointer"] call fnc_ErrorAndLogRPT;
	};
};