//#ifndef __IGN_LIB_FUNCTOR_HEADER__
//#define __IGN_LIB_FUNCTOR_HEADER__

// Author: Igneous01
// Functor header file




/*
	createFunctor
	Creates a new functor object
	arguments passed cannot be temporary values - they must be references to existing objects/tasks/groups/etc...

	Parameters
	function (code) - the code the functor will call
	arguments (*anything) - the arguments the functor will pass to the function (Must be References!!)

	Returns
	Functor object, with these attributes
	"IGN_FUNCTOR_TYPE"	- type identifier
	"function" 			- code
	"arguments"			- array of pointers to original arguments (if any)

	Example
	myFunctor = [
	{
		private ["_unit"];
		_unit = _this;
		_unit setUnitPos "MIDDLE";
	}, _myUnit] call IGN_fnc_createFunctor;		// notice that _myUnit is local - this means you can call myFunctor outside of 
											// the script and it will still reference _myUnit

	// In the above example, myFunctor passes one argument (_myUnit) and will return nothing

	Example
	myFunctor = [
	{
		private ["_units"];
		_units = _this;
		{ _x setUnitPos "MIDDLE"; } foreach _units;
		true;
	}, [_myUnit1, myUnit2]] call IGN_fnc_createFunctor;

	// This time, myFunctor	passes two arguments (local _myUnit and global myUnit2) and will return true upon completion
*/
IGN_fnc_createFunctor = 
{
	private ["_code", "_args", "_obj"];
	_code = [_this, 0, {}, [{}]] call BIS_fnc_param;
	_args = [_this, 1] call BIS_fnc_param;

	//if (typename _args != typename []) then {_args = [_args];};	// convert to array

	_obj = createVehicle ["Land_HelipadEmpty_F", [0,0,0], [], 0, "NONE"];

	_obj setVariable ["IGN_FUNCTOR_TYPE", 0];	// type identifier
	_obj setVariable ["function", _code];

/*
	// create pointers to arguments
	_ptr_args = [];
	{
		_ptr_args set [count _ptr_args, _x call fnc_CreatePointer];
	} foreach _args;
*/

	_obj setVariable ["arguments", _args];
	_obj;	// return functor
};





/*
	deleteFunctor
	Deletes an existing functor, as well as all of its pointers

	Parameters
	functor (object) - the functor to be deleted

	Returns
	nothing

	Example
	myFunctor call IGN_fnc_deleteFunctor;
	[myFunctor] call IGN_fnc_deleteFunctor;
*/
IGN_fnc_deleteFunctor =
{
	private ["_functor"];
	_functor = _this;
	if (typename _functor == typename []) then {_functor = _this select 0;};

	// validateFunctor
	#ifdef IGN_LIB_DEBUG
	[_functor, "IGN_fnc_deleteFunctor"] call IGN_fnc_validateFunctor;
	#endif
/*
	// delete all pointers
	{
		_x call fnc_DeletePointer;
	} foreach (_functor getVariable "arguments");
*/
	deleteVehicle _functor;
};





/*
	callFunctor
	Calls the functors code, passing in the stored arguments
	Arguments are dereferenced upon call

	Parameters
	functor (object) - the Functor to call

	Returns
	anything (function) - If the specified code returns a value(s), this will return that value(s)
	
	Example
	myResult = myFunctor call IGN_fnc_callFunctor;
	[myResult] = myFunctor call IGN_fnc_callFunctor;
*/
IGN_fnc_callFunctor = 
{
	private ["_functor"];
	_functor = _this;
	if (typename _functor == typename []) then {_functor = _this select 0;};

	// validateFunctor
	#ifdef IGN_LIB_DEBUG
	[_functor, "IGN_fnc_callFunctor"] call IGN_fnc_validateFunctor;
	#endif

	// CONFIRM THAT set DOESN'T COPY VALUES

	(_functor getVariable "arguments") call (_functor getVariable "function");
};







// INTERNAL - NOT RECOMMENDED FOR USE !
// Checks if object is functor
IGN_fnc_isFunctor =
{
	[_this, "IGN_FUNCTOR_TYPE"] call IGN_fnc_is;
};

// validates functor, if failed, Error and RPT log
IGN_fnc_validateFunctor =
{
	private ["_functor", "_fncName"];
	_functor = _this select 0;
	_fncName = _this select 1;
	if (!(_functor call IGN_fnc_isFunctor)) then
	{
		[_functor, "Functor", _fncName] call IGN_fnc_errorAndLogRPT;
	};
};


//#endif