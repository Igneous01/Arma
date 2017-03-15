#define TEXTLINE1 1100
#define TEXTLINE2 1101
#define TEXTLINE3 1102
#define TEXTLINE4 1103

class HUDTIMETRIAL : ignDisplay 
{
	idd = 8999;
	fadeout=0;
	fadein=0;
	duration = 9999999;
	name = "HUDLONGRANGE";
	onLoad = "uiNamespace setVariable ['HUDTIMETRIAL', (_this select 0)]";
	class controlsBackground 
	{
		class TTTextLine1: RscStructuredText
		{
			idc = TEXTLINE1;
			text = "Time: 00:00.00"; //--- ToDo: Localize;
			x = 0.786875 * safezoneW + safezoneX;
			y = 0.789013 * safezoneH + safezoneY;
			w = 0.167344 * safezoneW;
			h = 0.0340016 * safezoneH;
			colorText[] = {0.75,0.75,0.75,1};
			sizeEx = 0.2 * GUI_GRID_H;
		};
		class TTTextLine2: RscStructuredText
		{
			idc = TEXTLINE2;
			text = "Targets: 3"; //--- ToDo: Localize;
			x = 0.786875 * safezoneW + safezoneX;
			y = 0.823015 * safezoneH + safezoneY;
			w = 0.167344 * safezoneW;
			h = 0.0340016 * safezoneH;
			colorText[] = {0.75,0.75,0.75,1};
			sizeEx = 0.2 * GUI_GRID_H;
		};
		class TTTextLine3: RscStructuredText
		{
			idc = TEXTLINE3;
			text = "Penalty: +01:15.00"; //--- ToDo: Localize;
			x = 0.786875 * safezoneW + safezoneX;
			y = 0.857016 * safezoneH + safezoneY;
			w = 0.167344 * safezoneW;
			h = 0.0340016 * safezoneH;
			colorText[] = {0.75,0.75,0.75,1};
			sizeEx = 0.2 * GUI_GRID_H;
		};
		class TTTextLine4: RscStructuredText
		{
			idc = TEXTLINE4;
			text = "Bonus: -05.00"; //--- ToDo: Localize;
			x = 0.786875 * safezoneW + safezoneX;
			y = 0.891018 * safezoneH + safezoneY;
			w = 0.167344 * safezoneW;
			h = 0.0340016 * safezoneH;
			colorText[] = {0.75,0.75,0.75,1};
			sizeEx = 0.2 * GUI_GRID_H;
		};
	};
};
