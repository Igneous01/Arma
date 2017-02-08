_unit = obj_SFLeader;

_conversation_62nd_meetup = [
	[
		[1,0],
		"Discuss Situation",
		"Pretty fine weather we're having today, eh private?",
		nil,
		nil
		// [[""]]
	],
	[
		[1,10],
		"Sir?",
		"Just answer the damn question, son.",
		nil,
		nil
	],
	[
		[1,20],
		"Yes, sir",
		"Outstanding. Go meet up with the rest of your squad and get ready to patrol.",
		nil,
		nil
	],
	[
		[1,30],
		"Will do, sir",
		"Shit! That's the alarm! Hold on a minute, I'm recieving orders.",
		nil,
		nil
	],
	[
		[1,40],
		"New Orders",
		"Listen up, private. Insurgents were spotted in Agios Cephas, that's really fucking close to here.",
		nil,
		nil
	],
	[
		[1,50],
		"Where is Agios Cephas?",
		"It's to our southwest, less than 300 meters. Follow the road out of here and take a left, you'll drive right up to it.",
		nil,
		nil
	],
	[
		[1,50],
		"What should we do?",
		"Go out there and question the civvies to find out where they are, you're not so dumb that you can't figure out the rest, are you?",
		[
			nil,"complete_task_TalkToSFTeam.sqf"
		],
		nil
	]
] call ACS_standardize;

_unit setVariable ["ACS_Topics", _conversation_62nd_meetup];

_unit execVM "ACS\ACS_init.sqf";