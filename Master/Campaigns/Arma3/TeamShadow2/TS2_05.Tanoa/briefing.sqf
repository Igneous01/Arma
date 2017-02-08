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
//waitUntil { !isNull player }; // all hip now ;-)
//waitUntil { player == player };



player createDiaryRecord["Diary", ["Support", "<br/>Your the only ones on station. No support will be available."]];
player createDiaryRecord["Diary", ["Execution", "<br/>"]];
player createDiaryRecord["Diary", ["Recon Report", "<br/>Satellite photos and drone reconnaissance reveals road blocks and checkpoints are setup on all major intersections and roads leading into the factory. There are also reports of vehicle patrols on all the major roadways. The factory has a mix of armed thugs and civilian workers, with estimates ranging from 30 to 100 armed men inside. Buawa contains additional reinforcements. Booby traps have been setup around the path leading to the radio tower on Hill 213, it's likely the surrounding jungle will also be mined. The Syndikat has access to drones: there appears to be an operator piloting a drone around the factory. Avoid roadways and major intersections."]];
player createDiaryRecord["Diary", ["Mission", "<br/>Eliminate the Candy Man who will be arriving at the Sugar Cane Factory. Do not harm or kill any civilians."]];
player createDiaryRecord["Diary", ["Briefing", "<br/>After countless days of surveillance, tapping phones, and hacking emails, Military Intelligence intercepted a crucial conversation. This is Ricardo Pabriques, a wealthy supplier and trafficker that funds the Syndikat operation in Tanoa, also known as 'Candy Man'. He is part of the elite circle within the Syndikat, and oversees the Tanoa Sugar Company operation. The Syndikat is partly funded by the export of Sugar Cane, where drugs are smuggled and sold out of the country. Taking out a key player of this operation will do a serious blow to their logistics and funding.<br/><br/>Military Intelligence has traced a deal that will be taking place at the Sugar Cane Factory today at around 15:00. Team Shadow has been hiding in the jungle performing deep reconnaissance of the main island. Now is the time to strike. Shadow will ingress to a firing position overlooking the Sugar Cane Factory to wait for the arrival of the Candy Man. Shadow will confirm the target, engage, then egress back to the extraction point. There are reports of civilians working in the factory - do not harm or kill any civilians, we don't want this coming back to haunt us in the press.<br/>"]];
