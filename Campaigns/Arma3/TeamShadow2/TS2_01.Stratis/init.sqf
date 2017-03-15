"scripts\IGN_EH" call compile preprocessfilelinenumbers "scripts\IGN_EH\IGN_EH_INIT.sqf";
"scripts\IGN_DLG" call compile preprocessfilelinenumbers "scripts\IGN_DLG\IGN_DLG_INIT.sqf";

call compile preProcessFileLineNumbers "scripts\global.sqf";

TS2_fnc_setTaskState = compileFinal preProcessFileLineNumbers "scripts\setTaskState.sqf";
TS2_fnc_initPhaseLogic = compileFinal preProcessFileLineNumbers "scripts\Phase\initPhaseLogic.sqf";
TS2_fnc_initTargetZones = compileFinal preProcessFileLineNumbers "scripts\Phase\initTargetZones.sqf";
TS2_async_initPhase1 = compileFinal preProcessFileLineNumbers "scripts\Phase\initPhase1.sqf";
TS2_async_initPhase9 = compileFinal preProcessFileLineNumbers "scripts\Phase\initPhase9.sqf";
TS2_async_initPhase10 = compileFinal preProcessFileLineNumbers "scripts\Phase\initPhase10.sqf";
TS2_async_initPhases = compileFinal preProcessFileLineNumbers "scripts\Phase\initPhases.sqf";
TS2_fnc_calculateAccuracyBonus = compileFinal preProcessFileLineNumbers "scripts\Phase\calculateAccuracyBonus.sqf";
TS2_fnc_calculateScore = compileFinal preProcessFileLineNumbers "scripts\Phase\calculateScore.sqf";
TS2_fnc_getAllPhaseScores = compileFinal preProcessFileLineNumbers "scripts\Phase\getAllPhaseScores.sqf";
TS2_fnc_getPhaseScoreReport = compileFinal preProcessFileLineNumbers "scripts\Phase\getPhaseScoreReport.sqf";
TS2_hdl_hitPartHandler = compileFinal preProcessFileLineNumbers "scripts\Phase\hitPartHandler.sqf";
TS2_hdl_targetHitPartHandler = compileFinal preProcessFileLineNumbers "scripts\Phase\targetHitPartHandler.sqf";
TS2_fnc_startPhase = compileFinal preProcessFileLineNumbers "scripts\Phase\startPhase.sqf";
TS2_fnc_endPhase = compileFinal preProcessFileLineNumbers "scripts\Phase\endPhase.sqf";
TS2_async_startTest = compileFinal preProcessFileLineNumbers "scripts\Phase\startTest.sqf";
TS2_async_endTest = compileFinal preProcessFileLineNumbers "scripts\Phase\endTest.sqf";

TS2_TT_hdl_onEachFrame = compileFinal preProcessFileLineNumbers "dialogs\onEachFrameHandler.sqf";


//call compile preprocessfilelinenumbers "scripts\phase.sqf";

// bis defined global variable - controls whether targets should popup again after being hit
nopop=true;

// testing variable for target zones
//SPHERE = "Sign_Sphere10cm_F" createVehicle [0,0,0];



/*

// bis init line for standing range master
{
	removeAllWeapons this;
	this setBehaviour "CARELESS";
	this disableAI "anim";
	handle = this spawn
		{
			waitUntil {time > 0};
			_this switchMove "InBaseMoves_HandsBehindBack2";
		};
}
*/