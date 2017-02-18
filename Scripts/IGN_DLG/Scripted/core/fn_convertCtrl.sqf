#include "IGN_Macros.h"
// either returns IDC of control when control type is passed in as parameter, or returns control type of the specified control IDC

    private _ctrl = param [0, 0, [0, controlNull]]; // default to 0, look for type number (control IDC) or control
    private _display = param [1, 0, [0, displayNull]]; // default to 0, support IDD and Display types
    private _ret = 0;
    if (typename _ctrl == "CONTROL") then { _ret = ctrlIDC _ctrl; }
    else
    {
        if (typename _display == "DISPLAY") then { _ret = _display displayCtrl _ctrl; }
        else { _ret = (findDisplay _display) displayCtrl _ctrl; };
    };
    _ret;
