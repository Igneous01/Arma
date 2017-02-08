private ["_timer"];
_timer = _this select 0;

while {_timer > 0} do {
	sleep 1;
	_timer = _timer - 1;
	hint format ["hold for: %1 seconds.", _timer];
};