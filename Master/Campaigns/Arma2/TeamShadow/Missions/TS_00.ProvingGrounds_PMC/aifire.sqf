_counter = 0;

sleep 45;

{if (side _x == WEST) then {_x setunitpos "DOWN"}} forEach allunits; 


// make soldiers target the pop ups
m1 reveal pop1;
m1 dowatch pop1;
m1 doTarget pop1;
m2 reveal pop2;
m2 dowatch pop2;
m2 doTarget pop2;
m3 reveal pop3;
m3 dowatch pop3;
m3 doTarget pop3;
m4 reveal pop2;
m4 dowatch pop2;
m4 doTarget pop2;
m5 reveal pop3;
m5 dowatch pop3;
m5 doTarget pop3;
m6 reveal pop4;
m6 dowatch pop4;
m6 doTarget pop4;
m7 reveal pop1;
m7 dowatch pop1;
m7 doTarget pop1; 
m8 reveal pop4;
m8 dowatch pop4;
m8 doTarget pop4;

sleep 3;

{if (side _x == WEST) then {_x disableai "MOVE"}} forEach allunits; 

while {_counter < 100} do
{
m1 action ["useWeapon",m1,m1,0];
sleep (random 3);
m2 action ["useWeapon",m2,m2,0];
sleep (random 4);
m3 action ["useWeapon",m3,m3,0];
sleep (random 2);
m4 action ["useWeapon",m4,m4,0];
sleep (random 3);
m5 action ["useWeapon",m5,m5,0];
sleep (random 1);
m7 action ["useWeapon",m7,m7,0];
sleep (random 0.5);
m6 action ["useWeapon",m6,m6,0];
sleep (random 2);
m8 action ["useWeapon",m8,m8,0];
sleep (random 2.5);
    _counter = _counter + 1;
};