/*
* EF_fnc_isVehicleDisabledInCollection
* Tests to see if a vehicle is disabled or dead in a collection of vehicles
* aVehicleIsDisabled = vehicles call EF_fnc_isVehicleDisabledInCollection;
* vehicles: array of objects that is of vehicle type
* Returns: Boolean - true if a vehicle is disabled or dead, false if not
* If array is null or empty, returns false
*/
private ["_vehicles", "_res"];
_vehicles = [
				_this,
				[],
				[
					[]
				]
			] call fnc_SingleParam; // if _myArg is not of type array, default to empty array
if (count _vehicles == 0) exitWith {false;};

_res = false;
{
	if (_x call Efnc_isVehicleDisabledOrDead) exitWith
	{
		_res = true;
	};
} foreach _vehicles;
_res;