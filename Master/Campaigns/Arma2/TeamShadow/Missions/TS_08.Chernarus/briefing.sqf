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

player createDiaryRecord["Diary", ["Support", "<br/>No support will be available"]];
player createDiaryRecord["Diary", ["Execution", "<br/>You will need to follow the informant's trail to find him. However his subordinate may also lead you to his location. See what you can do about his intel."]];
player createDiaryRecord["Diary", ["Mission", "<br/>Find the informant, acquire the intel he has, and see if its accurate. "]];
player createDiaryRecord["Diary", ["Situation", "<br/>The last reports we recieved on the whereabouts of the informant are a few days old. We have his last known position marked on the map. We think that he is leaving us a trail to follow, as the Russians and Chernarus officials are also hunting him down for the files he stole. You will need to pick up on his trail until you can find his location. There is also another man, who claims he knows and works for the informant, currently residing in the forest. He knows that US personnel are looking for the informant and agrees to help lead the way to him. It might be easier to contact the subordinate to find the informant. All things considered - these are shady people working in a shady business - dont ask alot of questions and you should be fine."]];
player createDiaryRecord["Diary", ["Briefing", "<br/>Good work on eliminating GIVER, it turns out he was a very valuable asset to the Russian government. But now a new problem surfaces. We have recieved reports that there is another arms dealer in Chernarus, codename THE MERCHANT. we want your team to take him out as well and completely stifle the flood of weapons coming into the country. However, we have no reports or intel on his location or whereabouts. There is an informant, who claims he knows where the target is and has files and photos of him. However his ties with the CIA is all too shady of a business, and so command has alot of suspicions about him. We want your team to find the informant, and see if his intel is straight."]];

// Main Objectives
obj1 = sniper createsimpletask ["Find the informant"]; 
obj1 setsimpletaskdescription ["Current whereabouts to the informant are unknown. However he has left a trail for us to follow.", "Find the informant", ""]; 
obj1 settaskstate "Created";
sniper setcurrenttask obj1;