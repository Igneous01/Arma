////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Sapphire, v1.063, #Doraty)
////////////////////////////////////////////////////////
class TESTGUIDIALOG : ignDisplay
{
	idd = 10000;
	movingEnable = false;
	//controlsBackground[] = { };
	//objects[] = { };
	class controls
	{
		class TestBackground: ignText
		{
			idc = 2200;
			style = 0;
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 0.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 40 * GUI_GRID_W;
			h = 25 * GUI_GRID_H;
			colorBackground[] = {Dlg_Color_Black,0.75};
		};






		class TestControlsGroup: ignControlsGroup
		{
			idc = 2300;
			x = 0.5 * GUI_GRID_W + GUI_GRID_X;
			y = 2 * GUI_GRID_H + GUI_GRID_Y;
			w = 14.5 * GUI_GRID_W;
			h = 9 * GUI_GRID_H;
			
			class Controls
			{
				class TestFrame: ignFrame
				{
					idc = 1800;
					text = "Frame"; //--- ToDo: Localize;
					x = 0.5 * GUI_GRID_W + GUI_GRID_X;
					y = 1.5 * GUI_GRID_H + GUI_GRID_Y;
					w = 14.5 * GUI_GRID_W;
					h = 9.5 * GUI_GRID_H;
				};
				class TestCheckBox1: ignCheckBox
				{
					idc = 2800;
					text = "Checkbox1"; //--- ToDo: Localize;
					x = 1 * GUI_GRID_W + GUI_GRID_X;
					y = 3 * GUI_GRID_H + GUI_GRID_Y;
					w = 1 * GUI_GRID_W;
					h = 1 * GUI_GRID_H;
					tooltip = "Checkbox"; //--- ToDo: Localize;
					sizeEx = 0.5 * GUI_GRID_H;
				};
				class TestCheckbox2: ignCheckBox
				{
					idc = 2801;
					text = "Checkbox2"; //--- ToDo: Localize;
					x = 1 * GUI_GRID_W + GUI_GRID_X;
					y = 5 * GUI_GRID_H + GUI_GRID_Y;
					w = 1 * GUI_GRID_W;
					h = 1 * GUI_GRID_H;
					tooltip = "Checkbox"; //--- ToDo: Localize;
					sizeEx = 0.5 * GUI_GRID_H;
				};
				class TestCheckbox3: ignCheckBox
				{
					idc = 2802;
					text = "Checkbox3"; //--- ToDo: Localize;
					x = 1 * GUI_GRID_W + GUI_GRID_X;
					y = 7 * GUI_GRID_H + GUI_GRID_Y;
					w = 1 * GUI_GRID_W;
					h = 1 * GUI_GRID_H;
					tooltip = "Checkbox"; //--- ToDo: Localize;
					sizeEx = 0.5 * GUI_GRID_H;
				};
				class TestText1: ignText
				{
					idc = 1000;
					text = "Text1"; //--- ToDo: Localize;
					x = 3 * GUI_GRID_W + GUI_GRID_X;
					y = 3 * GUI_GRID_H + GUI_GRID_Y;
					w = 2.5 * GUI_GRID_W;
					h = 1 * GUI_GRID_H;
				};
				class TestText2: ignText
				{
					idc = 1001;
					text = "Text2"; //--- ToDo: Localize;
					x = 3 * GUI_GRID_W + GUI_GRID_X;
					y = 5 * GUI_GRID_H + GUI_GRID_Y;
					w = 2.5 * GUI_GRID_W;
					h = 1 * GUI_GRID_H;
				};
				class TestText3: ignText
				{
					idc = 1002;
					text = "Text3"; //--- ToDo: Localize;
					x = 3 * GUI_GRID_W + GUI_GRID_X;
					y = 7 * GUI_GRID_H + GUI_GRID_Y;
					w = 2.5 * GUI_GRID_W;
					h = 1 * GUI_GRID_H;
				};
				class TestToolbox1: ignTextCheckBoxes
				{
					idc = 2500;
					text = "Toolbox1"; //--- ToDo: Localize;
					x = 6 * GUI_GRID_W + GUI_GRID_X;
					y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
					w = 4 * GUI_GRID_W;
					h = 2 * GUI_GRID_H;
					tooltip = "ToolBox"; //--- ToDo: Localize;
					sizeEx = 0.6 * GUI_GRID_H;
				};
				class TestToolbox2: ignTextCheckBoxes
				{
					idc = 2501;
					text = "Toolbox2"; //--- ToDo: Localize;
					x = 10.5 * GUI_GRID_W + GUI_GRID_X;
					y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
					w = 4 * GUI_GRID_W;
					h = 2 * GUI_GRID_H;
					tooltip = "ToolBox"; //--- ToDo: Localize;
					sizeEx = 0.6 * GUI_GRID_H;
				};
				class TestEdit1: ignEdit
				{
					idc = 1400;
					text = "EditBox1"; //--- ToDo: Localize;
					x = 6 * GUI_GRID_W + GUI_GRID_X;
					y = 5 * GUI_GRID_H + GUI_GRID_Y;
					w = 8.5 * GUI_GRID_W;
					h = 1 * GUI_GRID_H;
				};
				class TestEdit2: ignEdit
				{
					idc = 1401;
					text = "EditBox2"; //--- ToDo: Localize;
					x = 6 * GUI_GRID_W + GUI_GRID_X;
					y = 7 * GUI_GRID_H + GUI_GRID_Y;
					w = 8.5 * GUI_GRID_W;
					h = 1 * GUI_GRID_H;
				};
				class TestButton: ignButton
				{
					idc = 1600;
					text = "Button1"; //--- ToDo: Localize;
					x = 1 * GUI_GRID_W + GUI_GRID_X;
					y = 9 * GUI_GRID_H + GUI_GRID_Y;
					w = 3.5 * GUI_GRID_W;
					h = 1 * GUI_GRID_H;
				};
				class TestButton2: ignShortcutButton
				{
					idc = 2400;
					text = "Button2"; //--- ToDo: Localize;
					//textSecondary = "Push";
					x = 5 * GUI_GRID_W + GUI_GRID_X;
					y = 9 * GUI_GRID_H + GUI_GRID_Y;
					w = 5 * GUI_GRID_W;
					h = 1 * GUI_GRID_H;
				};
				class TestButton3: ignActiveText
				{
					idc = 2401;
					x = 10 * GUI_GRID_W + GUI_GRID_X;
					y = 9 * GUI_GRID_H + GUI_GRID_Y;
					w = 3.5 * GUI_GRID_W;
					h = 1 * GUI_GRID_H;
					text = "Button3";
				};
			};
		};




