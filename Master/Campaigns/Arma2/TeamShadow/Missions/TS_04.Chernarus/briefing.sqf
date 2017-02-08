/*
  *	Mikey's Briefing Template v0.03
  *
  *
  *	Notes: 
  *		- Use the tsk prefix for any tasks you add. This way you know what the varname is for by just looking at it, and 
  *			aids you in preventing using duplicate variable names.
  *
  *
  *		Required briefing commands:		
  *		- Create Note:			player createDiaryRecord ["Diary", ["*The Note Title*", "*The Note Message*"]]; 
  *		- Create Task:			tskExample = player createSimpleTask ["*The Task Title*"];
  *		- Set Task Description:	tskExample setSimpleTaskDescription ["*Task Message*", "*Task Title*", "*Task HUD Title*"];
  *
  *		Optional briefing commands:
  * 		- Set Task Destination:	tskExample setSimpleTaskDestination (getMarkerPos "mkrObj1");  // use an existing marker!
  *		- Set the Current Task:	player setCurrentTask tskExample;
  *		
  *		Formatting:
  *		- To add a newline: 		<br/>
  *		- To add a marker link:	<marker name='mkrObj1'>Attack this area!!!</marker>
  *		- To add an image: 		<img image='somePic.jpg'/> 
  *		   - custom width/height:	<img image='somePic.jpg' width='200' height='200'/>
  *		
  *		Commands to use in-game:
  *		- Set Task State:		tskExample setTaskState "SUCCEEDED";   // states: "SUCCEEDED"  "FAILED"  "CANCELED" "CREATED"
  *		- Get Task State:		taskState tskExample;
  *		- Get Task Description:	taskDescription tskExample;   // returns the *task title* as a string
  *		- Show Task Hint:		[tskExample] call mk_fTaskHint;  // make sure tskExample and the mk_fTaskHint function exist
  *							
  *
  *	Authors: Jinef & mikey
  */
player createDiaryRecord["Diary", ["Weather", "<br/>The weathers been nothing but intense fog and thunderstorms for the past 3 days. It doesnt look like its going to change either. While the fog gives you more freedom to move without being detected, it also limits your line of sight. You will need to be cautious advancing."]];	
player createDiaryRecord["Diary", ["Support", "<br/>Airsupport will be available one time to deliver a laser guided strike on the target."]];	
player createDiaryRecord["Diary", ["Execution", "<br/>Use the fighting and confusion to your advantage to escape. Your spotter is currently hiding on top of Vysota. A field mash is also there incase you get injured escaping. Then you will need to scout out each of the locations marked on the map, find the artillery, and destroy it."]];	
player createDiaryRecord["Diary", ["Mission", "<br/>Escape the city. Then proceed to regroup with your spotter located on the map. Your main objective will be to find and destroy the artillery position. Command has marked 3 possible areas of where they may be. But we are unsure where they exactly are. Once located, call in an airstrike on their position."]];	
player createDiaryRecord["Diary", ["Situation", "<br/>The fighting is relentless in Chernogorsk. Both sides have dug themselves in pretty deep, and its become difficult to fight and manuever through the city. Shells have constantly been hammering the city, hurting both sides in the process. Counter battery is not possible, as the enemy artillery keeps shifting about. You will have to regroup with your team, and scout ahead to locate and destroy the artillery position."]];	
player createDiaryRecord["Diary", ["Briefing", "<br/>Only a week after arriving in Chernogorsk, and the city's a mess. The lines have shifted so much that its difficult to tell friend from foe. Command has assigned you a new task, but the intense fighting has trapped you inside the city. You will have to find a way out."]];	

//Optional Objectives

// Main Objectives
obj1 = player createsimpletask ["Escape Chernogorsk"]; 
obj1 setsimpletaskdescription ["The place is getting hot. Too hot for a sniper. You need to get out of the city and proceed with your mission.", "Escape Chernogorsk", ""];
obj1 settaskstate "CREATED";
obj2 = player createsimpletask ["Regroup with your spotter"]; 
obj2 setsimpletaskdescription ["Your spotter has the neccessary equipment and information to complete the mission, regroup with him on Vysota.", "Regroup with your Spotter", ""];
obj2 settaskstate "CREATED";
obj3 = player createsimpletask ["Locate and Destroy the Artillery"]; 
obj3 setsimpletaskdescription ["Locate and Destroy the artillery position. You have one shot of calling in airsupport to do the job.", "Destroy Artillery", ""];
obj3 settaskstate "CREATED";
obj4 = player createsimpletask ["Proceed to Extraction Point"]; 
obj4 setsimpletaskdescription ["Once all objectives are completed, advance to the extraction point marked on the map.", "Extract", ""];
obj4 settaskstate "CREATED";

player setCurrentTask obj1; 
