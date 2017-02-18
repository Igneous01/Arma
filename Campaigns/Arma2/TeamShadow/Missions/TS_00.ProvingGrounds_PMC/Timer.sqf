//nul = [951, "Reinforcements arrive:", "Reinforcements arriving..."] execVM "Timer.sqf"

private ["_remaining", "_ref", "_timer", "_msg1", "_msg2"];
_timer = _this select 0;
_msg1 = _this select 1;
_msg2 = _this select 2;
_ref = time;
"glt_timerMsg" addPublicVariableEventHandler {[] call glt_showCountdown};
if (isnil "glt_timeFormat") then {
	glt_timeFormat = {
		private ["_hours", "_minutes", "_seconds"];
		_hours = 0;
		_minutes = 0;
		_seconds = 0;
		_seconds = _this;
		if (_seconds > 59) then {
			_minutes = floor (_seconds / 60);
			_seconds = _seconds - (_minutes * 60);
		};
		if (_minutes > 59) then {
			_hours = floor (_minutes / 60);
			_minutes = _minutes - (_hours * 60);
		};
		if (_seconds < 10) then {
			_seconds = format ["0%1", _seconds];
		};
		if (_minutes < 10) then {
			_minutes = format ["0%1", _minutes];
		};
		[_hours, _minutes, _seconds]
	};
};

if (isnil "glt_showCountdown") then {
	glt_showCountdown = {
		hintsilent glt_TimerMsg;
	};
};

if (isServer) then {
	while {_timer > 0} do {
		_remaining = _timer call glt_timeFormat;
		glt_timerMsg = format ["%1\n\n%2:%3:%4",_msg1, (_remaining select 0), (_remaining select 1), (_remaining select 2)];
		publicVariable "glt_timerMsg";
		if (local player) then {[] call glt_showCountdown};
		_timer = _timer - 1;
		sleep 1;
	};
};
glt_timerMsg = _msg2;
publicVariable "glt_timerMsg";
if (local player) then {[] call glt_showCountdown};