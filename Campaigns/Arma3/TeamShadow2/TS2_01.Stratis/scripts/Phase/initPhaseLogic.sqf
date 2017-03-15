// constructs phase logic object with various properties
params["_logic", "_targets", "_weapon"];
diag_log text format ["IGN_fnc_initPhaseLogic: %1", _this];
_logic setVariable ["TS2_targets", _targets];
_logic setVariable ["TS2_targetsCount", count _targets];
//_logic setVariable ["TS2_started", false];	// whether phase has started - used to prevent triggers from reactivating
_logic setVariable ["TS2_weapon", _weapon];	// required weapon
_logic setVariable ["TS2_shotsFired", 0];	// number of shots fired
_logic setVariable ["TS2_hits", 0];			// number of hits
_logic setVariable ["TS2_time", 0];			// time completed
_logic setVariable ["TS2_accuracyHits", 0]; // bonus counter for accuracy
_logic setVariable ["TS2_bonus", 0 ];		// bonus subscore (used in logic and calculation) (displays in real time for player)
_logic setVariable ["TS2_penalties", 0];	// penalty points accrued during phase (displays in real time for player)
_logic setVariable ["TS2_penaltyWrongWeapon", 0];	// penalty counter for wrong weapon in zone
_logic setVariable ["TS2_penaltyMissedShots", 0];	// penalty counter for misses
_logic setVariable ["TS2_penaltySkippedTargets", 0];// penalty counter for skipping/not hitting all targets in phase