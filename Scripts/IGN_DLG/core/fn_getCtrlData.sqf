// gets data from a control. The nature of this data is determined by the type of control
// ie. a combobox will return an array, a textBox will return a string, a checkbox will return a bool, etc
#include "IGN_Macros.h"

    params["_ctrlID", "_displayID"];
    // get the ctrl style
    private _ctrl = [_ctrlID, _displayID] call IGN_fnc_convertCtrl;
    private _style = ctrlType _ctrl;
    private _data = "";

    switch (_style) do
    {
        case CT_COMBO; case CT_LISTBOX:
        {
            _data = [];
            _data resize (lbSize _ctrlID);
            for [{_i = 0}, {_i < (lbSize _ctrlID)}, {_i = _i + 1}] do
            {
                _data set [_i, (lbText [_ctrlID, _i])];
            };
        };
        case CT_LISTNBOX:
        {
            _data = nil;
            // not implemented for the time being
        };
        // textbox
        case CT_EDIT; case CT_STATIC; case CT_BUTTON; case CT_ACTIVETEXT; case CT_SHORTCUTBUTTON:
        {
            _data = ctrlText _ctrlID;
        };
        case CT_CONTEXT_MENU:
        {
            _data = nil;
            // not implemented for the time being
        };
        case CT_CHECKBOXES: { _data = ctrlChecked _ctrl; };
        case CT_CHECKBOX: { _data = cbChecked _ctrl; };
        case CT_SLIDER: { _data = sliderPosition _ctrlID; };
        case CT_PROGRESS: {_data = progressPosition _ctrl;};
        case CT_HTML: { _data = nil;
            // not implemented for the time being
        };
        default {_data = nil;};
    };
    _data;