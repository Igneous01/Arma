// check if fired near then leave area
// check if meeting done then leave area

{_x setbehaviour "AWARE";_x enableai "MOVE"; if (_x in volx) then {} 
else {bossppl ordergetin true}} 
foreach bossppl; 
bossgroup setSpeedMode "FULL"; 
waitUntil {{_x in volx or _x !alive} foreach bossppl}; 
bossppl domove getmarkerpos "bossleavemarker"