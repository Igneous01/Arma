if (isServer) then
{
_this = createCenter east;
_this setFriend [west, 0];
_this setFriend [resistance, 1];
_this setFriend [civilian, 1];
_center_0 = _this;

_group_3 = createGroup _center_0;

_group_4 = createGroup _center_0;

_unit_0 = objNull;
if (true) then
{
  _this = _group_4 createUnit ["RU_Soldier_MG", [3571.1733, 3647.9417, 4.7167602], [], 0, "NONE"];
  _unit_0 = _this;
  _this setDir -37.730343;
  _this setUnitRank "CORPORAL";
  _this setUnitAbility 0.33010891;
  if (true) then {_group_4 selectLeader _this;};
};

_unit_13 = objNull;
if (true) then
{
  _this = _group_3 createUnit ["RUS_Commander", [3568.6506, 3643.3997, 9.1410208], [], 0, "NONE"];
  _unit_13 = _this;
  _this setDir -7.4079561;
  _this setVehicleInit "removeallweapons this";
  _this setUnitAbility 0.60000002;
  if (true) then {_group_3 selectLeader _this;};
};

_objectComposition_5 = [[3319.9753, 4345.8296, -1.1444092e-005], 159.46931, "FuelDump1_RU"] call (compile (preprocessFileLineNumbers "ca\modules\dyno\data\scripts\objectmapper.sqf"));

_vehicle_0 = objNull;
if (true) then
{
  _this = createVehicle ["ACE_BTR70_RU", [3266.0205, 4319.6401, -1.9073486e-006], [], 0, "NONE"];
  _vehicle_0 = _this;
  _this setDir 61.308773;
  _this setVehicleAmmo 0;
  _this setVehicleLock "LOCKED";
  _this setPos [3266.0205, 4319.6401, -1.9073486e-006];
};

_vehicle_2 = objNull;
if (true) then
{
  _this = createVehicle ["ACE_BTR70_RU", [3264.2134, 4325.6748, -3.8146973e-006], [], 0, "NONE"];
  _vehicle_2 = _this;
  _this setDir 61.308773;
  _this setVehicleAmmo 0;
  _this setVehicleLock "LOCKED";
  _this setPos [3264.2134, 4325.6748, -3.8146973e-006];
};

_vehicle_4 = objNull;
if (true) then
{
  _this = createVehicle ["ACE_BTR70_RU", [3274.7935, 4324.396, -7.6293945e-006], [], 0, "NONE"];
  _vehicle_4 = _this;
  _this setDir 61.308773;
  _this setVehicleAmmo 0;
  _this setVehicleLock "LOCKED";
  _this setPos [3274.7935, 4324.396, -7.6293945e-006];
};

_vehicle_6 = objNull;
if (true) then
{
  _this = createVehicle ["ACE_BTR70_RU", [3272.3521, 4330.1079, -0.051129587], [], 0, "NONE"];
  _vehicle_6 = _this;
  _this setDir 61.308773;
  _this setVehicleAmmo 0;
  _this setVehicleLock "LOCKED";
  _this setPos [3272.3521, 4330.1079, -0.051129587];
};

_vehicle_8 = objNull;
if (true) then
{
  _this = createVehicle ["RUVehicleBox", [3281.3274, 4335.6714, 0.84598464], [], 0, "NONE"];
  _vehicle_8 = _this;
  _this setDir -27.257677;
  _this setPos [3281.3274, 4335.6714, 0.84598464];
};

_vehicle_10 = objNull;
if (true) then
{
  _this = createVehicle ["RUVehicleBox", [3286.6343, 4329.2891, 0.56428796], [], 0, "NONE"];
  _vehicle_10 = _this;
  _this setDir -208.56419;
  _this setPos [3286.6343, 4329.2891, 0.56428796];
};

_vehicle_12 = objNull;
if (true) then
{
  _this = createVehicle ["Land_transport_crates_EP1", [3251.7563, 4321.73, 0.57529181], [], 0, "CAN_COLLIDE"];
  _vehicle_12 = _this;
  _this setDir 62.511784;
  _this setPos [3251.7563, 4321.73, 0.57529181];
};

_vehicle_14 = objNull;
if (true) then
{
  _this = createVehicle ["Land_transport_crates_EP1", [3253.6338, 4322.2935, 0.48515129], [], 0, "CAN_COLLIDE"];
  _vehicle_14 = _this;
  _this setDir -32.240952;
  _this setPos [3253.6338, 4322.2935, 0.48515129];
};

_vehicle_16 = objNull;
if (true) then
{
  _this = createVehicle ["Fort_Crate_wood", [3255.5923, 4322.8442, 0.34055984], [], 0, "CAN_COLLIDE"];
  _vehicle_16 = _this;
  _this setPos [3255.5923, 4322.8442, 0.34055984];
};

_vehicle_18 = objNull;
if (true) then
{
  _this = createVehicle ["Fort_Crate_wood", [3255.6204, 4322.8931, 1.3048257], [], 0, "CAN_COLLIDE"];
  _vehicle_18 = _this;
  _this setPos [3255.6204, 4322.8931, 1.3048257];
};

_vehicle_21 = objNull;
if (true) then
{
  _this = createVehicle ["Fort_Crate_wood", [3255.594, 4322.9404, 2.2629647], [], 0, "CAN_COLLIDE"];
  _vehicle_21 = _this;
  _this setPos [3255.594, 4322.9404, 2.2629647];
};

_vehicle_23 = objNull;
if (true) then
{
  _this = createVehicle ["Fort_Crate_wood", [3254.2336, 4322.4087, 1.2188364], [], 0, "CAN_COLLIDE"];
  _vehicle_23 = _this;
  _this setDir 59.520306;
  _this setPos [3254.2336, 4322.4087, 1.2188364];
};

_vehicle_30 = objNull;
if (true) then
{
  _this = createVehicle ["Land_transport_crates_EP1", [3259.781, 4315.7285, 0.64216352], [], 0, "CAN_COLLIDE"];
  _vehicle_30 = _this;
  _this setDir -112.03973;
  _this setPos [3259.781, 4315.7285, 0.64216352];
};

_vehicle_31 = objNull;
if (true) then
{
  _this = createVehicle ["Land_transport_crates_EP1", [3257.8586, 4315.3428, 0.55202222], [], 0, "CAN_COLLIDE"];
  _vehicle_31 = _this;
  _this setDir -206.79245;
  _this setPos [3257.8586, 4315.3428, 0.55202222];
};

_vehicle_32 = objNull;
if (true) then
{
  _this = createVehicle ["Fort_Crate_wood", [3255.8528, 4314.9795, 0.40743008], [], 0, "CAN_COLLIDE"];
  _vehicle_32 = _this;
  _this setDir -174.55148;
  _this setPos [3255.8528, 4314.9795, 0.40743008];
};

_vehicle_33 = objNull;
if (true) then
{
  _this = createVehicle ["Fort_Crate_wood", [3255.8218, 4314.9346, 1.371696], [], 0, "CAN_COLLIDE"];
  _vehicle_33 = _this;
  _this setDir -174.55148;
  _this setPos [3255.8218, 4314.9346, 1.371696];
};

_vehicle_34 = objNull;
if (true) then
{
  _this = createVehicle ["Fort_Crate_wood", [3257.2515, 4315.2852, 1.2857068], [], 0, "CAN_COLLIDE"];
  _vehicle_34 = _this;
  _this setDir -115.0312;
  _this setPos [3257.2515, 4315.2852, 1.2857068];
};

_vehicle_41 = objNull;
if (true) then
{
  _this = createVehicle ["Fort_Crate_wood", [3256.3374, 4321.8462, 0.3720504], [], 0, "CAN_COLLIDE"];
  _vehicle_41 = _this;
  _this setDir -58.667538;
  _this setPos [3256.3374, 4321.8462, 0.3720504];
};

_vehicle_43 = objNull;
if (true) then
{
  _this = createVehicle ["Fort_Crate_wood", [3259.4753, 4316.3022, 1.3760678], [], 0, "CAN_COLLIDE"];
  _vehicle_43 = _this;
  _this setDir -26.302923;
  _this setPos [3259.4753, 4316.3022, 1.3760678];
};

_vehicle_45 = objNull;
if (true) then
{
  _this = createVehicle ["Land_transport_cart_EP1", [3258.8701, 4326.3232, 0.34338734], [], 0, "CAN_COLLIDE"];
  _vehicle_45 = _this;
  _this setDir -121.63935;
  _this setPos [3258.8701, 4326.3232, 0.34338734];
};

_vehicle_47 = objNull;
if (true) then
{
  _this = createVehicle ["Fuel_can", [3258.9465, 4324.7036, 0.47483286], [], 0, "CAN_COLLIDE"];
  _vehicle_47 = _this;
  _this setPos [3258.9465, 4324.7036, 0.47483286];
};

_vehicle_49 = objNull;
if (true) then
{
  _this = createVehicle ["Fuel_can", [3258.4988, 4324.626, 0.47946545], [], 0, "CAN_COLLIDE"];
  _vehicle_49 = _this;
  _this setDir -34.419144;
  _this setPos [3258.4988, 4324.626, 0.47946545];
};

_vehicle_52 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Ind_BoardsPack1", [3257.0205, 4318.0542, 0.42501885], [], 0, "CAN_COLLIDE"];
  _vehicle_52 = _this;
  _this setDir 68.24408;
  _this setPos [3257.0205, 4318.0542, 0.42501885];
};

