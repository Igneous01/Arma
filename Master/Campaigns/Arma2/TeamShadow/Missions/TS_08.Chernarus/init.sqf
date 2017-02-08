// Global Variables for mission
DZ_SuitCasePickedUp = 0; // checks if the suitcase was picked up and brought back to guy (for FSM check to trigger next speech and actions
DZ_InformantFound = 0; // checks if the Informant was found (via Inf_Friend or Letter picked up)

// Core Functions - for rangefinder script
execvm "RMM_Core.sqf";

//Briefing and Objectives
execvm "briefing.sqf";

// Spotting mode function initialization
DZ_FNC_SpottingMode = {
	private ["_spotter"]; 
      _spotter = _this select 0; 
      selectplayer _spotter; 
      (vehicle _spotter) switchcamera "GUNNER";
};

// sniper controller
nul = [] execVM "vsnipercontrol.sqf";

// Conversation system setup
{_x setVariable ["BIS_noCoreConversations", TRUE]} forEach [player, Inf_Friend, target]; //disables core conversations ("hi - ssup" etc.)

player kbAddTopic ["sidemission", "kb\conversations.bikb", "", {call compile preprocessFileLineNumbers "kb\sidemission_sniper.sqf"}]; //no need for FSM, hence the empty quotes
Inf_Friend kbAddTopic ["sidemission", "kb\conversations.bikb", "kb\InformantFriend.fsm"];
target kbAddTopic ["mainmission", "kb\conversations.bikb"];


