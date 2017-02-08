
_smokeLoc = _this;



_hour = daytime;
if (_hour > 5 && _hour < 19) then
{
	_smoke= "SmokeShellGreen" createVehicle  _smokeLoc;
	sleep 80;	// needs to be tweaked later *************
	deleteVehicle _smoke;
}
else
{
	_chemlight= "Chemlight_green" createVehicle  _smokeLoc;
	_smoke= "SmokeShellGreen" createVehicle  _smokeLoc;
	sleep 80;
	deleteVehicle _chemlight;
	deleteVehicle _smoke;
};
