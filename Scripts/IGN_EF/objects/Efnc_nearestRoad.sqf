/*
* Efnc_nearestRoad
* returns (if any) nearest road relative to specified position, objNull is returned if none found
* closestRoad = [position, radius] call Efnc_nearestRoad
* position: array - format position 
* radius: number - maximum distance to search
* Returns: nearest road object, objNull if none found
* Example: road = [getpos player, 50] call Efnc_nearestRoad
*/

private ["_roads", "_closestRoad", "_pos", "_dist", "_radius"];
_pos = _this select 0;
_radius = _this select 1;
_roads = _pos nearRoads _radius;
_dist = _radius;
if (count _roads > 0) then {	
	{
		if (_x distance _pos < _dist) then {
			_dist = _x distance _pos;
			_closestRoad = _x;
		};
	} foreach _roads;
	_closestRoad;
}
else
{
	objNull;
};
