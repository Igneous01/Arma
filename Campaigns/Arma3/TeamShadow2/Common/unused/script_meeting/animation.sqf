//////////////////////////////////////////////////////////////////
// Animation Script
// 
//////////////////////////////////////////////////////////////////
private ["_unit", "_anim"];
_unit = _this select 0;
_anim = _this select 1;
while{(_unit getVariable "status") == 1} do {
      _unit playMove _anim;
      waitUntil {animationState _unit != _anim};
	sleep 0.125;
};
