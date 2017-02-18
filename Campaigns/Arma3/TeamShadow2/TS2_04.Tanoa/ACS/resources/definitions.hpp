// Control types
#define CT_STATIC           0
#define CT_BUTTON           1
#define CT_LISTBOX          5

// Static styles
#define ST_LEFT           0x00
#define ST_CENTER         0x02
#define ST_MULTI          0x10
#define ST_FRAME          0x40

#define FT_EMONO "EtelkaMonospacePro"

////////////////
//Base Classes//
////////////////

class RscListbox
{
	access = 0;
	idc = -1;
	type = CT_LISTBOX;
	style = ST_LEFT;
	sizeEx = 0.03500;
	font = FT_EMONO;
	rowHeight = 0.03;
	
	maxHistoryDelay = 10;
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
	
	canDrag = 0;
	disableFiltering = 0;
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,0.5};
	colorDisabled[] = {1,1,1,1};
	colorSelect[] = {0,0,0,0.5};
	soundSelect[] = {"",0,0,0};
	
	class ScrollBar
	{
	color[] = {1, 1, 1, 0.6};
	colorDisabled[] = {};
	colorActive[] = {1, 1, 1, 1};
	thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
	arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
	arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
	border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	};
	
	class ListScrollBar: ScrollBar
	{
	color[] = {1, 1, 1, 0.6};
	colorDisabled[] = {};
	colorActive[] = {1, 1, 1, 1};
	thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
	arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
	arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
	border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	};
};

class RscText
{
    access = 0;
    idc = -1;
    type = CT_STATIC;
    style = ST_MULTI;
    linespacing = 1;
    colorBackground[] = {0,0,0,0};
    colorText[] = {1,1,1,1};
    text = "";
    shadow = 0;
    font = "PuristaLight";
    SizeEx = 0.03500;
    fixedWidth = 0;
    x = 0;
    y = 0;
    h = 0;
    w = 0;
   
};

class RscButton
{
    
    access = 0;
    type = CT_BUTTON;
    text = "";
    colorText[] = {1,1,1,0.9};
    colorDisabled[] = {0.4,0.4,0.4,0};
    colorBackground[] = {0.96,0.62,0,0.5};
    colorBackgroundDisabled[] = {0,0,0,0};
    colorBackgroundActive[] = {0.75,0.75,0.75,1};
    colorFocused[] = {0.75,0.75,0.75,0.5};
    colorShadow[] = {0.023529,0,0.0313725,1};
    colorBorder[] = {0.023529,0,0.0313725,1};
    soundEnter[] = {"\ca\ui\data\sound\onover",0.09,1};
    soundPush[] = {"\ca\ui\data\sound\new1",0,0};
    soundClick[] = {"\ca\ui\data\sound\onclick",0.07,1};
    soundEscape[] = {"\ca\ui\data\sound\onescape",0.09,1};
    style = 2;
    x = 0;
    y = 0;
    w = 0.055589;
    h = 0.039216;
    shadow = 2;
    font = "PuristaLight";
    sizeEx = 0.03921;
    offsetX = 0.003;
    offsetY = 0.003;
    offsetPressedX = 0.002;
    offsetPressedY = 0.002;
    borderSize = 0;
};

class RscFrame
{
    type = CT_STATIC;
    idc = -1;
    style = ST_FRAME;
    shadow = 2;
    colorBackground[] = {1,1,1,1};
    colorText[] = {1,1,1,0.9};
    font = "PuristaLight";
    sizeEx = 0.03;
    text = "";
};
class RscBackground
{
    type = CT_STATIC;
    idc = -1;
    style = ST_CENTER;
    shadow = 2;
    colorBackground[] = {0,0,0,0.5};
    colorText[] = {1,1,1,0.9};
    font = "PuristaLight";
    sizeEx = 0.03;
    text = "";
};

class RscTitle
{
    type = CT_STATIC;
    idc = -1;
    style = ST_CENTER;
    shadow = 2;
    colorBackground[] = {0.96,0.62,0,0.5};
    colorText[] = {1,1,1,0.9};
    font = "PuristaLight";
    sizeEx = 0.03;
    text = "";
};

class ScrollBar
{
	color[] = {1, 1, 1, 0.6};
	colorDisabled[] = {};
	colorActive[] = {1, 1, 1, 1};
	thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
	arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
	arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
	border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
};