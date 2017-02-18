// check if fired near then leave area
// check if meeting done then leave area

// disabling animations
hvt PlayMoveNow "AmovPercMstpSlowWrflDnon"; 
hvt switchmove ""; 
bossman PlayMoveNow "AmovPercMstpSlowWrflDnon"; 
bossman switchmove ""; 

// set attributes for groups
{_x setbehaviour "AWARE"; _x enableai "MOVE"} foreach bossppl;   
{_x setbehaviour "AWARE"; _x enableai "MOVE"} foreach hvtppl;

// tell the groups to get in their vehicles
bossppl ordergetin true;
hvtppl ordergetin true;

// check to see if everyone is either in a vehicle or dead then execute rest of code
waitUntil {bg1 in suv or !alive bg1 && bg2 in suv or !alive bg2 && bg_driver in suv or !alive bg_driver && hvt in suv or !alive hvt};
hvtppl domove (getmarkerpos "suvspawn");
hvtgroup setspeedMode "FULL";
waitUntil {bbg1 in volx or !alive bbg1 && bbg2 in volx or !alive bbg2 && bossman in volx or !alive bossman}; 

// order the groups to get away
bossppl domove (getmarkerpos "bossleavemarker");

bossgroup setSpeedMode "FULL";
