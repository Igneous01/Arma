
// OPTIONS DIALOG MACROS

// Macro IDC's
#define IDD_OPTIONS 4050

#define IDC_OPTIONSDIALOG_BACKGROUND 4051
#define IDC_OPTIONSDIALOG_TEXT_TITLE 4052

#define IDC_OPTIONSDIALOG_TEXT_TIME 4053
#define IDC_OPTIONSDIALOG_TEXT_WEATHER 4054
#define IDC_OPTIONSDIALOG_TEXT_FORECAST 4055
#define IDC_OPTIONSDIALOG_TEXT_AA_CHANCE 4056
#define IDC_OPTIONSDIALOG_TEXT_CAS_CHANCE 4057
#define IDC_OPTIONSDIALOG_TEXT_CAS_RESPONSE 4058
#define IDC_OPTIONSDIALOG_TEXT_MECH_CHANCE 4059
#define IDC_OPTIONSDIALOG_TEXT_MECH_PREFER 4060

#define IDC_OPTIONSDIALOG_FRAME_MISSION 4061
#define IDC_OPTIONSDIALOG_FRAME_ENEMY 4062
#define IDC_OPTIONSDIALOG_FRAME_MECH 4063

#define IDC_OPTIONSDIALOG_CB_TIME 4064
#define IDC_OPTIONSDIALOG_CB_WEATHER 4065
#define IDC_OPTIONSDIALOG_CB_FORECAST 4066
#define IDC_OPTIONSDIALOG_CB_AA_CHANCE 4067
#define IDC_OPTIONSDIALOG_CB_CAS_CHANCE 4068
#define IDC_OPTIONSDIALOG_CB_CAS_RESPONSE 4069
#define IDC_OPTIONSDIALOG_CB_MECH_CHANCE 4070
#define IDC_OPTIONSDIALOG_CB_MECH_PART 4071

#define IDC_OPTIONSDIALOG_BUTTON_OK 4072

class OPTIONS_GUI : ignDisplay {
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
	class Background: ignBackground
	{
		idc = IDC_OPTIONSDIALOG_BACKGROUND;
		x = 0.324029 * safezoneW + safezoneX;
		y = 0.108982 * safezoneH + safezoneY;
		w = 0.311948 * safezoneW;
		h = 0.816037 * safezoneH;
	};



	// FRAMES
	class Frame_Mech: ignFrame
	{
		idc = IDC_OPTIONSDIALOG_FRAME_MECH;
		text = "Mechanical Failures"; //--- ToDo: Localize;
		x = 0.356024 * safezoneW + safezoneX;
		y = 0.687009 * safezoneH + safezoneY;
		w = 0.247959 * safezoneW;
		h = 0.136006 * safezoneH;
		//colorText[] = {1,1,1,1};
		sizeEx = 0.6 * GUI_GRID_H;
	};
	class Frame_Mission: ignFrame
	{
		idc = IDC_OPTIONSDIALOG_FRAME_MISSION;
		text = "Mission"; //--- ToDo: Localize;
		x = 0.356024 * safezoneW + safezoneX;
		y = 0.210987 * safezoneH + safezoneY;
		w = 0.247959 * safezoneW;
		h = 0.204009 * safezoneH;
		//colorText[] = {1,1,1,1};
		sizeEx = 0.6 * GUI_GRID_H;
	};
	class Frame_Enemy: ignFrame
	{
		idc = IDC_OPTIONSDIALOG_FRAME_ENEMY;
		text = "Enemy"; //--- ToDo: Localize;
		x = 0.356024 * safezoneW + safezoneX;
		y = 0.448998 * safezoneH + safezoneY;
		w = 0.247959 * safezoneW;
		h = 0.204009 * safezoneH;
		//colorText[] = {1,1,1,1};
		sizeEx = 0.6 * GUI_GRID_H;
	};



