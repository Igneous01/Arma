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

{_x createDiaryRecord["Diary", ["Forecast", "<br/>Dense fog and a visibility of maybe 500m, that is expected to clear up as morning comes to a visibility range of maybe 2.5km. Thunderstorms will most likely be active all day."]]} forEach [sniper, spotter];
{_x createDiaryRecord["Diary", ["Diminikov ID", "<img image='Diminikov.jpg'/> "]]} forEach [sniper, spotter];
{_x createDiaryRecord["Diary", ["Support", "<br/>No support will be available.<br/>"]]} forEach [sniper, spotter];
{_x createDiaryRecord["Diary", ["Execution", "<br/>You will start 400m NE of Orlovets, where by you will proceed through the brush to your first waypoint. The higher elevation and vegetation will give you a superior view on the area. Afterwards you will proceed to the next series of waypoints and trace any movements with suspected Chedaki activity. Our photos have shown Berezino to be relatively clear of hostile activity, but be advised to stay cautious when advancing. You are permitted to engage only targets of high value, such as snipers, officers, and Diminikov. Keep your eyes and ears open when moving from point to point."]]} forEach [sniper, spotter];
{_x createDiaryRecord["Diary", ["Mission", "<br/>Patrol points have been designated for your team. You will advance to the first waypoint, and hold until cleared to proceed to the next one and so forth. High value areas of observation have been marked on your map, so keep an eye on these locations for enemy activity. We also have reason to believe that the commander of the Chedaki forces, Lt. Diminikov, is present in the area, however this information may be false, and so he is not a target of priority in this mission. If you do manage to locate and confirm Diminikov, your orders are to engage and eliminate him."]]} forEach [sniper, spotter];
{_x createDiaryRecord["Diary", ["Situation", "<br/>Berezino was deemed by many in the command staff to be an important location to hold. A large assault was attempted to secure it as quick as possible, to open up a possible flank on the Russian front. However the assault failed when Russian intel discovered our plans and countered our move. It was a disaster, and soon after the Russians withdrew as well seeing no more strategic value in the area. Now that Chedaki have taken claim to it, it may open up as a potential problem in future engagements."]]} forEach [sniper, spotter];
{_x createDiaryRecord["Diary", ["Briefing", "<br/>Your team is being sent to Nizhnoye to patrol the surrounding area. Aerial recon has shown photographs of Chernarus insurgents establishing themselves in the area. Apparently the Russians gave it to them to setup a strong line to join with their's. We want an update on the ground as to the activity in the area."]]} forEach [sniper, spotter];



// Secondary Objective
//>---------------------------------------------------------<
// Primary Objective
obj1 = [];
obj2 = [];
obj3 = [];
obj4 = [];
obj5 = [];
obj6 = [];
obj7 = [];
obj8 = [];
obj9 = [];

{
	_t = _x createSimpleTask["Reach Waypoint 1"]; 
	_t setSimpleTaskDescription["Advance and hold at waypoint 1 until cleared to proceed.", "Reach Waypoint 1", "WP1"];	
	_t setSimpleTaskDestination (getMarkerPos "waypoint1");
	_x setCurrentTask _t; 
	obj1 set [count obj1, _t];
} forEach [sniper, spotter];

{_x settaskstate "Created"} foreach obj1;

{   _t = _x createSimpleTask["Reach Waypoint 2"];    _t setSimpleTaskDescription["Advance and hold at waypoint 2 until cleared to proceed.", "Reach Waypoint 2", "WP2"];    _t setSimpleTaskDestination (getMarkerPos "waypoint2");   _x setCurrentTask _t;    obj2 set [count obj2, _t];  } forEach [sniper, spotter];

{
	_t = _x createSimpleTask["Reach Waypoint 3"];   
	_t setSimpleTaskDescription["Advance and hold at waypoint 3 until cleared to proceed.", "Reach Waypoint 3", "WP3"];
      _t setSimpleTaskDestination (getMarkerPos "waypoint3");   
      _x setCurrentTask _t;    
      obj3 set [count obj3, _t];  
} forEach [sniper, spotter]; 

{   
	_t = _x createSimpleTask["Reach Waypoint 4"];    
	_t setSimpleTaskDescription["Advance and hold at waypoint 4 until cleared to proceed.", "Reach Waypoint 4", "WP4"];    
	_t setSimpleTaskDestination (getMarkerPos "waypoint4");   
	_x setCurrentTask _t;    
	obj4 set [count obj4, _t];  
} forEach [sniper, spotter];   

{   _t = _x createSimpleTask["Reach Waypoint 5"];    _t setSimpleTaskDescription["Advance and hold at waypoint 5 until cleared to proceed.", "Reach Waypoint 5", "WP5"];    _t setSimpleTaskDestination (getMarkerPos "waypoint5");   _x setCurrentTask _t;    obj5 set [count obj5, _t];  } forEach [sniper, spotter];    

{   _t = _x createSimpleTask["Reach Waypoint 6"];    _t setSimpleTaskDescription["Advance and hold at waypoint 6 until cleared to proceed.", "Reach Waypoint 6", "WP6"];    _t setSimpleTaskDestination (getMarkerPos "waypoint6");   _x setCurrentTask _t;    obj6 set [count obj6, _t];  } forEach [sniper, spotter];    

{   _t = _x createSimpleTask["Reach Waypoint 7"];    _t setSimpleTaskDescription["Advance and hold at waypoint 7 until cleared to proceed.", "Reach Waypoint 7", "WP7"];    _t setSimpleTaskDestination (getMarkerPos "waypoint7");   _x setCurrentTask _t;    obj7 set [count obj7, _t];  } forEach [sniper, spotter];    

{   _t = _x createSimpleTask["Reach Waypoint 8"];    _t setSimpleTaskDescription["Advance and hold at waypoint 8 until cleared to proceed.", "Reach Waypoint 8", "WP8"];    _t setSimpleTaskDestination (getMarkerPos "waypoint8");   _x setCurrentTask _t;    obj8 set [count obj8, _t];  } forEach [sniper, spotter];    
 
{   _t = _x createSimpleTask["Extract"];    _t setSimpleTaskDescription["Extract to the specified position.", "Extract", "Extraction"];    _t setSimpleTaskDestination (getMarkerPos "Extraction");   _x setCurrentTask _t;    obj9 set [count obj9, _t];  } forEach [sniper, spotter];

oobj1 = [];

{
	_t = _x createSimpleTask["Locate and Eliminate Lt. Diminikov"]; 
	_t setSimpleTaskDescription["We believe Diminikov is somewhere in the area, but it is not 100% certain. If located, eliminate Lt. Diminikov", "Optional: Locate and Eliminate Lt. Diminikov", ""];	
	_x setCurrentTask _t; 
	oobj1 set [count oobj1, _t];
} forEach [sniper, spotter];

{_x settaskstate "Created"} foreach oobj1;
