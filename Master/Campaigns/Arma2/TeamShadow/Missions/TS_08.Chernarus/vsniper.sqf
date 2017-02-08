
private ["_target","_vsnipr","_aimhgt","_muzhgt","_prjctl","_muzvel","_dx","_dy","_dis","_ang","_z1","_z2","_z","_elev","_vel","_bullet"];

_target = _this select 0;
_vsnipr = _this select 1;
_aimhgt = if (count _this > 2) then {_this select 2} else {1.75};
_muzhgt = if (count _this > 3) then {_this select 3} else {1};	//default muzzle height 0.5m
_prjctl = if (count _this > 4) then {_this select 4} else {"B_127x107_Ball"};	//default aim height above ground level 1.70m (chest height)
_muzvel = if (count _this > 5) then {_this select 5} else {1000};	//default muzzle velocity of 1200m/sec;

// Distance calculation
_dx = ((getpos _target) select 0) - ((getpos _vsnipr) select 0);
_dy = ((getpos _target) select 1) - ((getpos _vsnipr) select 1);

_dis = sqrt(_dx^2+_dy^2);
_ang = _dx atan2 _dy;

_z1 = (getPosASL _target select 2) + _aimhgt;
_z2 = (getPosASL _vsnipr select 2) + _muzhgt;
_z = _z1 - _z2;

_elev = ((atan (_z/_dis)) mod 360);

_vel = [(_muzvel * (sin _ang)),(_muzvel * (cos _ang)),_muzvel * sin (_elev)];

_bullet = _prjctl createVehicle [((getpos _vsnipr) select 0),((getpos _vsnipr) select 1),_muzhgt];
_bullet setVelocity _vel;

//un-comment the next two lines if you have a gunshot sound defined in your description.ext
//sleep (_dis/320);

