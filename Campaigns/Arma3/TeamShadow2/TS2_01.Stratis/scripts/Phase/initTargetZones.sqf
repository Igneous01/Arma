
private _t = _this;
// check to see if target has accuracy zones defined
{
	private _tClass = _x select 0;
	//diag_log text format ["typeOf target: %1 class expected: %2", (typeOf _t), _tClass];
	if ((typeOf _t) isEqualTo _tClass) exitWith
	{
		//diag_log text format ["Found target %1 with class %2 - creating zones", _t, _tClass];
		private _tHead = _x select 1;
		private _tTorso = _x select 2;
		// using the same logic as BIS - simply create a dummy object, attach it to the model coordinates, then compute using distance in the HitPart handler to determine if the shot was inside the accuracy zone
		private _zoneHead = "Sign_Sphere10cm_F" createVehicle (getpos _t);
		_zoneHead attachTo [_t, _tHead];
		_zoneHead enableSimulation false;
		_zoneHead hideObject true;
		private _zoneTorso = "Sign_Sphere10cm_F" createVehicle (getpos _t);
		_zoneTorso attachTo [_t, _tTorso];
		_zoneTorso enableSimulation false;
		_zoneTorso hideObject true;
		_t setVariable ["TS2_accuracyZones", [_zoneHead, _zoneTorso]];
	};
} forEach TARGET_ZONE_ARRAY;
