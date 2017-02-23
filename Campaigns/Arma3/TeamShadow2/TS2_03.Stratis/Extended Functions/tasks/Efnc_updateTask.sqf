/*
* Efnc_updateTask
* simplifies updating tasks, by both setting the task state, and making a call to the taskHint, so the hint displays to player
* [task, state] call Efnc_updateTask
* task: Task - the task object
* state: String - state of task ("SUCCEEDED", "FAILED", "CREATED", "CANCELED")
* returns: nothing
*/

private ["_task", "_state"];
_task = _this select 0;
_state = _this select 1;
_task settaskstate _state;
[objNull, ObjNull, _task, _state] execVM "CA\Modules\MP\data\scriptCommands\taskHint.sqf";
