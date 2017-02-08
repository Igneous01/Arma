//Scriptcall: targetRange = [[[Unit1, Limit], [Unit2, Limit], [Unit3, Limit]], [Target1, Target2, Target3]] execVM "shotcountnewer.sqf"
//targetRange = [[[Unit1, Limit]], [Target1, Target2, Target3]] execVM "scriptname.sqf"


endaccuracycheck = 0;
private ["_unitarray", "_targets"];
_unitarray = _this select 0;
_targets = _this select 1;

//Preparing variables as needed
{
	_unit = _x select 0;
	_unit setVariable ["ShotsTaken", 0];
	_unit setVariable ["maxShots", (_x select 1)];
	_unit setVariable ["hits", 0];
      Test1Max = _unit getVariable "maxShots"
} foreach _unitarray;

//creating a little function to count fired shots from primary weapon
if (isnil "IGN_fnc_shotcounter") then {
	IGN_fnc_shotcounter = {
		private ["_unit", "_weapon"];
		_unit = _this select 0;
		_weapon = _this select 1;
		if (_weapon == (primaryweapon _unit)) then {
			_unit setVariable ["ShotsTaken", (_unit getVariable "ShotsTaken") + 1];
			waituntil {!alive (_this select 6)};
			if ((_unit getVariable "ShotsTaken") < (_unit getVariable "maxShots")) then {
				
			} else {
				sleep 0.1;
				
Test1Hits = _unit getVariable "hits";				 
endaccuracycheck = 1;
                        _unit setVariable ["ShotsTaken", 0];
				_unit setVariable ["hits", 0];
                       
			};
		};
	};
};

if (isnil "IGN_fnv_targetHit") then {
	IGN_fnv_targetHit = {
		_tester = (_this select 1) getVariable "hits";
		if (!isnil "_tester") then {
			(_this select 1) setVariable ["hits", ((_this select 1) getVariable "hits") + 1];
		};
	};
};

//Adding eventHandler to the unit.
{IGN_firedEH = (_x select 0) addEventHandler ["fired", {_this spawn IGN_fnc_shotcounter}];} foreach _unitarray;

{IGN_hitEH = _x addEventHandler ["hit", {_this call IGN_fnv_targetHit}];} foreach _targets;


while {endaccuracycheck == 0} do
{
sleep 0.15;
};

player removeeventhandler ["fired", IGN_firedEH];
{_x removeAllEventHandlers "hit"} foreach _targets;