_vehicle_54 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Ind_BoardsPack1", [3255.4492, 4319.8452, 0.44043791], [], 0, "CAN_COLLIDE"];
  _vehicle_54 = _this;
  _this setDir -204.38309;
  _this setPos [3255.4492, 4319.8452, 0.44043791];
};

_vehicle_58 = objNull;
if (true) then
{
  _this = createVehicle ["Fuel_can", [3260.9331, 4315.521, 0.51495749], [], 0, "CAN_COLLIDE"];
  _vehicle_58 = _this;
  _this setDir 66.618233;
  _this setPos [3260.9331, 4315.521, 0.51495749];
};

_vehicle_59 = objNull;
if (true) then
{
  _this = createVehicle ["Fuel_can", [3260.6887, 4315.8999, 0.51959044], [], 0, "CAN_COLLIDE"];
  _vehicle_59 = _this;
  _this setDir 32.199078;
  _this setPos [3260.6887, 4315.8999, 0.51959044];
};

_vehicle_64 = objNull;
if (true) then
{
  _this = createVehicle ["Fuel_can", [3265.3445, 4321.0508, 0.62099099], [], 0, "CAN_COLLIDE"];
  _vehicle_64 = _this;
  _this setDir -5.8035383;
  _this setPos [3265.3445, 4321.0508, 0.62099099];
};

