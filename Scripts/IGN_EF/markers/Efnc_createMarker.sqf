/*
* EF_fnc_createMarker
* Creates a marker on the map with various properties
* marker = ["MyMarkerName", "Marker Text To Display", pos, type, color, [radiusX, radiusY], alpha] call EF_fnc_createMarker
* "MyMarkerName": String - name of marker (default value is "default_marker")
* "Marker Text To Display": String - marker text to display (default value is "marker text")
* pos: Array [x, y] or [x, y, z] - marker position (default value is [0, 0, 0])
* type: String - marker type (see cfgMarkers for documentation of additional types) - default is "hd_destroy"
* color: String - color of marker (default value is "ColorBlue")
* [radiusX, radiusY]: Number Array - marker radius, useful if type is "ELLIPSE" for example (default value is [1,1])
* alpha: Number - transparency of marker on map, 0 is hidden, 1 is fully visible (default is 1)
* Returns: String - the variable name of the marker (as was provided in first argument)
*/


fnc_createMarker =
{
	private ["_name", "_text", "_pos", "_type", "_color", "_marker", "_radius", "_alpha"];
	_name = [_this, 0, "default_marker", [""]] call BIS_fnc_param;
	_text = [_this, 1, "marker text", [""]] call BIS_fnc_param;
	_pos = [_this, 2, [0,0,0], [[]], [2,3]] call BIS_fnc_param;
	_type = [_this, 3, "hd_destroy", [""]] call BIS_fnc_param;
	_color = [_this, 4, "ColorBlue", [""]] call BIS_fnc_param;
	_radius = [_this, 5, [1, 1], [[]], [2]] call BIS_fnc_param;
	_alpha = [_this, 6, 1, [0]] call BIS_fnc_param;

	_marker = createMarker [_name, _pos];
	_name setMarkerText _text;
	_name setMarkerType _type;
	_name setMarkerSize _radius;
	_name setMarkerColor _color;
	_name setMarkerAlpha _alpha;

	_marker;
};