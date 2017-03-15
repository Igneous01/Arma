// Globals
CURRENT_PHASE = objNull;	// controlled in triggers
TIME_TEST_START = -1;
TIME_TEST_END = -1;
TEST_STARTED = false;
TIME_TEST = 0;			// global that tracks players test time
TEST_PENALTIES = 0;
TEST_BONUSES = 0;

// CONSTANTS
BONUS_HIT = getNumber (missionConfigFile >> "TS2Config" >> "Constants" >> "bonus_hit");
BONUS_ACCURACY_HEAD = getNumber (missionConfigFile >> "TS2Config" >> "Constants" >> "bonus_hit_head");
BONUS_ACCURACY_TORSO_INNER = getNumber (missionConfigFile >> "TS2Config" >> "Constants" >> "bonus_hit_inner_torso");
BONUS_ACCURACY_TORSO_OUTER = getNumber (missionConfigFile >> "TS2Config" >> "Constants" >> "bonus_hit_outer_torso");

PENALTY_SKIPPED_TARGET = getNumber (missionConfigFile >> "TS2Config" >> "Constants" >> "penalty_skipped_target");
PENALTY_MISSED_SHOT = getNumber (missionConfigFile >> "TS2Config" >> "Constants" >> "penalty_missed_shot");
PENALTY_WRONG_WEAPON = getNumber (missionConfigFile >> "TS2Config" >> "Constants" >> "penalty_wrong_weapon");

HEAD_ZONE_DISTANCE = getNumber (missionConfigFile >> "TS2Config" >> "Constants" >> "TargetConstants" >> "head_zone_max_radius");
TORSO_INNER_ZONE_DISTANCE = getNumber (missionConfigFile >> "TS2Config" >> "Constants" >> "TargetConstants" >> "torso_inner_zone_max_radius");
TORSO_OUTER_ZONE_DISTANCE = getNumber (missionConfigFile >> "TS2Config" >> "Constants" >> "TargetConstants" >> "torso_outer_zone_max_radius");

// format [targetclass, headpos, torsopos]
TARGET_ZONE_ARRAY =
[
	["Target_PopUp2_Moving_90deg_Acc1_F", [-0.01,0.17,0.71], [0.023,0.17,0.27]],
	["TargetP_Inf2_Acc1_F", [-0.033,0.17,0.615], [0,0.17,0.18]],
	["Target_PopUp2_Moving_Acc1_F", [-0.033,0.17,0.71], [0,0.17,0.27]],
	["Target_PopUp3_Moving_90deg_Acc1_F", [0.023,0.17,0.72], [0.023,0.17,0.27]],
	["TargetP_Inf3_Acc1_F", [0,0.17,0.625], [0,0.17,0.175]],
	["Target_PopUp3_Moving_Acc1_F", [0,0.17,0.72], [0,0.17,0.27]],
	["Target_PopUp_Moving_90deg_Acc1_F", [0.023,0.17,0.76], [0.023,0.17,0.27]],
	["TargetP_Inf_Acc1_F", [0,0.17,0.665], [0,0.17,0.175]],
	["Target_PopUp_Moving_Acc1_F", [0,0.17,0.76], [0,0.17,0.27]],
	["TargetP_Inf4_Acc1_F", [-0.005,0.17,0.635], [0.04,0.17,0.19]]
];// swivel targets do not have zones

// times
TIME_GOLD = getArray (missionConfigFile >> "TS2Config" >> "Constants" >> "gold_time");
TIME_SILVER = getArray (missionConfigFile >> "TS2Config" >> "Constants" >> "silver_time");
TIME_BRONZE = getArray (missionConfigFile >> "TS2Config" >> "Constants" >> "bronze_time");