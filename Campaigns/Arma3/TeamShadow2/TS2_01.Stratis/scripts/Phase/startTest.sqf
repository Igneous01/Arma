TIME_TEST_START = time;	// set start time

// teleport player
player setPos (getPos logic_start_pos);
player setDir (direction logic_start_pos);

// freeze controls for 3 seconds
disableUserInput true;

// count down
titleText ["3", "PLAIN DOWN"];
sleep 1;
titleText ["2", "PLAIN DOWN"];
sleep 1;
titleText ["1", "PLAIN DOWN"];
sleep 1;
titleText ["GO", "PLAIN DOWN"];

disableUserInput false;

// draw hud
cutRsc ["HUDTIMETRIAL","PLAIN"];	// show hud
["updateHudH", "onEachFrame", TS2_TT_hdl_onEachFrame,
	[
		"updateHudH", TIME_TEST_START,
		[
			getText (missionConfigFile >> "TS2Config" >> "Resource" >> "GoldMedal" >> "color"),
			getText (missionConfigFile >> "TS2Config" >> "Resource" >> "GoldMedal" >> "image")
		],
		[
			getText (missionConfigFile >> "TS2Config" >> "Resource" >> "SilverMedal" >> "color"),
			getText (missionConfigFile >> "TS2Config" >> "Resource" >> "SilverMedal" >> "image")
		],
		[
			getText (missionConfigFile >> "TS2Config" >> "Resource" >> "BronzeMedal" >> "color"),
			getText (missionConfigFile >> "TS2Config" >> "Resource" >> "BronzeMedal" >> "image")
		],
		[
			getText (missionConfigFile >> "TS2Config" >> "Resource" >> "NoneMedal" >> "color"),
			getText (missionConfigFile >> "TS2Config" >> "Resource" >> "NoneMedal" >> "image")
		],
		[
			getText (missionConfigFile >> "TS2Config" >> "Resource" >> "Penalty" >> "color"),
			getText (missionConfigFile >> "TS2Config" >> "Resource" >> "Penalty" >> "image")
		],
		[
			getText (missionConfigFile >> "TS2Config" >> "Resource" >> "Bonus" >> "color"),
			getText (missionConfigFile >> "TS2Config" >> "Resource" >> "Bonus" >> "image")
		],
		[
			getText (missionConfigFile >> "TS2Config" >> "Resource" >> "Targets" >> "color"),
			getText (missionConfigFile >> "TS2Config" >> "Resource" >> "Targets" >> "image")
		]
	]
] call BIS_fnc_addStackedEventHandler;


// display start hint
//hintC "Start!";

(group player) setCurrentWaypoint [(group player), 1];	// set the player waypoint back to the beginning

player addEventHandler
["Fired",
	{
		params ["_unit", "_weapon"];
		if (_unit isEqualTo player) then
		{
			if (! (isNull CURRENT_PHASE)) then
			{
				CURRENT_PHASE setVariable ["TS2_shotsFired", (CURRENT_PHASE getVariable "TS2_shotsFired") + 1];
				private _weapon = ((currentWeapon player) call BIS_fnc_itemtype) select 1;
				// check if matches weapon specified in phase
				if ( ! (_weapon isEqualTo (CURRENT_PHASE getVariable "TS2_weapon")) ) then
				{
					CURRENT_PHASE setVariable ["TS2_penaltyWrongWeapon", (CURRENT_PHASE getVariable "TS2_penaltyWrongWeapon") + 1];
					TEST_PENALTIES = TEST_PENALTIES + PENALTY_WRONG_WEAPON;
				};
			}
			else
			{
				// add them to player? track them and penalize?
			};
		};
	}
];

TEST_STARTED = true;