/*
	IGN_fnc_getBindingVariable
	gets the value of the bindingVariable

	Parameters:
	varName (string) : the bindingVariables name

	Returns:
	the value of the bindingVariable


	Example:
	"myBindingVar" call IGN_fnc_getBindingVariable;
*/
#include "IGN_Macros.h"

	#ifdef IGN_LIB_DEBUG
	[_this, "IGN_fnc_getBindingVariable"] call IGN_fnc_validBindingVariable;
	#endif
	(missionNamespace getVariable (_this call IGN_fnc_expandTokenName)) select 0;