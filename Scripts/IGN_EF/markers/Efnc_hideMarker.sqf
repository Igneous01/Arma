/*
* Efnc_hideMarker
* hide/show marker on map 
* [marker, hide] call Efnc_hideMarker
* marker: marker - the marker 
* hide: boolean - true hides the marker, false shows the marker 
* returns: nothing
*/

private ["_marker", "_hide"];
_marker = _this select 0;
_hide = _this select 1;
if (_hide) then 
{
	_marker setMarkerAlpha 0;
}
else
{
	_marker setMarkerAlpha 1;
};
