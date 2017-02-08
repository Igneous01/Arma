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



		player createDiaryRecord["Diary", ["Support", "<br/>Well lets face it, you guys are the support. Your marksmanship and recon is the most valuable asset in successfuly getting our guys in and out safely.<br/>"]];
		player createDiaryRecord["Diary", ["Execution", "<br/>Your team is currently the closest asset in the area, you will need to do some hiking and fast tracking to reach the site. Thankfully your team is light on equipment and it shouldnt take you long to get there. But beware the mountainous terrain is vast and exhausting - getting heat stroke in this weather would spell alot of problems for command and the mission. So take care in getting there."]];
		player createDiaryRecord["Diary", ["Mission", "<br/>Your teams current orders are to move into the area of the <marker name='SARmark'>crash site</marker> and provide support for forces going in to relieve the personnel. Once you have arrived in the area, setup a fire position and standby for any incoming enemies as well as suspicious movement. Once you have secured yourselves, hold until forces secure the site, and then standby for further orders. We cannot let the Russians secure the site."]];
		player createDiaryRecord["Diary", ["Situation", "<br/>Team Shadow, who currently were undertaking operations in surveillance of the surroundings have been ordered to abort and direct their efforts in the support of the SAR of the downed personnel. Currently situated about a km away, Shadow will move fast and diligently and setup firing positions around the area. Numerous teams and squads have already begun rerouting towards the crash site, and it is suspected the Russians have also deployed teams to secure it as well. So far all heavy armor and air assets are currently engaged as well, and are unable to reroute. It is suspected that only units close by are being rerouted, as well as light armor and reconnaisance teams."]];
		player createDiaryRecord["Diary", ["Briefing", "<br/>Shadow, this is command, forfeit your current operations - you are ordered to assist in the Search and Rescue of a downed bird. Direct all your efforts to get to that crash site - you will provide overwatch and sniper fire support for ground troops currently on their way there. From the reports we recieved from the pilot, they have went down in enemy territory and we can assume that the Russians will also take this advantage and reroute their forces to secure and take the persons hostage. These personnel are top priority right now and we cannot afford to let the Russians get there hands on them."]];



// Secondary Objective
//>---------------------------------------------------------<
// Primary Objective
obj1 = player createSimpleTask["Reach the Crash Site"]; 
obj1 setSimpleTaskDescription["Get your team double time to the <marker name='SARmark'>crash site</marker> and provide fire support and recon for ground forces.", "Move to Crash Site", "Crash Site"];	
obj1 setSimpleTaskDestination (getMarkerPos "SARmark");

obj2 = player createSimpleTask["Defend the Crash Site"]; 
obj2 setSimpleTaskDescription["Support friendly forces in securing the area", "Defend Crash Site", "Defend"];	
obj2 setSimpleTaskDestination (getMarkerPos "SARmark");

obj4 = player createSimpleTask["Proceed to Extraction"];
obj4 setSimpleTaskDescription["Get to the extraction point", "Extract", "Extract"];
obj4 setSimpleTaskDestination (getmarkerPos "fake_extract");

player setCurrentTask obj1; 
obj1 settaskstate "Created"; 
obj2 settaskstate "Created";

	