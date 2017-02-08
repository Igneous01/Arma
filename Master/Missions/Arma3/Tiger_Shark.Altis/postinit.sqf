// process

// time
skipTime GAME_TIMES;

sleep 0.1;	// required - otherwise this skipTime may have no effect (overwritten by next skipTime maybe?)

// required to recompute cloud cover (ARMA 3)
86400 setOvercast GAME_WEATHER;
skipTime 24;
//

// Forecasted Weather - 1 hour in
3600 setOvercast GAME_FORECAST;

simulWeatherSync;	// synchronizes the necessary cloud cover for the current overcast

// spawn helicopter
private ["_veh"];
_veh = (getMarkerPos "HELI_SPAWN") call fnc_CreateKajmanWithGunner;


player enableSimulation true;
titleText ["", "BLACK IN", 5];

sleep 5;
hintc "Get in your chopper and await further orders...";