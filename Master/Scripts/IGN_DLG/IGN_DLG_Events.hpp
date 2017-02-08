// Author: Igneous01

// ************************** Binding Events *******************************

// onBind
// raises when a control or variable has been bound to the other
// sends arguments [bindingVariable, bindingControlIDC, bindType]
// -bindingVariable is fully qualified					(_this select 0)
// -bindingControlIDC is the control idc number			(_this select 1)
// -bindType is either -1 (no bind), 0 (one-way-bind-control), 1 (one-way-bind-variable), 2 (two-way-bind)	(_this select 2)
[["", 0, 0], "IGN_Event_onBind"] call IGN_fnc_createEventLocal;

// onBindValueChanged
// raises when the value of a bindingVariable/Control has changed
// sends arguments [bindingVariable, newValue, bindType]
// -bindingVariable is fully qualified	(_this select 0)
// -newValue : the new value (any type)	(_this select 1)
// -bindType is either -1 (no bind), 0 (one-way-bind-control), 1 (one-way-bind-variable), 2 (two-way-bind)	(_this select 2)
[[""], "IGN_Event_onBindValueChanged"] call IGN_fnc_createEventLocal;




// ************************** Control Events *******************************
{
	[[], _x] call IGN_fnc_createEventLocal;
} foreach
[
	"IGN_Event_onButtonClick",
	"IGN_Event_onButtonDown",
	"IGN_Event_onButtonUp",
	"IGN_Event_onMouseEnter",
	"IGN_Event_onMouseExit",
	"IGN_Event_onSetFocus",
	"IGN_Event_onKillFocus",
	"IGN_Event_onTimer",
	"IGN_Event_onLBDrop",
	"IGN_Event_onKeyDown",
	"IGN_Event_onKeyUp",
	"IGN_Event_onChar",
	"IGN_Event_onMouseButtonDown",
	"IGN_Event_onMouseButtonUp",
	"IGN_Event_onMouseButtonClick",
	"IGN_Event_onMouseButtonDblClick",
	"IGN_Event_onMouseMoving",
	"IGN_Event_onMouseHolding",
	"IGN_Event_onMouseZChanged",
	"IGN_Event_onCanDestroy",
	"IGN_Event_onDestroy",
	"IGN_Event_onLBSelChanged",
	"IGN_Event_onLBListSelChanged",
	"IGN_Event_onLBDblClick",
	"IGN_Event_onLBDrag",
	"IGN_Event_onLBDragging",
	"IGN_Event_onCheckBoxesSelChanged",
	"IGN_Event_onSliderPosChanged",
	"IGN_Event_onObjectMoved",
	"IGN_Event_onVideoStopped",
	"IGN_Event_onIMEChar",
	"IGN_Event_onIMEComposition",
	"IGN_Event_onJoystickButton"
];




// ************************** Display Events *******************************
[[], "IGN_Event_onLoad"] call IGN_fnc_createEventLocal;
[[], "IGN_Event_onUnload"] call IGN_fnc_createEventLocal;