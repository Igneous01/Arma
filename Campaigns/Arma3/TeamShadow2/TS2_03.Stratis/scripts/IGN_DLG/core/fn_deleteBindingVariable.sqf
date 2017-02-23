#include "IGN_Macros.h"
// _this - unqualified variable name

	#ifdef IGN_LIB_DEBUG
	[_this, "IGN_fnc_deleteBindingVariable"] call IGN_fnc_validBindingVariable;
	#endif
	missionNamespace setVariable [_this call IGN_fnc_expandTokenName, nil];