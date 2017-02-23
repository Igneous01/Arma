#include "IGN_Macros.h"

    params["_ctrlID", "_displayID", "_data"];
    private _ctrl = _ctrlID;    // default assign

    if (typename _ctrlID isEqualTo typename 0) then
    {
        _ctrl = [_ctrlID, _displayID] call IGN_fnc_convertCtrl;
    };
    private _style = ctrlType _ctrl;

    switch (_style) do
    {
        case CT_COMBO; case CT_LISTBOX:
        {
            lbClear _ctrlID;
            if (typename _data == typename []) then
            {
                {
                    lbAdd [_ctrlID, _x];
                } forEach _data;
            }
            else
            {
                lbAdd [_ctrlID, _data];
            };
        };
        case CT_LISTNBOX:
        {
            // need to clear existing content
            {
                lnbAddRow[_ctrlID, _x];
            } forEach _data;
        };
        // textbox
        case CT_EDIT; case CT_STATIC; case CT_BUTTON; case CT_ACTIVETEXT; case CT_SHORTCUTBUTTON:
        {
            ctrlSetText [_ctrlID, _data];
        };
        case CT_CONTEXT_MENU:
        {
            // not implemented for the time being
        };
        case CT_CHECKBOXES: { _ctrl ctrlSetChecked _data; };
        case CT_CHECKBOX: { _ctrl cbSetChecked _data; };
        case CT_SLIDER: { sliderSetPosition [_ctrlID, _data]; };
        case CT_PROGRESS: { _ctrl progressSetPosition _data; };
        case CT_HTML: {
            // not implemented for the time being
        };
        default {};
    }