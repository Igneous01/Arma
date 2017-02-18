/*	---Generic Action Script---
	Author: [EVO] Curry
	Function: Enables you to run any code directly from the addAction command
	Installation: Copy into your missions folder and call this file through addAction
	Example usage:  
		In init of something
		this addAction ["Say Hello World!","gen_action.sqf","player sideChat 'Hello World!';"];
		
	Notes: Recommended only for simple code or for testing scripts/functions designed for inits and triggers
*/

//Parameter one: String or Code - Whatever commands you want to issue, remember to check the syntax ;)

private ["_target","_caller","_ID","_arguments"];
_target 	= _this select 0;
_caller 	= _this select 1;
_ID			= _this select 2;
_arguments 	= _this select 3;

switch (typeName _arguments) do {
	case "STRING": 	
	{
		nul = [_target,_caller,_ID] spawn (compile _arguments);
	};
	case "CODE":	
	{
		nul = [_target,_caller,_ID] spawn _arguments;
	};
	default			
	{
		diag_log text "Error in gen_action.sqf: Invalid type passed to function.";
	};
};




