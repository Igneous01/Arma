/////////////////////////////////////
// Function file for Armed Assault //
//    Created by: DreadedEntity    //
/////////////////////////////////////

#define ACS_DIALOG (uiNamespace getVariable "ACS")

unit = (_this select 0);
soundPlaying = false;

createDialog "AdvancedConversationSystem";
waitUntil {!isNil {ACS_DIALOG}};

//ACS_noEscape = (findDisplay 46) displayAddEventHandler ["KeyDown",
//{
//	private "_handled";
//	_handled = false;
//	if ((_this select 1) == 1) then
//	{
//		_handled = true;
//	};
//	_handled;
//}];
//players can still press escape to close dialog, then they are never able to press escape again

refreshLBS =
{
	private ["_topics","_completed","_progress","_index1500","_index1501","_checked","_available","_topics1500","_topics1501"];
	lbClear 1500;
	lbClear 1501;
	lbSetCurSel [1500, -1];
	lbSetCurSel [1501, -1];
	_topics = unit getVariable ["ACS_Topics", [[[0,0],"No Topics","There are no topics.", nil, nil]]];
	_completed = unit getVariable ["ACS_Completed", []];
	_progress = unit getVariable ["ACS_QuestProgress", []];
	_index1500 = [];
	_index1501 = [];
	_topics1500 = [];
	_topics1501 = [];
	_checked = [];
	{
		if !(((_x select 0) select 0) in _checked) then
		{
			_available = ((_x select 0) select 0) call lowestFlag;
			_checked pushBack ((_x select 0) select 0);
			{
				lbAdd [1500,_x select 1];
				_index1500 pushBack (_topics find _x);
				_topics1500 pushBack _x;
			}forEach _available;
		};
		if (_x in _completed) then
		{
			lbAdd [1501,_x select 1];
			_index1501 pushBack _forEachIndex;
			_topics1501 pushBack _x;
		};
	}forEach _topics;
//	hint str [_index1500,_index1501]; debug
	[_index1500,_index1501,_topics1500,_topics1501];
};
setQuestProgress =
{
	private ["_flag","_progress","_testElement","_highestProgress"];
	_flag = (_this select 0);
	_progress = unit getVariable ["ACS_QuestProgress", [[-1,-1]]];
	_testElement = 0;
	_highestProgress = 0;
	{
		if (_flag select 0 != _x select 0) then
		{
			_testElement = _testElement + 1;
		}else
		{
			if (_flag select 1 > _x select 1) then
			{
				_progress set [_forEachIndex, _flag];
			};
		};
	}forEach _progress;
	if (_testElement == count _progress) then
	{
		unit setVariable ["ACS_QuestProgress", _progress pushBack _flag];
	};
	unit setVariable ["ACS_QuestProgress", _progress];
	true;
};
lowestFlag =
{
	private ["_topics","_completed","_available","_progress"];
	_topics = unit getVariable "ACS_Topics";
	_completed = unit getVariable ["ACS_Completed", []];
	_available = [];
	_progress = 999999; //I doubt anyone will have conversations longer than this
	{
		if (((_x select 0) select 0 == _this) && {((_x select 0) select 1) < _progress}) then
		{
			_progress = (_x select 0) select 1;
		};
	}forEach (_topics - _completed);
	{
		if (((_x select 0) select 0 == _this) && {((_x select 0) select 1) == _progress}) then
		{
			_available pushBack _x;
		};
	}forEach (_topics - _completed);
	_available;
};
write1502 =
{
	_message = _this;
	_characters = (count _message) - 1;
	_current = 0;
	_packet = 0;
	while {_characters > 0} do
	{
		if (_characters > 48) then
		{
			_chunk = [_message, _current, _current + 47] call BIS_fnc_trimString;
			_current = _current + 48;
			_packet = _packet + 1;
			_characters = _characters - 48;
			_index = lbAdd [1502, _chunk];
			lbSetCurSel [1502, _index];
		}else
		{
			_chunk = [_message, _current, _current + _characters] call BIS_fnc_trimString;
			_packet = _packet + 1;
			_characters = -1;
			_index = lbAdd [1502, _chunk];
			lbSetCurSel [1502, _index];
		};
	};
};
makeTitle =
{
	private "_title";
	_title = _this;
	_title = "| " + _title + " |";
	while {count _title < 52} do
	{
		_title = "-" + _title + "-";
		if (count _title == 51) then
		{
			_title = _title + "-";
		};
	};
	_title;
};

