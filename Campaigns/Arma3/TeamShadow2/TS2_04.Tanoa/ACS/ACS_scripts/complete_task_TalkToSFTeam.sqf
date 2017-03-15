// Completes the talk to SF leader task
//task_TalkToSFTeam setTaskState "Succeeded";
//["TaskCompleted",[(taskDescription task_TalkToSFTeam) select 1]] call bis_fnc_showNotification;
[task_TalkToSFTeam, group_Players, task_TalkToSFTeam_Description, getpos obj_SFLeader, "SUCCEEDED"] call BIS_fnc_setTask;

[group_Players,[task_FindJammer],task_FindJammer_Description,objNull,1,2,true] call BIS_fnc_taskCreate;
[group_Players,[task_FindSAMs],task_FindSAMs_Description,objNull,1,2,true] call BIS_fnc_taskCreate;
	[group_Players,["task_FindSAM1", task_FindSAMs],["Find SAM site A", "Find SAM site A", ""],objNull,1,2,true] call BIS_fnc_taskCreate;
	[group_Players,["task_FindSAM2", task_FindSAMs],["Find SAM site B", "Find SAM site B", ""],objNull,1,2,true] call BIS_fnc_taskCreate;
	[group_Players,["task_FindSAM3", task_FindSAMs],["Find SAM site C", "Find SAM site C", ""],objNull,1,2,true] call BIS_fnc_taskCreate;
	[group_Players,["task_FindSAM4", task_FindSAMs],["Find SAM site D", "Find SAM site D", ""],objNull,1,2,true] call BIS_fnc_taskCreate;

"mrk_uav" setMarkerAlpha 1;