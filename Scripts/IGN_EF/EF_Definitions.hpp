class CfgFunctions
{
	class IGN_EF
	{
		class Effects
		{
			class createEffect
			{
				//preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				//ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
				file = "IGN_EF\effects\Efnc_createEffect.sqf";
			};
		};

		class Functional
		{
			class singleParam
			{
				//preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				//ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
				file = "IGN_EF\functional\Efnc_singleParam.sqf";
			};

			class isValidArgType
			{
				//preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				//ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
				file = "IGN_EF\functional\Efnc_isValidArgType.sqf";
			};
		};

		class Query
		{
			class getFirstDisabledVehicleInCollection
			{
				//preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				//ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
				file = "IGN_EF\query\Efnc_getFirstDisabledVehicleInCollection.sqf";
			};

			class getRandom2DPosASL
			{
				//preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				//ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
				file = "IGN_EF\query\Efnc_getRandom2DPosASL.sqf";
			};

			class deleteGroup
			{
				//preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				//ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
				file = "IGN_EF\query\Efnc_deleteGroup.sqf";
			};
		};

		class AI
		{
			class setRndSkill
			{
				//preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				//ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
				file = "IGN_EF\ai\Efnc_setRndSkill.sqf";
			};
		};

		class Boolean
		{
			class isGroupAlive
			{
				//preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				//ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
				file = "IGN_EF\boolean\Efnc_isGroupAlive.sqf";
			};

			class isGroupDead
			{
				//preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				//ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
				file = "IGN_EF\boolean\Efnc_isGroupDead.sqf";
			};

			class isGroupInVehicle
			{
				//preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				//ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
				file = "IGN_EF\boolean\Efnc_isGroupInVehicle.sqf";
			};

			class isGroupInVehicles
			{
				//preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				//ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
				file = "IGN_EF\boolean\Efnc_isGroupInVehicles.sqf";
			};

			class isUnitsAlive
			{
				//preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				//ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
				file = "IGN_EF\boolean\Efnc_isUnitsAlive.sqf";
			};

			class isVehicleDisabledInCollection
			{
				//preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				//ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
				file = "IGN_EF\boolean\Efnc_isVehicleDisabledInCollection.sqf";
			};

			class isVehicleDisabledOrDead
			{
				//preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				//ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
				file = "IGN_EF\boolean\Efnc_isVehicleDisabledOrDead.sqf";
			};


		};

		class Direction
		{
			class getDir
			{
				//preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				//ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
				file = "IGN_EF\direction\Efnc_getDir.sqf";
			};
		};

		class Hints
		{
			class advHints
			{
				//preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				//ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
				file = "IGN_EF\hints\Efnc_advHints.sqf";
			};
		};

		class Map
		{
			class mapClick
			{
				//preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				//ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
				file = "IGN_EF\map\Efnc_mapClick.sqf";
			};
		};

		class Markers
		{
			class hideMarker
			{
				//preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				//ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
				file = "IGN_EF\markers\Efnc_hideMarker.sqf";
			};

			class createMarker
			{
				//preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				//ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
				file = "IGN_EF\markers\Efnc_createMarker.sqf";
			};
		};

		class Numbers
		{
			class randInRange
			{
				//preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				//ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
				file = "IGN_EF\numbers\Efnc_randInRange.sqf";
			};

			class chance
			{
				//preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				//ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
				file = "IGN_EF\numbers\Efnc_chance.sqf";
			};
		};

		class Objects
		{
			class createLight
			{
				//preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				//ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
				file = "IGN_EF\objects\Efnc_createLight.sqf";
			};

			class nearestRoad
			{
				//preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				//ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
				file = "IGN_EF\objects\Efnc_nearestRoad.sqf";
			};
		};

		class Position
		{
			class getPosAtAngle
			{
				//preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				//ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
				file = "IGN_EF\position\Efnc_getPosAtAngle.sqf";
			};

			class setPosASLZ
			{
				//preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				//ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
				file = "IGN_EF\position\Efnc_setPosASLZ.sqf";
			};

			class setPosATLZ
			{
				//preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				//ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
				file = "IGN_EF\position\Efnc_setPosATLZ.sqf";
			};

			class setPosZ
			{
				//preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				//ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
				file = "IGN_EF\position\Efnc_setPosZ.sqf";
			};
		};

		class Tasks
		{
			class updateTask
			{
				//preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				//ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
				file = "IGN_EF\tasks\Efnc_updateTask.sqf";
			};
		};

		class Waypoints
		{
			class createWP
			{
				//preInit = 1; // 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
				//ext = ".sqf"; // Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
				file = "IGN_EF\waypoints\Efnc_createWP.sqf";
			};
		};
	};
};