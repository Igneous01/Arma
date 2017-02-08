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


player createDiaryRecord["Diary", ["Target ID", "<br/><img image='Tpic.jpg'/>"]];
player createDiaryRecord["Diary", ["Support", "<br/>No support will be available."]];
player createDiaryRecord["Diary", ["Execution", "<br/>Your team will travel South-West towards the airfield. We believe the northern forests are uninhabited and should provide relatively quick access to the target destination. However this is not confirmed. A recent predator run confirms multiple patrols and guards in and around the target area. It is also believed that the target will be leaving with the other men there by car to an unknown destination to properly discuss. You will setup a fire position in the area, wait until the target arrives, and eliminate him. If you fail to get there in time, or eliminate him, his chance of escape is highly likely."]];
player createDiaryRecord["Diary", ["Mission", "<br/>Team Shadow will infiltrate the North-Eastern forest by helicopter insertion, and proceed towards the target area to eliminate the Giver upon arrival. Expected arrival time is 4:45."]];
player createDiaryRecord["Diary", ["Situation", "<br/>Its a messy situation - both politically and militarily. We have been getting numerous reports about rebel fighters sided with the Russians engaging US and CDF forces. Rumours are also circulating about the possibility of hired mercenaries arriving into Chernarus backed secretly by the Russian government and Chernarus political group known as Green Sparrow. The major question that has eluded officials is the identity of the suppliers at hand. If we dont severe the connection between the suppliers and the armies, we may have a civil war on our hands that would escalate to a genocide of horrific proportions for the country and surrounding provinces. Thankfully a spy has been able to uncover the identity of one of the main players in the industry. He is expected to arrive at 4:45 by helicopter to the airfield to discuss business with the Russian command staff as well as rebel leaders. You must eliminate him as this is the only chance we have at taking him down."]];
player createDiaryRecord["Diary", ["Briefing", "<br/>Your team will be sent to the northeastern end of Krasnostav, where intel confirms a meeting will be going down with private arms dealers and the Russian command staff. Your team will find, confirm, and kill the primary target codenamed GIVER."]];	

// Main Objectives
obj2 = sniper createsimpletask ["Extract"]; 
obj2 setsimpletaskdescription ["Proceed to the extraction point", "Extract", "Extraction Point"]; 
obj1 = sniper createsimpletask ["Eliminate the GIVER"]; 
obj1 setsimpletaskdescription ["The GIVER is expected to arrive at Krasnostav airfield at 4:45. Eliminate him when he arrives", "Eliminate the GIVER", ""]; 

sniper setcurrenttask obj1;