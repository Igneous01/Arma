////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Sapphire, v1.063, #Wyzuja)
////////////////////////////////////////////////////////

class HUDLONGRANGE : ignDisplay {
	idd = 8999;
	fadeout=0;
	fadein=0;
	duration = 9999999;
	name = "HUDLONGRANGE";
	onLoad = "uiNamespace setVariable ['HUDLONGRANGE', (_this select 0)]";
	class controlsBackground 
	{
		class hud_bg: ignBackground
		{
			idc = 2200;
			x = 0.0378125 * safezoneW + safezoneX;
			y = 0.0749805 * safezoneH + safezoneY;
			w = 0.135469 * safezoneW;
			h = 0.153007 * safezoneH;
			colorBackground[] = {0,0,0,0.75};
		};
		class hud_frame: ignFrame
		{
			idc = 1800;
			text = "Status"; //--- ToDo: Localize;
			x = 0.0457813 * safezoneW + safezoneX;
			y = 0.0749805 * safezoneH + safezoneY;
			w = 0.119531 * safezoneW;
			h = 0.136006 * safezoneH;
			colorText[] = {1,1,-1,1};
			sizeEx = 0.7 * GUI_GRID_H;
		};
		class hud_txtRound: ignText
		{
			idc = 1000;
			text = "Round:"; //--- ToDo: Localize;
			x = 0.05375 * safezoneW + safezoneX;
			y = 0.108982 * safezoneH + safezoneY;
			w = 0.095625 * safezoneW;
			h = 0.0170008 * safezoneH;
			colorText[] = {1,1,-1,1};
			colorBackground[] = {-1,-1,-1,-1};
			sizeEx = 0.50 * GUI_GRID_H;
		};
		class hud_txtshotsRemain: ignText
		{
			idc = 1001;
			text = "Shots Left:"; //--- ToDo: Localize;
			x = 0.05375 * safezoneW + safezoneX;
			y = 0.142984 * safezoneH + safezoneY;
			w = 0.095625 * safezoneW;
			h = 0.0170008 * safezoneH;
			colorText[] = {1,1,-1,1};
			colorBackground[] = {-1,-1,-1,-1};
			sizeEx = 0.50 * GUI_GRID_H;
		};
		class hud_txtTimeRemain: ignText
		{
			idc = 1002;
			text = "Time Left:"; //--- ToDo: Localize;
			x = 0.05375 * safezoneW + safezoneX;
			y = 0.176985 * safezoneH + safezoneY;
			w = 0.095625 * safezoneW;
			h = 0.0170008 * safezoneH;
			colorText[] = {1,1,-1,1};
			colorBackground[] = {-1,-1,-1,-1};
			sizeEx = 0.50 * GUI_GRID_H;
		};
	};
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
