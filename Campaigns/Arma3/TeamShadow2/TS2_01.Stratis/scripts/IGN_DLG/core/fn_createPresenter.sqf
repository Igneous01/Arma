
#include "IGN_Macros.h"

/*
Presenter
mediates between view (control/dialog) and model (data user inputted)


Presenter(controlID, model, howUpdateControl, howUpdateModel)

//ie.
[COMBOBOX, myModel,
    {
        {
            lbAdd[COMBOBOX, _x];
        } foreach _model;
    },
    {
        private _data = [];
        _data resize (lbSize COMBOBOX);
        for [{_i = 0}, {_i < (lbSize COMBOBOX) - 1}, {_i = _i + 1}] do
        {
            _data pushback lbValue [COMBOBOX, _i];
        };
        _model = _data;
    }
] call Presenter;
*/



    params["_ctrlID", "_displayID", "_model"];
    private _getCtrlFnc = param [3,
    {
        [_ctrlID, _displayID] call IGN_fnc_getCtrlData;
    }, [{}] ];
    private _updateCtrlFnc = param [4,
    {
        [_ctrlID, _displayID, _this] call IGN_fnc_setCtrlData;
    }, [{}] ];
    private _updateModelfnc = param [5,
    {
        _this = [_ctrlID, _displayID] call IGN_fnc_getCtrlData;
        _this;
    }, [{}]];

    ["onEachFrameID", "onEachFrame",
    {
        params["_ctrlID", "_model", "_updateCtrl", "_updateModel"];

        // get control value
        if (call _getCtrlFnc != _model) then
        {

        };
        // if model changed
        _model call _updateCtrl;

        // if control changed
        _model = _model call _updateModel;

    }, _this] call BIS_fnc_addStackedEventHandler;
