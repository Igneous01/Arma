/*
* Efnc_createLight 
* creates a light object with specified parameters and position
* lightobj = [position, [red, green, blue], intensity] call Efnc_createLight
* position: array - format position
* red, green, blue: float - number from 0.0 to 1.0
* intensity: float - number from 0.0 to 1.0 (dim <-> bright)
* returns light object
* Example: redLight = [getpos player, [1.0, 0.0, 0.0], 1.0] call Efnc_createLight
*/

private ["_light", "_pos", "_colorArray", "_brightness"];
_pos = _this select 0; // position 
_colorArray = _this select 1; // color array
_brightness = _this select 2; // brightness
_light= "#lightpoint" createVehicleLocal _pos;  
_light setLightBrightness _brightness; 
_light setLightAmbient _colorArray;  
_light setLightColor _colorArray;  
_light
