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
