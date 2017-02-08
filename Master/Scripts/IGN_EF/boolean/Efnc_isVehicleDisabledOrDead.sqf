/*
* EF_fnc_isVehicleDisabledOrDead
* Tests to see if a vehicle is disabled / dead
* vehicleDisabled = myVehicle call EF_fnc_isVehicleDisabledOrDead;
* myVehicle: object that is of vehicle type
* Returns: Boolean - true if the vehicle is disabled or dead, false if not
* If vehicle is null, returns false
*/
private ["_veh"];
_veh = [_this, objNull, [objNull]] call EF_fnc_singleParam;
if (isNull _veh) exitWith {false;};
if (!alive _veh || !canMove _veh) exitWith { true; };