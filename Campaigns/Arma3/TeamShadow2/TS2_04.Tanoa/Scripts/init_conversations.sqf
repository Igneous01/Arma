_unit = obj_SFLeader;

_conversation_62nd_meetup = [
	[
		[1,0],
		"Discuss Situation",
		"Shadow, good to have you. We've cleared the beachhead of enemy resistance and are sweeping the area. The defense was light here with little backup. Initial recon shows this side of the island is relatively light on enemy patrols and fortifications. We found some tripwire mines around the area and defused them, but there maybe more inside the jungle. So watch where you step.",
		nil,
		nil
		// [[""]]
	],
	[
		[1,10],
		"You found any new intel?",
		"Yeah, we found a phone that had some info on a storage facility housing a drone. If you can get to it and hack the drone, we can use that to locate the objectives. Based on the texts in the phone it appears to be somewhat lightly defended at this time. As far as we know their jammer will not jam any of their equipment, so you should be able to communicate with the drone without problems.",
		nil,
		nil
	],
	[
		[1,10],
		"What's your tasking?",
		"Our objectives are to destroy the EWJ and the EWR on Comms Whiskey. We'll be heading to Whiskey first to plant demolitions at the EWR and eliminate resistance. Once you locate the EWJ we'll move to an assault position and coordinate with your team to attack the EWJ and plant demolitions. Once demos are planted at both objectives, we'll synchronize detonation and coordinate with SEAD.",
		nil,
		nil
	],
	[
		[1,10],
		"Any intel on the Jammer?",
		"We didn't find any new information on the whereabouts of the jammer, the enemy is keeping it a well kept secret at this point.",
		nil,
		nil
	],
	[
		[1,20],
		"We'll be heading out.",
		"Afirm Shadow, watch your steps.",
		[
			nil,"complete_task_TalkToSFTeam.sqf"
		],
		nil
	]
] call ACS_standardize;

_unit setVariable ["ACS_Topics", _conversation_62nd_meetup];

_unit execVM "ACS\ACS_init.sqf";