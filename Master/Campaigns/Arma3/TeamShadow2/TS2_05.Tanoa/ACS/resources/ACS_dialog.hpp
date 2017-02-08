class AdvancedConversationSystem
{
	idd = -1;
	movingenable = false;

	onLoad = "uiNamespace setVariable ['ACS', (_this select 0)]";

	class controls
	{
		class RscFrame_1800: RscFrame
		{
			idc = 1800;
			x = 0.0460786 * safezoneW + safezoneX;
			y = 0.176985 * safezoneH + safezoneY;
			w = 0.637083 * safezoneW;
			h = 0.629029 * safezoneH;
		};
		class RscBackground_1: RscBackground
		{
			idc = -1;
			x = 0.0460786 * safezoneW + safezoneX;
			y = 0.176985 * safezoneH + safezoneY;
			w = 0.637083 * safezoneW;
			h = 0.629029 * safezoneH;
		};
		class RscListbox_1500: RscListbox
		{
			idc = 1500;
			x = 0.0540422 * safezoneW + safezoneX;
			y = 0.227987 * safezoneH + safezoneY;
			w = 0.191125 * safezoneW;
			h = 0.255012 * safezoneH;
		};
		class RscListbox_1501: RscListbox
		{
			idc = 1501;
			x = 0.0540424 * safezoneW + safezoneX;
			y = 0.534001 * safezoneH + safezoneY;
			w = 0.191125 * safezoneW;
			h = 0.255012 * safezoneH;
			
			colorText[] = {1,1,1,0.5};
		};
		class RscListbox_1502: RscListbox
		{
			idc = 1502;
			x = 0.253131 * safezoneW + safezoneX;
			y = 0.193986 * safezoneH + safezoneY;
			w = 0.422067 * safezoneW;
			h = 0.595027 * safezoneH;
			
			colorSelectBackground[] = {0,0,0,0};
			colorSelect[] = {1,1,1,1};
		};
		class RscFrame_1801: RscFrame
		{
			idc = 1801;
			x = 0.0540422 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.191125 * safezoneW;
			h = 0.0340016 * safezoneH;
		};
		class RscTitle_2: RscTitle
		{
			idc = -1;
			x = 0.0540422 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.191125 * safezoneW;
			h = 0.0340016 * safezoneH;
		};
		class RscFrame_1802: RscFrame
		{
			idc = 1802;
			x = 0.0540422 * safezoneW + safezoneX;
			y = 0.193986 * safezoneH + safezoneY;
			w = 0.191125 * safezoneW;
			h = 0.0340016 * safezoneH;
		};
		class RscTitle_3: RscTitle
		{
			idc = -1;
			x = 0.0540422 * safezoneW + safezoneX;
			y = 0.193986 * safezoneH + safezoneY;
			w = 0.191125 * safezoneW;
			h = 0.0340016 * safezoneH;
		};
		class RscText_1000: RscText
		{
			idc = 1000;
			text = "New:"; //--- ToDo: Localize;
			x = 0.0540422 * safezoneW + safezoneX;
			y = 0.193986 * safezoneH + safezoneY;
			w = 0.191125 * safezoneW;
			h = 0.0340016 * safezoneH;
		};
		class RscText_1001: RscText
		{
			idc = 1001;
			text = "Used:"; //--- ToDo: Localize;
			x = 0.0540422 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.191125 * safezoneW;
			h = 0.0340016 * safezoneH;
		};
		class RscButton_2700: RscButton
		{
			idc = 2700;
			text = "End Conversation"; //--- ToDo: Localize;
			x = 0.531854 * safezoneW + safezoneX;
			y = 0.806014 * safezoneH + safezoneY;
			w = 0.151307 * safezoneW;
			h = 0.0340016 * safezoneH;
		};
	};
};