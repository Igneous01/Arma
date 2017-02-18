////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Sapphire, v1.063, #Conaku)
////////////////////////////////////////////////////////

//#include "Options_Dialog_Macros.hpp"


// GRID MACROS
#define GUI_GRID_X	(0)
#define GUI_GRID_Y	(0)
#define GUI_GRID_W	(0.025)
#define GUI_GRID_H	(0.04)
#define GUI_GRID_WAbs	(1)
#define GUI_GRID_HAbs	(1)

class OPTIONS_GUI {
	idd = IDD_OPTIONS;
	movingEnable = false;
	controlsBackground[] = { };
	objects[] = { };
	controls[] ={ 	Background, Frame_Mission, Frame_Enemy, Frame_Mech,
			Text_Title, Text_Time, Text_Weather, Text_Forecast, Text_AA_Chance, Text_CAS_Chance, Text_CAS_Response, Text_Mech_Chance, Text_Mech_Prefer,
			CB_Time, CB_Weather, CB_Forecast, CB_AA_Chance, CB_CAS_Chance, CB_CAS_Response, CB_Mech_Chance, CB_Mech_Part,
			Button_OK
			 };
	
	
	// BACKGROUND
	class Background: IGUIBack
	{
		idc = IDC_OPTIONSDIALOG_BACKGROUND;
		x = 0.324029 * safezoneW + safezoneX;
		y = 0.108982 * safezoneH + safezoneY;
		w = 0.311948 * safezoneW;
		h = 0.816037 * safezoneH;
		colorBackground[] = {0.3,0.3,0,0.5};
	};
	
	
	
	// FRAMES
	class Frame_Mech: RscFrame
	{
		idc = IDC_OPTIONSDIALOG_FRAME_MECH;
		text = "Mechanical Failures"; //--- ToDo: Localize;
		x = 0.356024 * safezoneW + safezoneX;
		y = 0.687009 * safezoneH + safezoneY;
		w = 0.247959 * safezoneW;
		h = 0.136006 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = 0.7 * GUI_GRID_H;
	};
	class Frame_Mission: RscFrame
	{
		idc = IDC_OPTIONSDIALOG_FRAME_MISSION;
		text = "Mission"; //--- ToDo: Localize;
		x = 0.356024 * safezoneW + safezoneX;
		y = 0.210987 * safezoneH + safezoneY;
		w = 0.247959 * safezoneW;
		h = 0.204009 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = 0.7 * GUI_GRID_H;
	};
	class Frame_Enemy: RscFrame
	{
		idc = IDC_OPTIONSDIALOG_FRAME_ENEMY;
		text = "Enemy"; //--- ToDo: Localize;
		x = 0.356024 * safezoneW + safezoneX;
		y = 0.448998 * safezoneH + safezoneY;
		w = 0.247959 * safezoneW;
		h = 0.204009 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = 0.7 * GUI_GRID_H;
	};
	
	
	
	// TEXT LABELS
	class Text_Title: RscText
	{
		idc = IDC_OPTIONSDIALOG_TEXT_TITLE;
		text = "Options"; //--- ToDo: Localize;
		x = 0.436011 * safezoneW + safezoneX;
		y = 0.125983 * safezoneH + safezoneY;
		w = 0.0799868 * safezoneW;
		h = 0.0510023 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = 1.3 * GUI_GRID_H;
	};
	class Text_Time: RscText
	{
		idc = IDC_OPTIONSDIALOG_TEXT_TIME;
		text = "Time:"; //--- ToDo: Localize;
		x = 0.356024 * safezoneW + safezoneX;
		y = 0.244988 * safezoneH + safezoneY;
		w = 0.0639894 * safezoneW;
		h = 0.0340016 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = 0.9 * GUI_GRID_H;
	};
	class Text_Weather: RscText
	{
		idc = IDC_OPTIONSDIALOG_TEXT_WEATHER;
		text = "Weather:"; //--- ToDo: Localize;
		x = 0.356024 * safezoneW + safezoneX;
		y = 0.312991 * safezoneH + safezoneY;
		w = 0.0639894 * safezoneW;
		h = 0.0340016 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = 0.9 * GUI_GRID_H;
	};
	class Text_Forecast: RscText
	{
		idc = IDC_OPTIONSDIALOG_TEXT_FORECAST;
		text = "Forecast:"; //--- ToDo: Localize;
		x = 0.356024 * safezoneW + safezoneX;
		y = 0.380995 * safezoneH + safezoneY;
		w = 0.0639894 * safezoneW;
		h = 0.0340016 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = 0.9 * GUI_GRID_H;
	};
	class Text_AA_Chance: RscText
	{
		idc = IDC_OPTIONSDIALOG_TEXT_AA_CHANCE;
		text = "AA Probability:"; //--- ToDo: Localize;
		x = 0.356024 * safezoneW + safezoneX;
		y = 0.482999 * safezoneH + safezoneY;
		w = 0.111981 * safezoneW;
		h = 0.0340016 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = 0.9 * GUI_GRID_H;
	};
	class Text_CAS_Chance: RscText
	{
		idc = IDC_OPTIONSDIALOG_TEXT_CAS_CHANCE;
		text = "CAS Probability:"; //--- ToDo: Localize;
		x = 0.356024 * safezoneW + safezoneX;
		y = 0.551002 * safezoneH + safezoneY;
		w = 0.111981 * safezoneW;
		h = 0.0340016 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = 0.9 * GUI_GRID_H;
	};
	class Text_CAS_Response: RscText
	{
		idc = IDC_OPTIONSDIALOG_TEXT_CAS_RESPONSE;
		text = "CAS Response:"; //--- ToDo: Localize;
		x = 0.356024 * safezoneW + safezoneX;
		y = 0.619005 * safezoneH + safezoneY;
		w = 0.111981 * safezoneW;
		h = 0.0340016 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = 0.9 * GUI_GRID_H;
	};
	class Text_Mech_Chance: RscText
	{
		idc = IDC_OPTIONSDIALOG_TEXT_MECH_CHANCE;
		text = "Probability:"; //--- ToDo: Localize;
		x = 0.356024 * safezoneW + safezoneX;
		y = 0.72101 * safezoneH + safezoneY;
		w = 0.0959841 * safezoneW;
		h = 0.0340016 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = 0.9 * GUI_GRID_H;
	};
	class Text_Mech_Prefer: RscText
	{
		idc = IDC_OPTIONSDIALOG_TEXT_MECH_PREFER;
		text = "Preference:"; //--- ToDo: Localize;
		x = 0.356024 * safezoneW + safezoneX;
		y = 0.789013 * safezoneH + safezoneY;
		w = 0.0959841 * safezoneW;
		h = 0.0340016 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = 0.9 * GUI_GRID_H;
	};
	
	
	
