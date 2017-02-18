/////////////////////////////////////
// Function file for Armed Assault //
//    Created by: DreadedEntity    //
/////////////////////////////////////

/* All Functions For Users */

//Use this function to standardize array length for your conversation input.
//Prevents you from having to add nil values to prevent script errors from showing up.
ACS_standardize =
{
	private ["_array"];
	_array = _this;
	{
		_x resize 5;
	}forEach _array;
	_array;
};

//Use this function to add 1 or more topics to a unit. Always input Topics as an array of Topics, even if there is only 1.
ACS_addTopic =
{
	private ["_unit","_array"];
	_unit = (_this select 0);
	_array = (_this select 1);
	
	_array = _array call ACS_standardize;
	{
		
		_unit setVariable ["ACS_Topics", (_unit getVariable "ACS_Topics") + [_x]];
	}forEach _array;
	true;
};

//Use this function to remove 1 or more topics from a unit. Accepts flags as a parameter to find topics.
//Always input an array of topic flags, even if there is only 1.
ACS_removeTopic =
{
	private ["_unit","_flags","_all","_current"];
	_unit = (_this select 0);
	_flags = (_this select 1);
	_delete = [_this, 2, true, [false]] call BIS_fnc_param;
	_all = _unit getVariable ["ACS_Topics", []];
	{
		_current = _x;
		{
			if ((_x select 0) isEqualTo _current) then
			{
				_all set [_forEachIndex,"DELETETOPIC"];
			};
		}forEach _all;
	}forEach _flags;
	_all = _all - ["DELETETOPIC"];
	_unit setVariable ["ACS_Topics", _all];
	if (_delete) then
	{
		_all = _unit getVariable ["ACS_Completed", []];
		{
			_current = _x;
			{
				if ((_x select 0) isEqualTo _current) then
				{
					_all set [_forEachIndex,"DELETETOPIC"];
				};
			}forEach _all;
		}forEach _flags;
		_all = _all - ["DELETETOPIC"];
		_unit setVariable ["ACS_Completed", _all];
	};
	true;
};