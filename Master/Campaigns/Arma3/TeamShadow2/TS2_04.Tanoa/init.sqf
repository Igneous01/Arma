// conversation init
#include "ACS\ACS_userFunctions.sqf"
#include "Scripts\init_conversations.sqf"

call compile preprocessfilelinenumbers "functions.sqf";	// mission specific functions
call compile preprocessfilelinenumbers "IGN_LIB\IGN_LIB_INIT.sqf";	// events and functions

bool_FoundSAMs = false;
bool_FoundJammer = false;
bool_JammerAttacked = false;

task_TalkToSFTeam = "task_TalkToSFTeam";
task_FindSAMs = "task_FindSAMs";
task_FindJammer = "task_FindJammer";
task_AssistSFTeam = "task_AssistSFTeam";
task_Extract = "task_Extract";

task_TalkToSFTeam_Description =
[
	"Consult with callsign 62 regarding immediate situation and threat assessment.",
	"Talk to team lead of callsign 62",
	"Callsign 62"
];

task_FindSAMs_Description =
[
	"Recon the island to find the enemy SAM sites. Once the assault begins the SEAD strike package will initiate the destruction of these sites. To spot a site, use the 'reveal target' key.",
	"Locate the SAM sites",
	""
];

task_FindJammer_Description =
[
	"Recon the island to find the electronic warfare jammer, which is interfering with our ability to launch airstrikes. Once located, callsign 62 will begin task to assault and destroy the jammer.",
	"Locate the Electronic Warfare Jammer",
	""
];

task_AssistSFTeam_Description =
[
	"Assist callsign 62 with fire support while they move to engage the Jammer position and plant demolitions. Use the radio action 0-1 to coordinate the assault.",
	"Cover callsign 62",
	"Support"
];

task_Extract_Description =
[
	"Return to the extraction point.",
	"Extract",
	"Extract"
];

// force players to eject from vehicle
//{ _x action ["Eject",vehicle _x] } foreach units group player;

// outstanding items to do
// -- make tasks work on both members of group