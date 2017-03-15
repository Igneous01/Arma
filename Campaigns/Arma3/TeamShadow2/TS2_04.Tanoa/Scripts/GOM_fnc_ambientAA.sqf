

params [["_guns",[]],["_duration",1],["_positions",[]],["_spread",300]];

_debug = true;

GOM_fnc_abortAA = false;
publicVariable "GOM_fnc_abortAA";

GOM_fnc_abortAmbientAA = {

    GOM_fnc_abortAA = true;
    publicVariable "GOM_fnc_abortAA";
    true

};

_getmode = [0,1,2,3];
_denial = [false,false,false,true];

if (_guns isEqualTo []) exitwith {systemchat "You need to specify AA guns."};
if (_positions isEqualTo []) then {_positions = [(_guns select 0) getrelpos [random [250,500,1000], random 360]]};

_text = format ["Starting AA fire for %1 minutes.",_duration];
if (_debug) then {systemchat _text;systemchat str _this};


sleep 2;
_fireAtPosition = {

    params ["_gun","_guns","_position","_speed","_movedir","_inittime","_mode","_denial","_overridePos","_spread","_debug"];
    _position params ["","","_alt"];

    _rndsleep = random [2,4,6];
    _weapon = (_gun weaponsTurret [0] select 0);
    _watchpos = _position;



    _shotsleepsArray = [0.3,-1,-1,0.7];
    _salvoSleepsArray = [ [5,6,7], [2,4,5], [1,1.5,2],[2,3,4]];
    _roundsArray = [[8,10,12],[5,10,20],[10,15,20],[2,3,6]];
    _salvoesArray = [3,round random [3,4,6],round random [5,10,20],4];

    _rounds = _roundsArray select _mode;
    _salvoSleep = _salvoSleepsArray select _mode;
    _salvoes = _salvoesArray select _mode;
    _shotsleep = _shotsleepsArray select _mode;

    _gun setvariable ["GOM_fnc_AAnoLoS",false];

    if (_shotsleep isequalto -1) then {

        _weapon = _gun currentweaponturret (assignedvehiclerole gunner _gun select 1);
        _shotsleep = getNumber (configfile >> "CfgWeapons" >> _weapon >> "reloadTime");
        if (_shotsleep >= 0.5) then {_shotsleep = 0.15};

    };

    _timer = time - _inittime + _rndsleep;
    _distance = _speed * _timer;

    if !(_overridePos) then {

        _watchpos = [_position,_distance,_movedir] call BIS_fnc_relPos;
        _watchpos params ["_wX","_wY"];
        _watchpos = [_wX,_wY,_alt];

    };

    if (_denial) then {

        _watchpos = _position;
        _watchpos = _watchpos vectoradd [random 250,random 250,random 250];

    };


    if (_overridePos) then {

        _watchpos = _position;
        _watchpos = _watchpos vectoradd [random [0,_spread,_spread * 2],random [0,_spread,_spread * 2],random [0,_spread,_spread * 2]];

    };

    gunner _gun dowatch _watchpos;

    _resync = time;
    waituntil {_olddir = gunner _gun weapondirection currentweapon gunner _gun;sleep 0.1; gunner _gun weapondirection currentweapon gunner _gun isequalto _olddir};


    _gunGunEnd = getText (configfile >> "CfgVehicles" >> (typeOf _gun) >> "Turrets" >> "MainTurret" >> "gunEnd");

    sleep _rndsleep;

    _nolos = false;

    for "_s" from 1 to _salvoes do {

    if (!alive _gun or !canFire _gun) exitWith {true};
    if (GOM_fnc_abortAA) exitWith {if (_debug) then {systemchat "Aborting AA!";true}};
    if ({_x getvariable ["GOM_fnc_AAnoLoS",false]} count _guns > count _guns / 2) exitWith {if (_debug) then {systemchat "More than half of AA battery have no LoS, aborting."};true};
        _gunpos     = ATLtoASL (_gun modeltoworld (_gun selectionposition _gunGunEnd));

        _gun setVehicleAmmo 1;


        _intersect = lineIntersectsSurfaces [_gunpos, ATLtoASL _watchpos,_gun];
        _nointersect = _intersect isequalto [];
        if (!_nointersect) exitwith {if (_debug) then {gunner _gun sidechat "Can't fire, no line of sight!"};_nolos =true};

            for "_r" from 1 to round random _rounds do {

            if (!alive _gun or !canFire _gun) exitWith {true};
            if (GOM_fnc_abortAA) exitWith {if (_debug) then {systemchat "Aborting AA!";true}};



            _timer = time - _inittime + _shotsleep;
            _distance = _speed * _timer;

            if !(_denial) then {

                _watchpos = [_position,_distance,_movedir] call BIS_fnc_relPos;
                _watchpos params ["_wX","_wY"];
                _watchpos = [_wX,_wY,_alt];

            };

            if (_overridePos) then {

                _watchpos = _position;

            };



            gunner _gun dowatch _watchpos;
            _gun setvariable ["GOM_fnc_ambientAAtarget",_watchpos];

            _gunpos     = ATLtoASL (_gun modeltoworld (_gun selectionposition _gunGunEnd));
            _intersect = lineIntersectsSurfaces [_gunpos, ATLtoASL _watchpos,_gun];
            _nointersect = _intersect isequalto [];
            sleep _shotsleep;



                if (_nointersect) then {
                    _gun fire (_gun weaponsTurret [0] select 0);
                };

            };

            _sleep = random _salvoSleep;
            _timer = time - _inittime + _sleep;
            _distance = _speed * _timer;

            if !(_denial) then {

                _watchpos = [_position,_distance,_movedir] call BIS_fnc_relPos;
                _watchpos params ["_wX","_wY"];
                _watchpos = [_wX,_wY,_alt];

            } else {

                _watchpos = _position;
               _watchpos =  _watchpos vectoradd [random 250,random 250,random 250];

            };

    if (_overridePos) then {

        _watchpos = _position;
        _watchpos = _watchpos vectoradd [random [0,_spread,_spread * 2],random [0,_spread,_spread * 2],random [0,_spread,_spread * 2]];

    };

            gunner _gun dowatch _watchpos;
            sleep random _sleep;
            _watchpos = _position;

    };

    if (_nolos) exitwith {_gun setvariable ["GOM_fnc_AAnoLoS",true];true};
    if (GOM_fnc_abortAA) exitWith {if (_debug) then {systemchat "Aborting AA!";true}};

    true

};

