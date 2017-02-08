
//Init UPSMON script
call compile preprocessFileLineNumbers "scripts\Init_UPSMON.sqf";

group_Players = group player;
task_KillTarget = "task_KillTarget";
task_Extract = "task_Extract";
mission_complete = false;
mission_failed = false;

task_KillTarget_Description =
[
	"Eliminate the high value target",
	"Eliminate the high value target description...",
	""
];

task_Extract_Description =
[
	"Return to the extraction point.",
	"Extract",
	"Extract"
];

execvm "briefing.sqf";