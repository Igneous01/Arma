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
player createDiaryRecord["Diary", ["Target ID", "<br/><img image='HVTPhoto.jpg' width='512' height='512'/>"]];
player createDiaryRecord["Diary", ["Execution", "<br/>There are some enemy patrols wandering across the other side of the main road. We have provided you with some suggestions for firing positions as well as routes to get there. There are limited amounts of positions available that provide a good view of the area, so you will need to make sure you have visual of the area and the target when he arrives."]];	
player createDiaryRecord["Diary", ["Mission", "<br/>The target is supposed to be meeting someone to discuss and purchase weapons. He is expected to arrive at 14:40. Position yourself and eliminate the target, then proceed to one of the extraction points."]];	
player createDiaryRecord["Diary", ["Briefing", "<br/>In this scenario, a high ranking warlord will be arriving at the <marker name='objmarker'>Factory</marker> to meet someone. Your task for this exercise is to eliminate him when he arrives. Completing this training exercise will have you graduate from sniper school as a HOG.<br/>HINT=TO PICK YOUR GEAR, GO TO UNIT, AND CLICK GEAR TO ADJUST YOUR LOADOUT! ALL FUTURE MISSIONS WILL FOLLOW THIS FORMAT!"]];	

//Optional Objectives

// Main Objectives
obj1 = player createsimpletask ["Eliminate the Target"]; 
obj1 setsimpletaskdescription ["Eliminate the target", "Eliminate the Target", ""];
obj1 settaskstate "CREATED";
obj2 = player createsimpletask ["Extract"]; 
obj2 setsimpletaskdescription ["Extract", "Extract", ""];
obj2 settaskstate "NONE";
player setCurrentTask obj1; 
