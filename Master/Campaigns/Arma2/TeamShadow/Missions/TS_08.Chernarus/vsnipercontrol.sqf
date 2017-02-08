//////////////////////////////////////////////////////////////////
// Function file for Armed Assault
// Created by: TODO: Author Name
//////////////////////////////////////////////////////////////////

private ["_target"];

waituntil {count vsniper_targets >=1};

_target  = vsniper_targets select 0;

//keep firing till the guy is dead.
while {alive _target && alive vsniper} do {
	vsniper dowatch _target;
	sleep 1;
	vsniper dotarget _target;
	sleep 5;
	vsniper action ["UseWeapon", vsniper, vsniper, 0];
	sleep 0.5; 
	nul = [_target,vsniper,1,0.5,"B_127x108_Ball",1000] execVM "vsniper.sqf";
	sleep 15 + random 30;		//how often the sniper fires.
};

if (alive vsniper) then {
sleep 5 + random 5;		//wait some time before we run the script again
nul = [] execVM "vsnipercontrol.sqf";
};

hint "vsniper is dead";