	// TEXT LABELS
	class Text_Title: ignText
	{
		idc = IDC_OPTIONSDIALOG_TEXT_TITLE;
		text = "Options"; //--- ToDo: Localize;
		x = 0.436011 * safezoneW + safezoneX;
		y = 0.125983 * safezoneH + safezoneY;
		w = 0.0799868 * safezoneW;
		h = 0.0510023 * safezoneH;
		//colorText[] = {1,1,1,1};
		sizeEx = 1.2 * GUI_GRID_H;
	};
	class Text_Time: ignText
	{
		idc = IDC_OPTIONSDIALOG_TEXT_TIME;
		text = "Time:"; //--- ToDo: Localize;
		x = 0.356024 * safezoneW + safezoneX;
		y = 0.244988 * safezoneH + safezoneY;
		w = 0.0639894 * safezoneW;
		h = 0.0340016 * safezoneH;
		//colorText[] = {1,1,1,1};
		sizeEx = 0.7 * GUI_GRID_H;
	};
	class Text_Weather: ignText
	{
		idc = IDC_OPTIONSDIALOG_TEXT_WEATHER;
		text = "Weather:"; //--- ToDo: Localize;
		x = 0.356024 * safezoneW + safezoneX;
		y = 0.312991 * safezoneH + safezoneY;
		w = 0.0639894 * safezoneW;
		h = 0.0340016 * safezoneH;
		//colorText[] = {1,1,1,1};
		sizeEx = 0.7 * GUI_GRID_H;
	};
	class Text_Forecast: ignText
	{
		idc = IDC_OPTIONSDIALOG_TEXT_FORECAST;
		text = "Forecast:"; //--- ToDo: Localize;
		x = 0.356024 * safezoneW + safezoneX;
		y = 0.380995 * safezoneH + safezoneY;
		w = 0.0639894 * safezoneW;
		h = 0.0340016 * safezoneH;
		//colorText[] = {1,1,1,1};
		tooltip = "Weather forecast 1 hour later"; //--- ToDo: Localize;
		sizeEx = 0.7 * GUI_GRID_H;
	};
	class Text_AA_Chance: ignText
	{
		idc = IDC_OPTIONSDIALOG_TEXT_AA_CHANCE;
		text = "AA Probability:"; //--- ToDo: Localize;
		x = 0.356024 * safezoneW + safezoneX;
		y = 0.482999 * safezoneH + safezoneY;
		w = 0.111981 * safezoneW;
		h = 0.0340016 * safezoneH;
		//colorText[] = {1,1,1,1};
		tooltip = "How likely infantry anti-air will spawn"; //--- ToDo: Localize;
		sizeEx = 0.7 * GUI_GRID_H;
	};
	class Text_CAS_Chance: ignText
	{
		idc = IDC_OPTIONSDIALOG_TEXT_CAS_CHANCE;
		text = "CAS Probability:"; //--- ToDo: Localize;
		x = 0.356024 * safezoneW + safezoneX;
		y = 0.551002 * safezoneH + safezoneY;
		w = 0.111981 * safezoneW;
		h = 0.0340016 * safezoneH;
		//colorText[] = {1,1,1,1};
		tooltip = "How likely the enemy will send an aircraft to counter you"; //--- ToDo: Localize;
		sizeEx = 0.7 * GUI_GRID_H;
	};
	class Text_CAS_Response: ignText
	{
		idc = IDC_OPTIONSDIALOG_TEXT_CAS_RESPONSE;
		text = "CAS Response:"; //--- ToDo: Localize;
		x = 0.356024 * safezoneW + safezoneX;
		y = 0.619005 * safezoneH + safezoneY;
		w = 0.111981 * safezoneW;
		h = 0.0340016 * safezoneH;
		//colorText[] = {1,1,1,1};
		tooltip = "How fast will the enemy aircraft arrive to the island"; //--- ToDo: Localize;
		sizeEx = 0.7 * GUI_GRID_H;
	};
	class Text_Mech_Chance: ignText
	{
		idc = IDC_OPTIONSDIALOG_TEXT_MECH_CHANCE;
		text = "Probability:"; //--- ToDo: Localize;
		x = 0.356024 * safezoneW + safezoneX;
		y = 0.72101 * safezoneH + safezoneY;
		w = 0.0959841 * safezoneW;
		h = 0.0340016 * safezoneH;
		//colorText[] = {1,1,1,1};
		tooltip = "How likely the helicopter will encounter mechanical damage"; //--- ToDo: Localize;
		sizeEx = 0.7 * GUI_GRID_H;
	};
	class Text_Mech_Prefer: ignText
	{
		idc = IDC_OPTIONSDIALOG_TEXT_MECH_PREFER;
		text = "Preference:"; //--- ToDo: Localize;
		x = 0.356024 * safezoneW + safezoneX;
		y = 0.789013 * safezoneH + safezoneY;
		w = 0.0959841 * safezoneW;
		h = 0.0340016 * safezoneH;
		//colorText[] = {1,1,1,1};
		tooltip = "The preferred component to be damaged during a malfunction"; //--- ToDo: Localize;
		sizeEx = 0.7 * GUI_GRID_H;
	};



