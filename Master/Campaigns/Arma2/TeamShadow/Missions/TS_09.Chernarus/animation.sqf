//////////////////////////////////////////////////////////////////
// Animation Script
// 
//////////////////////////////////////////////////////////////////
private ["_unit", "_anim", "_Hhandler"];
_unit = _this select 0;
_anim = _this select 1;
_Hhandler = _unit addeventhandler ["hit", {
	private ["_unit"];
	_unit = _this select 0;
	_unit setBehaviour "DANGER";
}];

sleep (random 5);
	
while {behaviour _unit != "DANGER" && alive _unit} do {
      _unit playMove _anim;
      waitUntil {(animationState _unit != _anim) || !alive _unit || behaviour _unit == "DANGER"};
	sleep 0.125;
};

_unit switchmove "";