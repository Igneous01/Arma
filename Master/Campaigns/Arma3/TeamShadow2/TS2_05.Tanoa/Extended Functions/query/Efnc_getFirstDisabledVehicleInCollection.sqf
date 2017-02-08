/*
* Efnc_GetFirstDisabledVehicleInCollection
* gets the vehicle that is disabled or dead in a collection of vehicles
* DisabledVehicle = vehicles call Efnc_isVehicleDisabledOrDead;
* vehicles: array of objects that is of vehicle type
* Returns: object - disabled vehicle, or objNull
* If array is null or empty, returns objNull
*/
private ["_veh", "_vehicles", "_res"];
_vehicles = [
				_this,
				[],
				[
					[]
				]
			] call fnc_SingleParam; // if _myArg is not of type array, default to empty array
if (count _vehicles == 0) exitWith {objNull;};

_veh = objNull;
{
	_res = _x call Efnc_isVehicleDisabledOrDead;
	if (_res) exitWith
	{
		_veh = _x;
	};
} foreach _vehicles;
_veh;