_sync = time;
_timeout = time + (_duration * 60);

_loopNum = 0;
_break = 0;
while {time < _timeout} do {


    if (GOM_fnc_abortAA) exitWith {if (_debug) then {systemchat "Aborting AA!";true}};

    _loopNum = _loopNum + 1;
    _break = _break + 1;

    _dir = random 360;
    _alt = random [1500,1800,3000] + (getposasl (selectrandom _guns) select 2);
    _dist = random [500,600,1500];

    _position = selectRandom _positions;

    if !(typeName _position isEqualTo "ARRAY") exitWith {systemchat "Positions has to be an array containing positions (ASL)!"};

    if ((ASLToATL _position) select 2 < 50) then {

        _position = _position vectorAdd [0,0,250];

    };

    _getposition = (selectrandom _guns getPos [_dist,_dir]);
    _getposition params ["_pX","_pY"];

    _overridePos = false;
    _getdenial = selectRandom _denial;

    if (_position isEqualTo [0,0,0]) then {

        if (_debug) then {systemchat "Firing at random position.";true};
        _position = [_px,_py,_alt];

    } else {

        _overridePos = true;
        if (_debug) then {systemchat format ["Firing at specfied position: %1 with an average spread of: %2m.",_position,_spread];sleep 3;};
        _getdenial = false;
    };

    _movedir = random 360;
    _speed = round ((random [200,500,800]) / 3.6);
    _mode = selectRandom _getmode;

    _blamblamblam = [];

    {

        _blam = [_x,_guns,_position,_speed,_movedir,_sync,_mode,_getdenial,_overridePos,_spread,_debug] spawn _fireAtPosition;
        _blamblamblam pushback _blam;

    } foreach _guns;
        _modedescr = ["Medium RoF","Fast RoF - Short bursts","Fast RoF - Long bursts","Low RoF - Few rounds"];

        if (_debug) then {

            systemchat format ["Starting loop %1:",_loopNum];
            systemchat format ["Mode %1:",_loopNum];
            systemchat format ["%1.",_modedescr select _mode];

            if (_getdenial) then {systemchat "Aerial Denial."} else {

                if !(_overridePos) then {

                systemchat "Moving target:";
                systemchat format ["Dir: %1 Dist: %2m AGL: %3m.",round _dir,round _dist,round _alt];
                systemchat format ["Target speed: %1km/h - Target heading: %2",round (_speed * 3.6),round _movedir];
            } else {

            systemchat format ["Firing at specified position:%1 Random spread: %2m",_position,_spread];

            };

            };

        };

    waituntil {{scriptdone _x} count _blamblamblam isEqualTo count _blamblamblam};

        if (_debug) then {systemchat format ["Ending loop %1.",_loopNum,_mode]};

            if (_break isequalto 3 AND _duration >= 10) then {
                _rndBreak = round random [10,20,30];
                if (_debug) then {systemchat format ["Break: No fire for %1s.",_rndBreak]};
                sleep _rndBreak;
                _break = 0;
            };

    sleep random [1,2,3];

};

_turretIdles = [];
if (GOM_fnc_abortAA) exitWith {if (_debug) then {systemchat "Aborting AA!";true}};

{

    _idle = [_x] spawn {

        params ["_gun"];
        sleep random [2,4,8];
        gunner _gun dowatch objnull;
        waituntil {_olddir = gunner _gun weapondirection currentweapon gunner _gun;sleep 0.1; gunner _gun weapondirection currentweapon gunner _gun isequalto _olddir;};
        _gun setvariable ["GOM_fnc_AAnoLoS",false];
        true
    };

    _turretIdles pushback _idle;

} foreach _guns;

if (_debug) then {systemchat "Turrets to idle position."};
waituntil {{scriptdone _x} count _turretIdles isEqualTo count _turretIdles};
if (_debug) then {systemchat "Ambient AA fire finished."};
true