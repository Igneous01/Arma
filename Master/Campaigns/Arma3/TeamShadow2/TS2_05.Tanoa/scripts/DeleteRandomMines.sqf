TripWireMinesDeleteArray = [];
{
 if (20 call EF_fnc_chance) then
 {
  TripWireMinesDeleteArray set [count TripWireMinesDeleteArray, _x];
 };
} foreach allmines;

diag_log text format["TS: TS_05: %1 mines were removed from %2 total", count TripWireMinesDeleteArray, count allmines];

{deleteVehicle _x} foreach TripWireMinesDeleteArray;


TripWireMinesDeleteArray = nil;