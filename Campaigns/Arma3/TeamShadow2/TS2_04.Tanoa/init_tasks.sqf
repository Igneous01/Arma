// TASKS



// create first set of active tasks
//[group_Players,[task_FindJammer],task_FindJammer_Description,objNull,1,2,true] call BIS_fnc_taskCreate;
//[group_Players,[task_FindSAMs],task_FindSAMs_Description,objNull,1,2,true] call BIS_fnc_taskCreate;
//	[group_Players,["task_FindSAM1", task_FindSAMs],["Find SAM site A", "Find SAM site A", ""],objNull,1,2,true] call BIS_fnc_taskCreate;
//	[group_Players,["task_FindSAM2", task_FindSAMs],["Find SAM site B", "Find SAM site B", ""],objNull,1,2,true] call BIS_fnc_taskCreate;
//	[group_Players,["task_FindSAM3", task_FindSAMs],["Find SAM site C", "Find SAM site C", ""],objNull,1,2,true] call BIS_fnc_taskCreate;
//	[group_Players,["task_FindSAM4", task_FindSAMs],["Find SAM site D", "Find SAM site D", ""],objNull,1,2,true] call BIS_fnc_taskCreate;
[group_Players,[task_TalkToSFTeam],task_TalkToSFTeam_Description,getpos obj_SFLeader,1,1,true] call BIS_fnc_taskCreate;



//task_TalkToSFTeam = player createSimpleTask [task_TalkToSFTeam_Description select 1];
//task_TalkToSFTeam setSimpleTaskDescription task_TalkToSFTeam_Description;
//task_TalkToSFTeam setsimpletaskdestination (getpos obj_SFLeader);
//task_TalkToSFTeam setTaskState "Created";

//task_FindSAMs = player createSimpleTask [task_FindSAMs_Description select 1];
//task_FindSAMs setSimpleTaskDescription task_FindSAMs_Description;
//task_FindSAMs setTaskState "Created";

//task_FindJammer = player createSimpleTask [task_FindJammer_Description select 1];
//task_FindJammer setSimpleTaskDescription task_FindJammer_Description;
//task_FindJammer setTaskState "Created";


