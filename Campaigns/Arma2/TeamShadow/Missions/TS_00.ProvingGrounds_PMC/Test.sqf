test2active = false;
test3active = false;
passtest = 0;


// TEST1
// Spawning in Targets
t1tar1 setpos (getmarkerpos "t1p1");
t1tar2 setpos (getmarkerpos "t1p2");
t1tar3 setpos (getmarkerpos "t1p3");
t1tar4 setpos (getmarkerpos "t1p4");
t1tar5 setpos (getmarkerpos "t1p5");
t1tar6 setpos (getmarkerpos "t1p6");
t1tar7 setpos (getmarkerpos "t1p7");
t1tar8 setpos (getmarkerpos "t1p8");
t1tar9 setpos (getmarkerpos "t1p9");
t1tar10 setpos (getmarkerpos "t1p10");
Test1Timer = [60, "Time Remaining:", "End of Test"] execVM "Timer.sqf";
testRange1 = [[[player1, 10]], [t1tar1, t1tar2, t1tar3, t1tar4, t1tar5, t1tar6, t1tar7, t1tar8, t1tar9, t1tar10]] execVM "Range Test\Test1.sqf";
waitUntil {scriptDone Test1Timer};
terminate testRange1;
// Delete Targets
deleteVehicle t1tar1;
deleteVehicle t1tar2;
deleteVehicle t1tar3;
deleteVehicle t1tar4;
deleteVehicle t1tar5;
deleteVehicle t1tar6;
deleteVehicle t1tar7;
deleteVehicle t1tar8;
deleteVehicle t1tar9;
deleteVehicle t1tar10;
waitUntil {scriptDone testRange1};
// END TEST1

titletext ["Range Qualification: Single target will spawn at various ranges and you will have one shot to hit the target in order to continue. The target will start at a range of 300m, and with each hit will increment by 100m approx. Each hit is 10 points.", "PLAIN DOWN", 2];

//Intermission
Intermission1 = [20, "Get Ready:", "Start"] execVM "Timer.sqf";
waituntil {scriptDone Intermission1};

//Spawn Target
t2tar setpos getmarkerpos "t2p1";
t2help setpos getmarkerpos "t2p1";

// TEST2
passtest = 1;

testRange2 = [player, t2tar] execVM "Range Test\Test2.sqf";
waitUntil {scriptDone testRange2};

titletext ["OSOK: You will be faced with 3 individual targets, each being a complicated shot as the targets are behind cover. You will have just one shot per target. Each hit is 100 points. ", "PLAIN DOWN", 2];

//Intermission
Intermission2 = [20, "Get Ready:", "Start"] execVM "Timer.sqf";
waituntil {scriptDone Intermission2};

hint "First Target";

//Spawn Target
t3tar setpos (getmarkerpos "t3p1");
t3o1 setpos [getmarkerpos "t3p1" select 0, getmarkerpos "t3p1" select 1, -0.5];
t3help setpos (getmarkerpos "t3p1");

// TEST3
testRange3 = [player, t3tar] execVM "Range Test\Test3.sqf";
waitUntil {scriptDone testRange3};


// SCORE CALCULATOR
totalscore = execVM "Range Test\RangeScore.sqf";
waitUntil {scriptDone totalscore};


sleep 3;


if (OverallScore >= 300) then {
	obj1 settaskstate "SUCCEEDED";
	obj1hint = [objNull, ObjNull, obj1, "SUCCEEDED"] execVM "CA\Modules\MP\data\scriptCommands\taskHint.sqf";
	sleep 5;
	endMission "END1";} 
	else 
	{
	obj1 settaskstate "FAILED";
	obj1hint = [objNull, ObjNull, obj1, "FAILED"] execVM "CA\Modules\MP\data\scriptCommands\taskHint.sqf";
	sleep 5; failMission "LOSER";
}