_vehicle_65 = objNull;
if (true) then
{
  _this = createVehicle ["Fuel_can", [3264.9116, 4320.9297, 0.62562394], [], 0, "CAN_COLLIDE"];
  _vehicle_65 = _this;
  _this setDir -40.222687;
  _this setPos [3264.9116, 4320.9297, 0.62562394];
};

_vehicle_68 = objNull;
if (true) then
{
  _this = createVehicle ["Fuel_can", [3284.3059, 4328.2788, 0.48749527], [], 0, "CAN_COLLIDE"];
  _vehicle_68 = _this;
  _this setDir 91.052124;
  _this setPos [3284.3059, 4328.2788, 0.48749527];
};

_vehicle_69 = objNull;
if (true) then
{
  _this = createVehicle ["Fuel_can", [3284.2397, 4328.7256, 0.49212822], [], 0, "CAN_COLLIDE"];
  _vehicle_69 = _this;
  _this setDir 56.63295;
  _this setPos [3284.2397, 4328.7256, 0.49212822];
};

_vehicle_72 = objNull;
if (true) then
{
  _this = createVehicle ["Fuel_can", [3284.0486, 4328.1787, 0.44909739], [], 0, "CAN_COLLIDE"];
  _vehicle_72 = _this;
  _this setDir 91.052124;
  _this setPos [3284.0486, 4328.1787, 0.44909739];
};

_vehicle_73 = objNull;
if (true) then
{
  _this = createVehicle ["Fuel_can", [3283.9822, 4328.625, 0.45373031], [], 0, "CAN_COLLIDE"];
  _vehicle_73 = _this;
  _this setDir 56.63295;
  _this setPos [3283.9822, 4328.625, 0.45373031];
};

_vehicle_76 = objNull;
if (true) then
{
  _this = createVehicle ["Barrels", [3277.8933, 4335.3784, 1.0420724], [], 0, "CAN_COLLIDE"];
  _vehicle_76 = _this;
  _this setPos [3277.8933, 4335.3784, 1.0420724];
};

_vehicle_78 = objNull;
if (true) then
{
  _this = createVehicle ["Barrels", [3278.5347, 4333.6494, 0.91646564], [], 0, "CAN_COLLIDE"];
  _vehicle_78 = _this;
  _this setDir -30.270336;
  _this setPos [3278.5347, 4333.6494, 0.91646564];
};

_vehicle_80 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Misc_Cargo2E_EP1", [3210.4077, 4596.2461, 0.031939931], [], 0, "CAN_COLLIDE"];
  _vehicle_80 = _this;
  _this setDir 49.751228;
  _this setPos [3210.4077, 4596.2461, 0.031939931];
};

