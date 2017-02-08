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

// since we're working with the player object here, make sure it exists
waitUntil { !isNull player }; // all hip now ;-)
waitUntil { player == player };



player createDiaryRecord["Diary", ["Support", "<br/>Your the only ones going in and out of that island. No support will be available."]];
player createDiaryRecord["Diary", ["Execution", "<br/>Your team will infiltrate the north-west side of the island by boat under the cover of darkness. Previous observations have concluded that the lighthouse is the least patrolled area on the island, but vehicles are patrolling all access roads on the island, so be careful. Manuever south-east around the lighthouse and advance into the deep forests until you reach the airfield. Mark as many heavy AA sites as you can find (shilkas, zsu, tunguskas) and eliminate the target. You shouldnt expect to encounter any patrols that are not on nightwatch."]];
player createDiaryRecord["Diary", ["Mission", "<br/>Eliminate the <marker name='objmark1'>high value target</marker>, believed to be located at the airfield inside the control tower, as well as locating any Anti-Air sites scattered across the island."]];
player createDiaryRecord["Diary", ["Situation", "<br/>Conflict and tensions between Chernarus locals and Russia have grown to the point where the United States Army will have to declare war in order to keep its influence in the Chernarus grounds. Currently the area of interest for the USNavy is the invasion of the fortified island 'Utes' where a small airforce poses a significant threat on the advancement of Warships closing the distance to Chernarus for firesupport. Several days ago a reconnaissance plane was shot down while flying a mission to gather intel on the islands capabilities. The information has not been found and time is running out before Chernarus ends up being overrun. Your team will be sent in to gather intel and eliminate a high value target believed to be situated at the airfield."]];
player createDiaryRecord["Diary", ["Briefing", "<br/>Team Shadow has been dispatched to Utes to establish solid reconnaisance of the island's defenses and location of high value areas such as Anti-Air sites and the like. They are also sent to eliminate the High Value Target who is believed to be located inside the control tower at the airfield.<br/>"]];	

//Optional Objectives

oobj1 = sniper createsimpletask ["Optional: Eliminate Gen. Makarov"];
oobj1 setsimpletaskdescription ["There are rumored reports that a high ranking General by the name Alek Makarov is stationed currently at Utes, Eliminating him would be invaluable, if the possibility exists. (Optional Objective)", "Eliminate Gen. Makarov", ""];

// Main Objectives
obj2 = sniper createsimpletask ["Locate the Anti Air Sites"]; 
obj2 setsimpletaskdescription ["From the reports of the reconnaissance plane that was shotdown, there are a number of anti air sites scattered across the island. Locate and mark these anti air sites", "Locate AA sites", ""]; 
obj1 = sniper createsimpletask ["Eliminate the HVT"]; 
obj1 setsimpletaskdescription ["The High Value Target was last reported to be in the control tower at the airfield.", "Eliminate the HVT", "HVT"]; 
