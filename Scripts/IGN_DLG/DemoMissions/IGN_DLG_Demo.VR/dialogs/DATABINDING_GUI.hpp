
class DATABINDING_GUI : ignDisplay {
	idd = 7002;
	movingEnable = false;
	controlsBackground[] = { };
	objects[] = { };
	controls[] ={ btnOne, btnTwo, textLabel, listNbox, listbox };
	// TEXT LABELS
	class btnOne: ignEdit
	{
		idc = 7003;
		text = "text1"; //--- ToDo: Localize;
		x = 0.436011 * safezoneW + safezoneX;
		y = 0.125983 * safezoneH + safezoneY;
		w = 0.0799868 * safezoneW;
		h = 0.0510023 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = 1.3 * GUI_GRID_H;
	};
	class btnTwo: ignEdit
	{
		idc = 7004;
		text = "text2"; //--- ToDo: Localize;
		x = 0.436011 * safezoneW + safezoneX;
		y = 0.525983 * safezoneH + safezoneY;
		w = 0.0799868 * safezoneW;
		h = 0.0510023 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = 1.3 * GUI_GRID_H;
	};
	class textLabel: ignEdit
	{
		idc = 7005;
		text = "pic.jpg"; //--- ToDo: Localize;
		x = 0.436011 * safezoneW + safezoneX;
		y = 0.305983 * safezoneH + safezoneY;
		w = 0.0799868 * safezoneW;
		h = 0.0510023 * safezoneH;
		colorText[] = {1,1,1,1};
		sizeEx = 1.3 * GUI_GRID_H;
	};
	class listNbox: ignListNBox
	{
		idc = 7006;
		text = "test";
		x = 0.336011 * safezoneW + safezoneX;
		y = 0.605983 * safezoneH + safezoneY;
		w = 0.199868 * safezoneW;
		h = 0.210023 * safezoneH;
		colorBackground[] = {0, 0, 0, 1};
		//drawSideArrows = 1;
		columns[] = {0.3, 0.6, 0.9};
	};
	class listbox: ignListBox
	{
		idc = 7007;
		text = "test";
		x = 0.736011 * safezoneW + safezoneX;
		y = 0.605983 * safezoneH + safezoneY;
		w = 0.199868 * safezoneW;
		h = 0.210023 * safezoneH;
		colorBackground[] = {0, 0, 0, 1};
		//drawSideArrows = 1;
		//columns[] = {0.3, 0.6, 0.7};
	};
};