	// COMBO BOXES
	class CB_Time: IgnCombo
	{
		idc = IDC_OPTIONSDIALOG_CB_TIME;
		x = 0.468005 * safezoneW + safezoneX;
		y = 0.244988 * safezoneH + safezoneY;
		w = 0.127979 * safezoneW;
		h = 0.0340016 * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		sizeEx = 0.7 * GUI_GRID_H;
	};
	class CB_Weather: IgnCombo
	{
		idc = IDC_OPTIONSDIALOG_CB_WEATHER;
		x = 0.468005 * safezoneW + safezoneX;
		y = 0.312991 * safezoneH + safezoneY;
		w = 0.127979 * safezoneW;
		h = 0.0340016 * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		sizeEx = 0.7 * GUI_GRID_H;
	};
	class CB_Forecast: IgnCombo
	{
		idc = IDC_OPTIONSDIALOG_CB_FORECAST;
		x = 0.468005 * safezoneW + safezoneX;
		y = 0.380995 * safezoneH + safezoneY;
		w = 0.127979 * safezoneW;
		h = 0.0340016 * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		sizeEx = 0.7 * GUI_GRID_H;
	};
	class CB_AA_Chance: IgnCombo
	{
		idc = IDC_OPTIONSDIALOG_CB_AA_CHANCE;
		x = 0.468005 * safezoneW + safezoneX;
		y = 0.482999 * safezoneH + safezoneY;
		w = 0.127979 * safezoneW;
		h = 0.0340016 * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		sizeEx = 0.7 * GUI_GRID_H;
	};
	class CB_CAS_Chance: IgnCombo
	{
		idc = IDC_OPTIONSDIALOG_CB_CAS_CHANCE;
		x = 0.468005 * safezoneW + safezoneX;
		y = 0.551002 * safezoneH + safezoneY;
		w = 0.127979 * safezoneW;
		h = 0.0340016 * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		sizeEx = 0.7 * GUI_GRID_H;
	};
	class CB_CAS_Response: IgnCombo
	{
		idc = IDC_OPTIONSDIALOG_CB_CAS_RESPONSE;
		x = 0.468005 * safezoneW + safezoneX;
		y = 0.619005 * safezoneH + safezoneY;
		w = 0.127979 * safezoneW;
		h = 0.0340016 * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		sizeEx = 0.7 * GUI_GRID_H;
	};
	class CB_Mech_Chance: IgnCombo
	{
		idc = IDC_OPTIONSDIALOG_CB_MECH_CHANCE;
		x = 0.468005 * safezoneW + safezoneX;
		y = 0.72101 * safezoneH + safezoneY;
		w = 0.127979 * safezoneW;
		h = 0.0340016 * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		sizeEx = 0.7 * GUI_GRID_H;
	};
	class CB_Mech_Part: IgnCombo
	{
		idc = IDC_OPTIONSDIALOG_CB_MECH_PART;
		x = 0.468005 * safezoneW + safezoneX;
		y = 0.789013 * safezoneH + safezoneY;
		w = 0.127979 * safezoneW;
		h = 0.0340016 * safezoneH;
		colorText[] = {0,0,0,1};
		colorBackground[] = {1,1,1,1};
		sizeEx = 0.7 * GUI_GRID_H;
	};



	// BUTTONS
	class Button_OK: IgnButton
	{
		idc = IDC_OPTIONSDIALOG_BUTTON_OK;
		text = "OK"; //--- ToDo: Localize;
		x = 0.436011 * safezoneW + safezoneX;
		y = 0.857016 * safezoneH + safezoneY;
		w = 0.0799868 * safezoneW;
		h = 0.0340016 * safezoneH;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,0.5};
	};
};