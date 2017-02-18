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
