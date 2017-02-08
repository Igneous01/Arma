/*
* Efnc_getPosAtAngle
* returns a new position that is distance r away from original point at angle theta
* can find a position at the edge of a circle
* pos = [position, radius, angle] call Efnc_getPosAtAngle
* position - Object/Marker/Array - reference position
* radius: Number - radius/distance
* angle: Number - angle in degrees
* returns: position 
* This function is overloaded, and supports markers, objects, and positions
* Example: _pos = [tank, 50, 45] call Fnc_GetPosAtAngle; - new position is 50 metres away from tank at NorthEast
*/

private ["_r", "_theta", "_refPos", "_rx", "_ry", "_x", "_y", "_pos"];
_refPos = _this select 0;
_r = _this select 1;
_theta = _this select 2;
switch (typeName _refPos) do {
	case "OBJECT":
	{
		_refPos = getpos _refPos;
	};
	case "STRING":
	{
		_refPos = getMarkerPos _refPos;
	};
	case "ARRAY":
	{
	};
	default
	{
		diag_log text "Efnc_getPosAtAngle - unknown data type given";
	};
};

_rx = _refPos select 0;
_ry = _refPos select 1;

//diag_log text format ["Fnc_GetPosAtAngle: _r = %1, _theta = %2, _rx = _%3, _ry = %4, _thetaRad = %5", _r, _theta, _rx, _ry, _theta * _conversion];

_x = _rx + (_r * cos (- _theta + 90 ) );
_y = _ry + (_r * sin (- _theta + 90 ) );

_pos = [_x, _y];
//diag_log text format ["GP: Fnc_GetPosAtAngle: Result: _theta = %1, _pos = %2, _x = %3, _y = %4", _theta, _pos, _x, _y];
_pos