_vehicle_82 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Misc_Cargo2E_EP1", [3205.5979, 4592.2593, -0.18713601], [], 0, "CAN_COLLIDE"];
  _vehicle_82 = _this;
  _this setDir 49.751228;
  _this setPos [3205.5979, 4592.2593, -0.18713601];
};

_vehicle_84 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Misc_Cargo2E_EP1", [3206.6057, 4587.6729, -0.17495528], [], 0, "CAN_COLLIDE"];
  _vehicle_84 = _this;
  _this setDir -40.663574;
  _this setPos [3206.6057, 4587.6729, -0.17495528];
};

_vehicle_86 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Misc_Cargo2E_EP1", [3213.4204, 4589.3789, -0.21126302], [], 0, "CAN_COLLIDE"];
  _vehicle_86 = _this;
  _this setDir 44.819069;
  _this setPos [3213.4204, 4589.3789, -0.21126302];
};

_vehicle_88 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Misc_Cargo2E", [3224.2078, 4592.3555, -0.19815849], [], 0, "CAN_COLLIDE"];
  _vehicle_88 = _this;
  _this setDir -50.0984;
  _this setPos [3224.2078, 4592.3555, -0.19815849];
};

_vehicle_90 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Misc_Cargo2E", [3227.6116, 4596.1563, -0.29385695], [], 0, "CAN_COLLIDE"];
  _vehicle_90 = _this;
  _this setDir -50.0984;
  _this setPos [3227.6116, 4596.1563, -0.29385695];
};

_vehicle_94 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Misc_Cargo2E", [3225.8225, 4594.2578, 0.032954033], [], 0, "CAN_COLLIDE"];
  _vehicle_94 = _this;
  _this setDir -50.0984;
  _this setPos [3225.8225, 4594.2578, 0.032954033];
};

_vehicle_95 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Misc_Cargo2E", [3229.0007, 4598.2759, -0.043492891], [], 0, "CAN_COLLIDE"];
  _vehicle_95 = _this;
  _this setDir -50.0984;
  _this setPos [3229.0007, 4598.2759, -0.043492891];
};

_vehicle_98 = objNull;
if (true) then
{
  _this = createVehicle ["TowingTractor", [3243.4407, 4598.6963, -0.10144795], [], 0, "CAN_COLLIDE"];
  _vehicle_98 = _this;
  _this setDir 42.475208;
  _this setPos [3243.4407, 4598.6963, -0.10144795];
};

_vehicle_99 = objNull;
if (true) then
{
  _this = createVehicle ["Barrels", [3229.1372, 4602.5708, 0.32421657], [], 0, "CAN_COLLIDE"];
  _vehicle_99 = _this;
  _this setPos [3229.1372, 4602.5708, 0.32421657];
};

_vehicle_101 = objNull;
if (true) then
{
  _this = createVehicle ["Barrels", [3231.5469, 4601.6372, 0.29629824], [], 0, "CAN_COLLIDE"];
  _vehicle_101 = _this;
  _this setPos [3231.5469, 4601.6372, 0.29629824];
};

_vehicle_103 = objNull;
if (true) then
{
  _this = createVehicle ["Misc_palletsfoiled", [3219.5645, 4602.563, 1.3103582], [], 0, "CAN_COLLIDE"];
  _vehicle_103 = _this;
  _this setDir 37.779156;
  _this setPos [3219.5645, 4602.563, 1.3103582];
};

_vehicle_105 = objNull;
if (true) then
{
  _this = createVehicle ["Misc_palletsfoiled", [3220.825, 4601.6753, 1.3067478], [], 0, "CAN_COLLIDE"];
  _vehicle_105 = _this;
  _this setDir 34.460693;
  _this setPos [3220.825, 4601.6753, 1.3067478];
};

_vehicle_109 = objNull;
if (true) then
{
  _this = createVehicle ["Misc_palletsfoiled", [3219.4688, 4602.3975, 0.048833281], [], 0, "CAN_COLLIDE"];
  _vehicle_109 = _this;
  _this setDir 36.47261;
  _this setPos [3219.4688, 4602.3975, 0.048833281];
};

_vehicle_110 = objNull;
if (true) then
{
  _this = createVehicle ["Misc_palletsfoiled", [3220.8223, 4601.6538, 0.0051404499], [], 0, "CAN_COLLIDE"];
  _vehicle_110 = _this;
  _this setDir 33.408531;
  _this setPos [3220.8223, 4601.6538, 0.0051404499];
};

processInitCommands;
}; 