indexes = call refreshLBS;

lbSetCurSel [1501, -1];

(ACS_DIALOG displayCtrl 1500) ctrlAddEventHandler ["MouseButtonDown",
{
	lbClear 1501;
	lbSetCurSel [1501, -1];
	_topics = indexes select 3;
	{
		lbAdd [1501, _x select 1];
	}forEach _topics;
}];
(ACS_DIALOG displayCtrl 1501) ctrlAddEventHandler ["MouseButtonDown",
{
	lbClear 1500;
	lbSetCurSel [1500, -1];
	_topics = indexes select 2;
	{
		lbAdd [1500, _x select 1];
	}forEach _topics;
}];
 //These were supposed to de-select the other LBs when you click on one, but it doesn't fucking work as usual


(ACS_DIALOG displayCtrl 1500) ctrlAddEventHandler ["LBDblClick",
{
	private ["_i","_selected","_index","_title"];
	if !(soundPlaying) then
	{
	_i = (_this select 1);
	_selected = (unit getVariable "ACS_Topics") select ((indexes select 0) select _i);
	unit setVariable ["ACS_Completed", (unit getVariable ["ACS_Completed",[]]) + [_selected]];
	
	_title = (_selected select 1) call makeTitle;
	lbAdd [1502, _title];
	(_selected select 2) call write1502;

	if !(isNil {_selected select 3}) then
	{
		switch (typeName (_selected select 3)) do
		{
			case "ARRAY":
			{
				switch (typeName ((_selected select 3) select 1)) do
				{
					case "STRING":
					{
						if !(isNil {(_selected select 3) select 0}) then
						{
							((_selected select 3) select 0) execVM format ["ACS\ACS_scripts\%1", (_selected select 3) select 1];
						}else
						{
							[] execVM format ["ACS\ACS_scripts\%1", (_selected select 3) select 1];
						};
					};
					case "CODE":
					{
						if !(isNil {(_selected select 3) select 0}) then
						{
							((_selected select 3) select 0) call ((_selected select 3) select 1);
						}else
						{
							call ((_selected select 3) select 1);
						};
					};
					default {};
				};
			};
			default {hintSilent 'Improper Argument. Must be either code or array containing data and string name of script (include ".sqf")';};
		};
	};
	if !(isNil {_selected select 4}) then
	{
		if (typeName(_selected select 4) == "ARRAY") then
		{
			(_selected select 4) spawn
			{
				{
					switch (_x select 1) do
					{
						case "target":
						{
							playSound3D [_x select 0, unit];
							soundPlaying = true;
						};
						case "caller":
						{
							playSound3D [_x select 0, player];
							soundPlaying = true;
						};
						default
						{
							playSound3D [_x select 0, _x select 1];
							soundPlaying = true;
						};
					};
					if !(isNil {_x select 2}) then
					{
						sleep (_x select 2);
						if (_forEachIndex == (count _this) - 1) then
						{
							soundPlaying = false;
						};
					};
				}forEach (_this);
				soundPlaying = false;
			};
		};
	};
	[_selected select 0] call setQuestProgress;
		
	indexes = call refreshLBS;
	};
}];
(ACS_DIALOG displayCtrl 1501) ctrlAddEventHandler ["LBDblClick",
{
	private ["_i","_selected"];
	_i = (_this select 1);
	_selected = (unit getVariable "ACS_Topics") select ((indexes select 1) select _i);
	
	lbAdd [1502, format ["-[%1]-", _selected select 1]];
	(_selected select 2) call write1502;
	
	indexes = call refreshLBS;
}];

(ACS_DIALOG displayCtrl 2700) ctrlAddEventHandler ["ButtonClick",
{
	//(findDisplay 46) displayRemoveEventHandler ["KeyDown",ACS_noEscape]; doesn't work
	closeDialog 0;
}];

//ACS requires ArmaPilot's Ferrari Addon