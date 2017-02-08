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



{_x createDiaryRecord["Diary", ["Support", "<br/>Since civilians are still in the area, support is unavailable. Your on your own again.<br/>"]]} forEach [sniper, spotter];
{_x createDiaryRecord["Diary", ["Execution", "<br/>Your team will infiltrate the southern end of Skalisty Island by help of a local fisherman, and proceed to the <marker name='tmarker'>tower</marker> to check for any enemies present in the area. Currently we have no intel on the island itself, so you will need to make sure it is clear of enemy activity before setting up firing positions. After the island has been cleared and the threats removed, proceed back to the <marker name='mrkdock'>boathouse</marker> and provide overwatch of the town."]]} forEach [sniper, spotter];
{_x createDiaryRecord["Diary", ["Mission", "<br/>Team Shadow will locate, confirm and kill any snipers in the area, then move to the <marker name='mrkdock'>boathouse</marker> to provide overwatch."]]} forEach [sniper, spotter];
{_x createDiaryRecord["Diary", ["Situation", "<br/>For nearly 2 weeks now 1st and 2nd platoon have been pinned under sniper fire, and are unable to advance into Kamyshovo. They have suffered extensive casualties from what looks to be a platoon size garrison hidden inside the village. Attempts have been made to shell the town with mortar fire to flush them out, but reports have come in that civilians are still inside the village and are unable to escape. Chernarus officials have pleaded with the US military to prevent civilian casualties from rising in this conflict. Observers watching the town report that there appear to be multiple snipers spread out across the islands, as well as the town. However their exact locations are unknown, so it will be your teams job to locate, kill and confirm these snipers."]]} forEach [sniper, spotter];
{_x createDiaryRecord["Diary", ["Briefing", "<br/>With the success of the assualt and seizure of Electrozavodsk by Charlie company came a lucky break - A Russian mechanized platoon caught offguard and being completly wiped out, before any form of counter attack could take place. However the remaining enemy forces have made it extremely difficult to advance eastward along the coastline, as they have resorted to guerilla tactics to halt any form of advance we can make until reinforcements arrive. Snipers have positioned themselves around the town and are dealing effective damage to the strength and morale of Charlie Company. Only 1st and 2nd platoons remain intact, and reinforcements wont arrive for another 3 days. This is where Team Shadow comes in."]]} forEach [sniper, spotter];



// Secondary Objective
//>---------------------------------------------------------<
// Primary Objective
obj1 = [];

{
	_t = _x createSimpleTask["Scout the Tower"]; 
	_t setSimpleTaskDescription["Lack of intel on the island suggests that enemy forces may be present. Advance towards the <marker name='tmarker'>tower</marker> and clear any hostiles in the area.", "Scout the Tower", "Tower"];	
	_t setSimpleTaskDestination (getMarkerPos "tmarker");
	_x setCurrentTask _t; 
	obj1 set [count obj1, _t];
} forEach [sniper, spotter];

{_x settaskstate "Created"} foreach obj1;

	