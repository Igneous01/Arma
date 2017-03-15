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
#include "IGN_EH_Macros.h"

	private ["_functor"];
	_functor = _this;
	if (typename _functor == typename []) then {_functor = _this select 0;};

	// validateFunctor
	#ifdef IGN_LIB_DEBUG
	[_functor, "IGN_fnc_callFunctor"] call IGN_fnc_validateFunctor;
	#endif

	// CONFIRM THAT set DOESN'T COPY VALUES

	(_functor getVariable "arguments") call (_functor getVariable "function");
