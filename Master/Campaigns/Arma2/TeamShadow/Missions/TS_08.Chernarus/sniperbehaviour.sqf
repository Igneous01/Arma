private ["_sniper", "_Vsniperhandle", "_sniperheight", "_Fsniperheight", "_Fspotterheight"];
_sniper = _this select 0;
_sniperheight = getposasl _sniper select 2;
hint "scriptrunning";

while {alive _sniper} do {
    // Check if sniper has detected an enemy unit
    if (_sniper knowsabout sniper > 0.05) then {
        hint "Sniper Spotted"; 
        _Fsniperheight = getposasl sniper select 2;
        if (unitPos sniper == "DOWN") then {
            player sidechat "sniper is prone";
            _sniper action ["UseWeapon", _sniper, _sniper, 0]; 
            _Vsniperhandle = [sniper, _sniper, 0.3, 1, "B_127x107_Ball", 1000] execVM "vsniper.sqf";
        } else {
            _sniper action ["UseWeapon", _sniper, _sniper, 0]; 
            _Vsniperhandle = [sniper, _sniper, 1.6, 1, "B_127x107_Ball", 1000] execVM "vsniper.sqf";
        };
    };
    if (_sniper knowsabout spotter > 0.05) then {
        hint "Spotter Spotted"; 
        if (unitPos spotter == "DOWN") then {
            player sidechat "spotter is prone";
            _sniper action ["UseWeapon", _sniper, _sniper, 0]; 
            _Vsniperhandle = [sniper, _sniper, 0.3, 1, "B_127x107_Ball", 1000] execVM "vsniper.sqf";
        } else {
            _sniper action ["UseWeapon", _sniper, _sniper, 0]; 
            _Vsniperhandle = [sniper, _sniper, 1.6, 1, "B_127x107_Ball", 1000] execVM "vsniper.sqf";
    };
    sleep (random 30);
};