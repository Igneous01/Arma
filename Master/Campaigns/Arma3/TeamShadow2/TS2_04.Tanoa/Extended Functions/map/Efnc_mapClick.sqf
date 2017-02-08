/*
* Efnc_mapClick
* This returns the variables passed by onMapSingleClick, without the need to have global vars created to do something
* Also has a locking feature, preventing duplicate mapClicks from occuring at the same time
* [] call Efnc_mapClick
* Input: none
* returns array [_pos, _units, _shift, _alt] obtained from onmapsingleclick (see documentation of onMapSingleClick to see what these values mean)
* Ex: artilleryPos = ([] call Efnc_mapClick) select 0;
*/

private ["_return"];
_return = [];	// init the return

// if the variable is defined, script is already running, lock the instance of the script, until the other is finished. (thread safety)
if (!isNil "EFNC_MAPCLICK_LOCK") exitWith {};

EFNC_MAPCLICK_STRING = "";
EFNC_MAPCLICK_LOCK = true;	// lock is true (engaged)

// mouse click
onMapSingleClick {
	onMapSingleClick {};
	EFNC_MAPCLICK_LOCK = false;
	EFNC_MAPCLICK_STRING = format ["_return = [%1, %2, %3, %4]", _pos, _units, _shift, _alt];	// get the vars from mapclick
};

waitUntil {!EFNC_MAPCLICK_LOCK};	// waits until the map is clicked

call compile EFNC_MAPCLICK_STRING;	// run this code

// destroy these vars
EFNC_MAPCLICK_STRING = nil;
EFNC_MAPCLICK_LOCK = nil;

_return;	// return the values