	// COMBO BOXES
	class CB_Time: RscCombo
	{
		idc = IDC_OPTIONSDIALOG_CB_TIME;
		x = 0.468005 * safezoneW + safezoneX;
		y = 0.244988 * safezoneH + safezoneY;
		w = 0.127979 * safezoneW;
		h = 0.0340016 * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		sizeEx = 0.8 * GUI_GRID_H;
	};
	class CB_Weather: RscCombo
	{
		idc = IDC_OPTIONSDIALOG_CB_WEATHER;
		x = 0.468005 * safezoneW + safezoneX;
		y = 0.312991 * safezoneH + safezoneY;
		w = 0.127979 * safezoneW;
		h = 0.0340016 * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		sizeEx = 0.8 * GUI_GRID_H;
	};
	class CB_Forecast: RscCombo
	{
		idc = IDC_OPTIONSDIALOG_CB_FORECAST;
		x = 0.468005 * safezoneW + safezoneX;
		y = 0.380995 * safezoneH + safezoneY;
		w = 0.127979 * safezoneW;
		h = 0.0340016 * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		sizeEx = 0.8 * GUI_GRID_H;
		tooltip = "Weather forecast 1 hour later"; //--- ToDo: Localize;
	};
	class CB_AA_Chance: RscCombo
	{
		idc = IDC_OPTIONSDIALOG_CB_AA_CHANCE;
		x = 0.468005 * safezoneW + safezoneX;
		y = 0.482999 * safezoneH + safezoneY;
		w = 0.127979 * safezoneW;
		h = 0.0340016 * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		sizeEx = 0.8 * GUI_GRID_H;
		tooltip = "How likely infantry anti-air will spawn"; //--- ToDo: Localize;
	};
	class CB_CAS_Chance: RscCombo
	{
		idc = IDC_OPTIONSDIALOG_CB_CAS_CHANCE;
		x = 0.468005 * safezoneW + safezoneX;
		y = 0.551002 * safezoneH + safezoneY;
		w = 0.127979 * safezoneW;
		h = 0.0340016 * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		sizeEx = 0.8 * GUI_GRID_H;
		tooltip = "How likely the enemy will send an aircraft to counter you"; //--- ToDo: Localize;
	};
	class CB_CAS_Response: RscCombo
	{
		idc = IDC_OPTIONSDIALOG_CB_CAS_RESPONSE;
		x = 0.468005 * safezoneW + safezoneX;
		y = 0.619005 * safezoneH + safezoneY;
		w = 0.127979 * safezoneW;
		h = 0.0340016 * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		sizeEx = 0.8 * GUI_GRID_H;
		tooltip = "How fast will the enemy aircraft arrive to the island"; //--- ToDo: Localize;
	};
	class CB_Mech_Chance: RscCombo
	{
		idc = IDC_OPTIONSDIALOG_CB_MECH_CHANCE;
		x = 0.468005 * safezoneW + safezoneX;
		y = 0.72101 * safezoneH + safezoneY;
		w = 0.127979 * safezoneW;
		h = 0.0340016 * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		sizeEx = 0.8 * GUI_GRID_H;
		tooltip = "How likely the helicopter will encounter mechanical damage after 10 minute intervals"; //--- ToDo: Localize;
	};
	class CB_Mech_Part: RscCombo
	{
		idc = IDC_OPTIONSDIALOG_CB_MECH_PART;
		x = 0.468005 * safezoneW + safezoneX;
		y = 0.789013 * safezoneH + safezoneY;
		w = 0.127979 * safezoneW;
		h = 0.0340016 * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		sizeEx = 0.8 * GUI_GRID_H;
		tooltip = "The preferred component to be damaged during a malfunction"; //--- ToDo: Localize;
	};
	
	
	
	// BUTTONS
	class Button_OK: RscButton
	{
		idc = IDC_OPTIONSDIALOG_BUTTON_OK;
		text = "OK"; //--- ToDo: Localize;
		x = 0.436011 * safezoneW + safezoneX;
		y = 0.857016 * safezoneH + safezoneY;
		w = 0.0799868 * safezoneW;
		h = 0.0340016 * safezoneH;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0.3,0.3,0,0.5};
		onButtonClick = "closeDialog 0;";
	};
};

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
