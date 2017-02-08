
_heli = _this;
_crew = crew _heli;

titleText ["", "BLACK FADED", 1];

{
	_x allowDamage false;
	moveOut _x;
	//_x setpos [getpos _x select 0, getpos _x select 1, 0];
	_x setBehaviour "COMBAT";
} foreach _crew;

// wait until the chopper is not moving
waitUntil
{
	vector = velocity _heli;
	(vector select 0) == 0 && (vector select 1) == 0 && (vector select 2) == 0;
};

sleep 2;

_pos = getpos _heli;
//deleteVehicle _heli;

//_wreck = createVehicle ["Land_Wreck_Heli_Attack_02_F", _pos, [], 0, "CAN_COLLIDE"];

{ _x allowDamage true; } foreach _crew;

titleText ["", "BLACK IN", 4];

player playMove "AmovPpneMstpSrasWrflDnon_AmovPknlMstpSrasWrflDnon";

[_pos, getMarkerPos "BASE", _crew, MISSION_PLAYERDOWN_DESC] execVM "create_playerDown_mission.sqf";




