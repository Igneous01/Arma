////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Sapphire, v1.063, #Fyqyjy)
////////////////////////////////////////////////////////

#define DLG_SAMPLEITEMLIST 8002
#define LISTBOX 1500
#define TEXTBOX 1400
#define BTNADD 1600
#define BTNDEL 1601
#define BTNOK 1602
#define STATUSLABEL 1000

class SAMPLEITEMLIST : ignDisplay {
	idd = 8002;
	movingEnable = false;
	controlsBackground[] = { };
	objects[] = { };
	controls[] ={ ListFrame, ListNames, textBox, BtnAdd, btnDelete, btnOK, StatusBar };

	class ListFrame: ignFrame
	{
		idc = 1800;
		x = 7 * GUI_GRID_W + GUI_GRID_X;
		y = 1 * GUI_GRID_H + GUI_GRID_Y;
		w = 25 * GUI_GRID_W;
		h = 14 * GUI_GRID_H;
	};
	class ListNames: ignListbox
	{
		idc = 1500;
		x = 8 * GUI_GRID_W + GUI_GRID_X;
		y = 2 * GUI_GRID_H + GUI_GRID_Y;
		w = 23 * GUI_GRID_W;
		h = 6 * GUI_GRID_H;
	};
	class textBox: ignEdit
	{
		idc = 1400;
		x = 8 * GUI_GRID_W + GUI_GRID_X;
		y = 9 * GUI_GRID_H + GUI_GRID_Y;
		w = 9 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class BtnAdd: ignButton
	{
		idc = 1600;
		text = "Add"; //--- ToDo: Localize;
		x = 18 * GUI_GRID_W + GUI_GRID_X;
		y = 9 * GUI_GRID_H + GUI_GRID_Y;
		w = 4 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class btnDelete: ignButton
	{
		idc = 1601;
		text = "Delete"; //--- ToDo: Localize;
		x = 27 * GUI_GRID_W + GUI_GRID_X;
		y = 9 * GUI_GRID_H + GUI_GRID_Y;
		w = 4 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class btnOK: ignButton
	{
		idc = 1602;
		text = "OK"; //--- ToDo: Localize;
		x = 18 * GUI_GRID_W + GUI_GRID_X;
		y = 11 * GUI_GRID_H + GUI_GRID_Y;
		w = 4 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class StatusBar: ignText
	{
		idc = 1000;
		text = "Status Bar"; //--- ToDo: Localize;
		x = 8 * GUI_GRID_W + GUI_GRID_X;
		y = 13 * GUI_GRID_H + GUI_GRID_Y;
		w = 23 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};

};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
