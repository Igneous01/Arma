donepractice = true;
player removeaction finishpractice;

{deletevehicle _x} foreach [t, t_1, t_2, t_3, t_4, t_5, t_6, t_7, t_8, t_9, t_10, t_11, t_12, t_13, t_14, t_15, t_16, t_17, t_18, t_19, t_20, t_21];

titletext ["You will be faced with a series of tests that will judge you based on your accuracy, and number of targets hit. In order to pass you will need to have a score of atleast 300 overall.", "PLAIN DOWN", 2];
sleep 10;

Test1Countdown = [20, "Get Ready:", "Start"] execVM "Timer.sqf";
titletext ["Time Attack: 10 targets will spawn at various ranges within a 400m diameter and you will have exactly 60 seconds to get a hit on as many of them as you can. Accuracy is measured here, so only the first 10 shots you make are counted. Each hit on target is 10 points", "PLAIN DOWN", 2];

waituntil {scriptDone Test1Countdown};

_testspawn = ExecVM "Test.sqf";