		class TestFrame2: ignFrame
		{
			idc = 1801;
			text = "Frame2"; //--- ToDo: Localize;
			x = 17.5 * GUI_GRID_W + GUI_GRID_X;
			y = 1.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 22 * GUI_GRID_W;
			h = 9.5 * GUI_GRID_H;
		};
		class TestCombo1: ignCombo
		{
			idc = 2100;
			text = "Combo1"; //--- ToDo: Localize;
			x = 18 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			tooltip = "Combo"; //--- ToDo: Localize;
		};
		class TestCombo2: ignCombo
		{
			idc = 2101;
			text = "Combo1"; //--- ToDo: Localize;
			x = 18 * GUI_GRID_W + GUI_GRID_X;
			y = 5 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			tooltip = "Combo"; //--- ToDo: Localize;
		};
		class TestListbox1: ignListbox
		{
			idc = 1500;
			text = "Listbox1"; //--- ToDo: Localize;
			x = 18 * GUI_GRID_W + GUI_GRID_X;
			y = 7 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 3.5 * GUI_GRID_H;
		};
		class TestListNBox1: ignListNBox
		{
			idc = 1501;
			text = "ListNbox1"; //--- ToDo: Localize;
			x = 28.5 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 3.5 * GUI_GRID_H;
		};
		class TestXListBox: ignListBox
		{
			idc = 1502;
			text = "XListbox1"; //--- ToDo: Localize;
			x = 28.5 * GUI_GRID_W + GUI_GRID_X;
			y = 7 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 3.5 * GUI_GRID_H;
		};
		class TestSlider: ignScrollBar
		{
			idc = 1900;
			style = SL_HORZ;	// TODO: Implement ignHorizontalScrollBar
			text = "Slider"; //--- ToDo: Localize;
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 24 * GUI_GRID_H + GUI_GRID_Y;
			w = 40 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class TestFrame3: ignFrame
		{
			idc = 1802;
			text = "Frame3"; //--- ToDo: Localize;
			x = 0.5 * GUI_GRID_W + GUI_GRID_X;
			y = 13 * GUI_GRID_H + GUI_GRID_Y;
			w = 18 * GUI_GRID_W;
			h = 10.5 * GUI_GRID_H;
		};
		class TestStructuredText: ignStructuredText
		{
			idc = 1100;
			text = "StructuredText"; //--- ToDo: Localize;
			x = 1 * GUI_GRID_W + GUI_GRID_X;
			y = 14 * GUI_GRID_H + GUI_GRID_Y;
			w = 17 * GUI_GRID_W;
			h = 4 * GUI_GRID_H;
		};
		class TestPicture: ignPicture
		{
			idc = 1200;
			text = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
			x = 1 * GUI_GRID_W + GUI_GRID_X;
			y = 18.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 17 * GUI_GRID_W;
			h = 4.5 * GUI_GRID_H;
		};
		class TestContextMenu: ignContextMenu
		{
			idc = 1003;
			text = "ContextMenu"; //--- ToDo: Localize;
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 0 * GUI_GRID_H + GUI_GRID_Y;
			w = 40 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class TestContextMenu2: ignContextMenu
		{
			idc = 2003;
			text = "ContextMenu2"; //--- ToDo: Localize;
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 0 * GUI_GRID_H + GUI_GRID_Y;
			w = 40 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
		};
		class RscFrame_1803: ignFrame
		{
			idc = 1803;
			text = "TestVideo"; //--- ToDo: Localize;
			x = 19.5 * GUI_GRID_W + GUI_GRID_X;
			y = 13 * GUI_GRID_H + GUI_GRID_Y;
			w = 19.5 * GUI_GRID_W;
			h = 11 * GUI_GRID_H;
		};
		class TestVideo: ignVideo
		{
			idc = 1202;
			x = 20 * GUI_GRID_W + GUI_GRID_X;
			y = 14 * GUI_GRID_H + GUI_GRID_Y;
			w = 18.5 * GUI_GRID_W;
			h = 9.5 * GUI_GRID_H;
			text = "sample.ogv";
			//text = "";
		};
		class TestProgressBar: ignProgressBar
		{
			idc = 1004;
			text = "ProgressBar"; //--- ToDo: Localize;
			x = 0.5 * GUI_GRID_W + GUI_GRID_X;
			y = 11.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 39 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.5,0.5,0.5,1};
			sizeEx = 0.8 * GUI_GRID_H;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////

	};
};
