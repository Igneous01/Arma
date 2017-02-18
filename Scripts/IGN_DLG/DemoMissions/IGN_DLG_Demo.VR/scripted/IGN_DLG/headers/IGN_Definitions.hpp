/*
	IGN Routed Control Events Definitions
	Defines controls with respected events, routing these events to the respected IGN_Event

	Note: Tree Events are not supported (rscTree is restricted to developers only, and can not be instantiated)
	Note: Checkbox is missing??? (BIS Definitions doesn't generate entry for checkbox)




*/





#include "BIS_Defaults.hpp"
#include "Font_Definitions.hpp"
#include "Color_Definitions.hpp"
#include "Template_Default_Definitions.hpp"

// ************* MACROS ************************************************************************

// Directory macro
//#define IGN_DLG_DIR 'scripted\\IGN_DLG\\IGN_DLG_raiseEvent.sqf'
//scripted\IGN_DLG\internal\IGN_DLG_raiseEvent.sqf

// CONTROL EVENTS

#define ctrlOnButtonClick \
	onButtonClick = "['IGN_Event_onButtonClick', [ctrlParent (_this select 0), _this select 0]] execVM 'scripted\IGN_DLG\internal\IGN_DLG_raiseEvent.sqf'"

#define ctrlOnButtonDown \
	onButtonDown = "['IGN_Event_onButtonDown', [ctrlParent (_this select 0), _this select 0]] execVM 'scripted\IGN_DLG\internal\IGN_DLG_raiseEvent.sqf'"

#define ctrlOnButtonUp \
	onButtonUp = "['IGN_Event_onButtonUp', [ctrlParent (_this select 0), _this select 0]] execVM 'scripted\IGN_DLG\internal\IGN_DLG_raiseEvent.sqf'"

#define ctrlOnMouseEnter \
	onMouseEnter = "['IGN_Event_onMouseEnter', [ctrlParent (_this select 0), _this select 0]] execVM 'scripted\IGN_DLG\internal\IGN_DLG_raiseEvent.sqf'"

#define ctrlOnMouseExit \
	onMouseExit = "['IGN_Event_onMouseExit', [ctrlParent (_this select 0), _this select 0]] execVM 'scripted\IGN_DLG\internal\IGN_DLG_raiseEvent.sqf'"

#define ctrlOnSetFocus \
	onSetFocus = "['IGN_Event_onSetFocus', [ctrlParent (_this select 0), _this select 0]] execVM 'scripted\IGN_DLG\internal\IGN_DLG_raiseEvent.sqf'"

#define ctrlOnKillFocus \
	onKillFocus = "['IGN_Event_onKillFocus', [ctrlParent (_this select 0), _this select 0]] execVM 'scripted\IGN_DLG\internal\IGN_DLG_raiseEvent.sqf'"

#define ctrlOnTimer \
	onTimer = "['IGN_Event_onTimer', [ctrlParent (_this select 0), _this select 0]] execVM 'scripted\IGN_DLG\internal\IGN_DLG_raiseEvent.sqf'"

#define ctrlOnLBDrop \
	onLBDrop = "['IGN_Event_onLBDrop', [ctrlParent (_this select 0), _this select 0, _this select 1, _this select 2]] execVM 'scripted\IGN_DLG\internal\IGN_DLG_raiseEvent.sqf'"

#define ctrlOnKeyDown \
	onKeyDown = "['IGN_Event_onKeyDown', [ctrlParent (_this select 0), _this select 0, _this select 1, _this select 2, _this select 3, _this select 4]] execVM 'scripted\IGN_DLG\internal\IGN_DLG_raiseEvent.sqf'"

#define ctrlOnKeyUp \
	onKeyUp = "['IGN_Event_onKeyUp', [ctrlParent (_this select 0), _this select 0, _this select 1, _this select 2, _this select 3, _this select 4]] execVM 'scripted\IGN_DLG\internal\IGN_DLG_raiseEvent.sqf'"

#define ctrlOnChar \
	onChar = "['IGN_Event_onChar', [ctrlParent (_this select 0), _this select 0, _this select 1]] execVM 'scripted\IGN_DLG\internal\IGN_DLG_raiseEvent.sqf'"

#define ctrlOnMouseButtonDown \
	onMouseButtonDown = "['IGN_Event_onMouseButtonDown', [ctrlParent (_this select 0), _this select 0, _this select 1, _this select 2, _this select 3, _this select 4, _this select 5, _this select 6]] execVM 'scripted\IGN_DLG\internal\IGN_DLG_raiseEvent.sqf'"

#define ctrlOnMouseButtonUp \
	onMouseButtonUp = "['IGN_Event_onMouseButtonUp', [ctrlParent (_this select 0), _this select 0, _this select 1, _this select 2, _this select 3, _this select 4, _this select 5, _this select 6]] execVM 'scripted\IGN_DLG\internal\IGN_DLG_raiseEvent.sqf'"

#define ctrlOnMouseButtonClick \
	onMouseButtonClick = "['IGN_Event_onMouseButtonClick', [ctrlParent (_this select 0), _this select 0, _this select 1, _this select 2, _this select 3, _this select 4, _this select 5, _this select 6]] execVM 'scripted\IGN_DLG\internal\IGN_DLG_raiseEvent.sqf'"

#define ctrlOnMouseButtonDblClick \
	onMouseButtonDblClick = "['IGN_Event_onMouseButtonDblClick', [ctrlParent (_this select 0), _this select 0, _this select 1, _this select 2, _this select 3, _this select 4, _this select 5, _this select 6]] execVM 'scripted\IGN_DLG\internal\IGN_DLG_raiseEvent.sqf'"

#define ctrlOnMouseMoving \
	onMouseMoving = "['IGN_Event_onMouseMoving', [ctrlParent (_this select 0), _this select 0, _this select 1, _this select 2, _this select 3]] execVM 'scripted\IGN_DLG\internal\IGN_DLG_raiseEvent.sqf'"

#define ctrlOnMouseHolding \
	onMouseHolding = "['IGN_Event_onMouseHolding', [ctrlParent (_this select 0), _this select 0, _this select 1, _this select 2, _this select 3]] execVM 'scripted\IGN_DLG\internal\IGN_DLG_raiseEvent.sqf'"

#define ctrlOnMouseZChanged \
	onMouseZChanged = "['IGN_Event_onMouseZChanged', [ctrlParent (_this select 0), _this select 0, _this select 1]] execVM 'scripted\IGN_DLG\internal\IGN_DLG_raiseEvent.sqf'"

#define ctrlOnCanDestroy \
	onCanDestroy = "['IGN_Event_onCanDestroy', [ctrlParent (_this select 0), _this select 0, _this select 1]] execVM 'scripted\IGN_DLG\internal\IGN_DLG_raiseEvent.sqf'; true;"

#define ctrlOnDestroy \
	onDestroy = "['IGN_Event_onDestroy', [ctrlParent (_this select 0), _this select 0, _this select 1]] execVM 'scripted\IGN_DLG\internal\IGN_DLG_raiseEvent.sqf'"

#define ctrlOnIMEChar \
	onIMEChar = "['IGN_Event_onIMEChar', [ctrlParent (_this select 0), _this select 0, _this select 1]] execVM 'scripted\IGN_DLG\internal\IGN_DLG_raiseEvent.sqf'"

#define ctrlOnIMEComposition \
	onIMEComposition = "['IGN_Event_onIMEComposition', [ctrlParent (_this select 0), _this select 0, _this select 1]] execVM 'scripted\IGN_DLG\internal\IGN_DLG_raiseEvent.sqf'"

#define ctrlOnJoystickButton \
	onJoystickButton = "['IGN_Event_onJoystickButton', [ctrlParent (_this select 0), _this select 0, _this select 1]] execVM 'scripted\IGN_DLG\internal\IGN_DLG_raiseEvent.sqf'"

#define ctrlOnLBSelChanged \
	onLBSelChanged = "['IGN_Event_onLBSelChanged', [ctrlParent (_this select 0), _this select 0, _this select 1]] execVM 'scripted\IGN_DLG\internal\IGN_DLG_raiseEvent.sqf'"

#define ctrlOnLBListSelChanged \
	onLBListSelChanged = "['IGN_Event_onLBListSelChanged', [ctrlParent (_this select 0), _this select 0, _this select 1]] execVM 'scripted\IGN_DLG\internal\IGN_DLG_raiseEvent.sqf'"

#define ctrlOnLBDblClick \
	onLBDblClick = "['IGN_Event_onLBDblClick', [ctrlParent (_this select 0), _this select 0, _this select 1]] execVM 'scripted\IGN_DLG\internal\IGN_DLG_raiseEvent.sqf'"

#define ctrlOnLBDrag \
	onLBDrag = "['IGN_Event_onLBDrag', [ctrlParent (_this select 0), _this select 0, _this select 1]] execVM 'scripted\IGN_DLG\internal\IGN_DLG_raiseEvent.sqf'"

#define ctrlOnLBDragging \
	onLBDragging = "['IGN_Event_onLBDragging', [ctrlParent (_this select 0), _this select 0, _this select 1, _this select 2]] execVM 'scripted\IGN_DLG\internal\IGN_DLG_raiseEvent.sqf'"

#define ctrlOnCheckBoxesSelChanged \
	onCheckBoxesSelChanged = "['IGN_Event_onCheckBoxesSelChanged', [ctrlParent (_this select 0), _this select 0, _this select 1, _this select 2]] execVM 'scripted\IGN_DLG\internal\IGN_DLG_raiseEvent.sqf'"

#define ctrlOnSliderPosChanged \
	onSliderPosChanged = "['IGN_Event_onSliderPosChanged', [ctrlParent (_this select 0), _this select 0, _this select 1]] execVM 'scripted\IGN_DLG\internal\IGN_DLG_raiseEvent.sqf'"

#define ctrlOnVideoStopped \
	onVideoStopped = "['IGN_Event_onVideoStopped', [ctrlParent (_this select 0), _this select 0]] execVM 'scripted\IGN_DLG\internal\IGN_DLG_raiseEvent.sqf'"

// ********************** MACROS END ***************************************************************

/*
	Note: These need to be implemented later

	onIMEChar	 
	When IME character is recognized (used in Korean and other eastern languages).	 
	Returns the control and the char code.	 Control

	onIMEComposition	 
	When partial IME character is recognized (used in Korean and other eastern languages).	 
	Returns the control and the char code.	 Control

	onJoystickButton
	Pressing and releasing any joystick button.	 
	Returns the control and the the pressed button.    Control

	--Listbox specific events (combobox compatible?)

	onLBSelChanged	 
	The selection in a listbox is changed. The left mouse button has been released and the new selection is fully made.	 
	Returns the control and the selected element index.	 Listbox

	onLBListSelChanged	 
	Selection in XCombo box changed (but value is not stored yet).	 
	Returns the control and the selected element index.	 Listbox

	onLBDblClick	 
	Double click on some row in listbox.	 
	Returns the control and the selected element index.	 Listbox

	onLBDrag	 
	Drag & drop operation started.	 
	Returns the control and the selected element index.	 Listbox

	onLBDragging	 
	Drag & drop operation is in progress.	 
	Returns the control and the x and y coordinates.	 Listbox

	--

	

	onCheckBoxesSelChanged	 
	Changed the selection in a checkbox.	 
	Returns the control, the selected element index and the current state.	 Checkbox

	onSliderPosChanged	 
	Changing the position of a slider.	 
	Returns the control and the change.	 Slider

	onObjectMoved	 
	Moving an object.	 
	Returns the control and the offset on the x,y and z axes.	 Object

	onVideoStopped
	Activated every time video ends (when looped, handler is executed after every finished loop).	 
	Returns the control	 Control

*/







// ********************* CONTROLS DEFINITIONS *******************************************************







// ************************** CT_SCROLLBAR CONTROL TYPE DEFINITIONS ***********************************************

// Base scrollbar class
class ignScrollBar
 {
 	type = CT_SLIDER;
 	style = 0;
	color[] = { Dlg_Color_White, 0.6 };
	colorActive[] = { Dlg_Color_White,1 };
	colorDisabled[] = {Dlg_Color_White,0.3};
	arrowEmpty = IGN_DLG_Template_ArrowEmpty;
	arrowFull = IGN_DLG_Template_ArrowFull; 
	border = IGN_DLG_Template_Border; 
	thumb = IGN_DLG_Template_Thumb; 
	shadow = 0;
 };










// Base control class
class ignBase
{
	access = 0;
	idc = -1;

	x = 0.5;
	y = 0.5;
	w = 0.2;
	h = 0.2;

	moving = IGN_DLG_Template_ControlMoving;	

	font = IGN_DLG_Template_Font;
	sizeEx = IGN_DLG_Template_FontSize;

	colorText[] = IGN_DLG_Template_ColorText;
	colorBackground[] = IGN_DLG_Template_ColorBackground;

	text = "";
	shadow = IGN_DLG_Template_Shadow;

	size = 1;

	// based on defaults provided in rscText
	tooltipColorText[] = IGN_DLG_Template_ToolTipColorText;
	tooltipColorBox[] = IGN_DLG_Template_ToolTipColorBox;
	tooltipColorShade[] = IGN_DLG_Template_ToolTipColorShade;

	// Events - all controls implement these two events
	ctrlOnCanDestroy;		
	ctrlOnDestroy;
	ctrlOnMouseEnter;
	ctrlOnMouseExit;
	ctrlOnTimer;
	ctrlOnKeyDown;
	ctrlOnKeyUp;
	ctrlOnMouseButtonDown;
	ctrlOnMouseButtonUp;
	ctrlOnMouseButtonDblClick;
	ctrlOnMouseMoving;
	ctrlOnMouseHolding;
	ctrlOnMouseZChanged;
};









//*************************** CT_STATIC CONTROL TYPE DEFINITIONS ****************************************

class ignStatic : ignBase
{
	type = CT_STATIC;	
};


class ignPicture : ignStatic
{
	style = ST_PICTURE;
};


class ignText : ignStatic
{
	style = ST_LEFT + ST_MULTI;	// Text overflow will go to a new line
	lineSpacing = IGN_DLG_Template_LineSpacing;
};

class ignBackground : ignStatic
{
	style = ST_BACKGROUND;
}


// Frame
class ignFrame: ignStatic
{
	style = ST_FRAME;
	shadow = IGN_DLG_Template_Shadow;
};


// video
class ignVideo: ignStatic
{
	style = ST_PICTURE;
	autoplay = 1;
	loops = 1;

	ctrlOnVideoStopped;
};









//*************************** CT_EDIT CONTROL TYPE DEFINITIONS ****************************************


class ignEdit : ignBase
{
	type = CT_EDIT;
	style = ST_LEFT + ST_FRAME;

	autocomplete = IGN_DLG_Template_AutoComplete;
	colorSelection[] = IGN_DLG_Template_ColorSelection;
	colorDisabled[] = IGN_DLG_Template_ColorDisabled;

	size = 0.2;			// apparently unused based on documentation

	// Control Events
	ctrlOnSetFocus;
	ctrlOnKillFocus;
	ctrlOnLBDrop;	// assuming in BIS wiki rscEdit is activeText?
	ctrlOnChar;
	ctrlOnMouseButtonClick;
	ctrlOnIMEChar;
	ctrlOnIMEComposition;
	//ctrlOnJoystickButton;		not implemented in A2 or A3
	//ctrlOnVideoStopped;		cant nest a video inside a CT_EDIT ?
};









//*************************** CT_STRUCTURED_TEXT CONTROL TYPE DEFINITIONS ****************************************

class ignStructuredText : ignBase
{
	type = CT_STRUCTURED_TEXT;
	style = ST_LEFT + ST_MULTI;		// overflow characters are put on new line
	size = 1;						// use same size of font as parent class
};










//*************************** CT_COMBO CONTROL TYPE DEFINITIONS ****************************************


// combo box (missing listbox events)
class ignCombo : ignBase
{
	type = CT_COMBO;
	style = ST_LEFT;		// TODO - check if this style applies later (LB_MULTI)

	class ComboScrollBar : ignScrollBar {};

	colorDisabled[] = IGN_DLG_Template_ColorDisabled;
	colorSelect[] = IGN_DLG_Template_ColorSelect;
	colorSelectBackground[] = IGN_DLG_Template_ColorSelectBackground;

	soundSelect[] = IGN_DLG_Template_SoundSelect;
	soundExpand[] = IGN_DLG_Template_SoundExpand;
	soundCollapse[] = IGN_DLG_Template_SoundCollapse;
	colorActive[] = IGN_DLG_Template_ColorActive;

	maxHistoryDelay = 1;

	arrowEmpty = IGN_DLG_Template_ArrowEmpty;
	arrowFull = IGN_DLG_Template_ArrowFull;
	wholeHeight = IGN_DLG_Template_WholeHeight;

	// Control Events
	ctrlOnSetFocus;
	ctrlOnKillFocus;
	ctrlOnLBDrop;
	ctrlOnMouseButtonClick;
	//ctrlOnVideoStopped;
	ctrlOnLBSelChanged;
	ctrlOnLBListSelChanged;
	ctrlOnLBDblClick;
	ctrlOnLBDrag;
	ctrlOnLBDragging;

};










//*************************** LIST BOX CONTROL TYPES DEFINITIONS ****************************************

// list box base, since all list boxes implement the same events
class ignListBoxBase : ignBase
{
	soundSelect[] = IGN_DLG_Template_SoundSelect; 

	arrowEmpty = IGN_DLG_Template_ArrowEmpty;
	arrowFull = IGN_DLG_Template_ArrowFull;

	colorSelect[] = IGN_DLG_Template_ColorSelect; 
	colorSelect2[] = IGN_DLG_Template_ColorSelect2; 
	colorSelectBackground[] = IGN_DLG_Template_ColorSelectBackground; 
	colorSelectBackground2[] = IGN_DLG_Template_ColorSelectBackground2; 
	colorDisabled[] = {Dlg_Color_White,0.5}; 	
	colorShadow[] = IGN_DLG_Template_ColorShadow; 

	period = IGN_DLG_Template_OscillationPeriod; // Oscillation time between colorSelect/colorSelectBackground2 and colorSelect2/colorSelectBackground when selected
	rowHeight = IGN_DLG_Template_RowHeight;
	maxHistoryDelay = 1; // Time since last keyboard type search to reset it

	// Control Events
	ctrlOnSetFocus;
	ctrlOnKillFocus;
	ctrlOnLBDrop;
	ctrlOnMouseButtonClick;
	//ctrlOnVideoStopped;
	ctrlOnLBSelChanged;
	ctrlOnLBListSelChanged;
	ctrlOnLBDblClick;
	ctrlOnLBDrag;
	ctrlOnLBDragging;
};


// listbox
class ignListBox : ignListBoxBase
{
	type = CT_LISTBOX;
	style = ST_LEFT; // Style
	idc = CT_LISTBOX; // Control identification (without it, the control won't be displayed)
	
	//default = 0; // Control selected by default (only one within a display can be used)
	//blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.

	pictureColor[] = IGN_DLG_Template_PictureColor; 
	pictureColorSelect[] = IGN_DLG_Template_PictureColorSelect; 
	pictureColorDisabled[] = IGN_DLG_Template_PictureColorDisabled; 

	itemSpacing = IGN_DLG_Template_ItemSpacing; 

	// Scrollbar configuration (applied only when LB_TEXTURES style is used)
	class ListScrollBar : ignScrollBar //In older games this class is "ScrollBar"
	{};
};


// list n box - by default has 3 columns
class ignListNBox : ignListBoxBase
{
	idc = CT_LISTNBOX; // Control identification (without it, the control won't be displayed)
	type = CT_LISTNBOX; // Type 102
	style = ST_LEFT; // Style
	//default = 0; // Control selected by default (only one within a display can be used)
	//blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.

	columns[] = {0,0.3, 0.6}; // Horizontal coordinates of columns (relative to list width, in range from 0 to 1)

	drawSideArrows = 0; // 1 to draw buttons linked by idcLeft and idcRight on both sides of selected line. They are resized to line height
	idcLeft = -1; // Left button IDC
	idcRight = -1; // Right button IDC

	// Scrollbar configuration (applied only when LB_TEXTURES style is used)
	class ListScrollBar : ignScrollBar
	{};
};


// xlistbox
class ignXListBox : ignListBoxBase
{


};






//*************************** BUTTON CONTROL TYPES DEFINITIONS ****************************************

class ignButtonBase : ignBase
{
	soundEnter[] = IGN_DLG_Template_SoundEnter;
	soundPush[] = IGN_DLG_Template_SoundPush;
	soundClick[] = IGN_DLG_Template_SoundClick;
	soundEscape[] = IGN_DLG_Template_SoundEscape;
	colorFocused[] = IGN_DLG_Template_ColorFocused;
	colorShadow[] = IGN_DLG_Template_ColorShadow;
	colorDisabled[] = IGN_DLG_Template_ColorDisabled;

	// Control Events
	ctrlOnButtonClick;
	ctrlOnSetFocus;
	ctrlOnKillFocus;
	ctrlOnLBDrop;
	ctrlOnChar;
	ctrlOnMouseButtonClick;
	ctrlOnIMEChar;
	ctrlOnIMEComposition;
	//ctrlOnJoystickButton;
	//ctrlOnVideoStopped;
};




// button
class ignButton : ignButtonBase
{
	type = CT_BUTTON;
	style = ST_CENTER;

	offsetX = IGN_DLG_Template_Shadow_OffsetX;
	offsetY = IGN_DLG_Template_Shadow_OffsetY;
	offsetPressedX = IGN_DLG_Template_OffsetPressedX;
	offsetPressedY = IGN_DLG_Template_OffsetPressedY;
	
	colorBackgroundDisabled[] = IGN_DLG_Template_ColorBackgroundDisabled;
	colorBackgroundActive[] = IGN_DLG_Template_ColorBackgroundActive;
	colorBorder[] = IGN_DLG_Template_ColorBorder;

	borderSize = IGN_DLG_Template_BorderSize;
};


// shortcut button
class ignShortcutButton : ignButtonBase
{
	type = CT_SHORTCUTBUTTON;
	style = ST_LEFT;

	class HitZone
	{
		left = 0;
		top = 0;
		right = 0;
		bottom = 0;
	};

	class ShortcutPos
	{
		left = 0;
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 20) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		w = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
		h = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};

	class TextPos
	{
		left = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 20) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		right = 0.005;
		bottom = 0;
	};

	class Attributes
	{
		font = IGN_DLG_Template_Font;
		//font = "PuristaLight";
		color = "#FFFFFF";
		align = "left";
		shadow = "false";
	};

	class AttributesImage
	{
		font = IGN_DLG_Template_Font;
		color = "#E5E5E5";
		align = "left";
	};

	shortcuts[] = {};
	textureNoShortcut = IGN_DLG_Template_TextureNoShortcut;
	textSecondary = "";
	sizeExSecondary = IGN_DLG_Template_FontSize;
	fontSecondary = IGN_DLG_Template_Font;
	size = IGN_DLG_Template_FontSize;	// this and sizeEx both effect font size :S

	//color[] = IGN_DLG_Template_Color;
	//color2[] = IGN_DLG_Template_Color2;
	color[] = IGN_DLG_Template_ColorText;
	color2[] = IGN_DLG_Template_ColorText;
	colorBackgroundFocused[] = IGN_DLG_Template_ColorFocused;
	colorBackground2[] = IGN_DLG_Template_ColorBackground2;

	//colorSecondary[] = IGN_DLG_Template_ColorSecondary;
	colorSecondary[] = IGN_DLG_Template_ColorText;
	colorFocusedSecondary[] = IGN_DLG_Template_ColorFocusedSecondary;
	color2Secondary[] = IGN_DLG_Template_Color2Secondary;
	colorDisabledSecondary[] = IGN_DLG_Template_ColorDisabledSecondary;

	animTextureDefault = IGN_DLG_Template_AnimTextureDefault;
	animTextureNormal = IGN_DLG_Template_AnimTextureNormal;
	animTextureDisabled = IGN_DLG_Template_AnimTextureDisabled;
	animTextureOver = IGN_DLG_Template_AnimTextureOver;
	animTextureFocused = IGN_DLG_Template_AnimTextureFocused;
	animTexturePressed = IGN_DLG_Template_AnimTexturePressed;

	periodFocus = IGN_DLG_Template_OscillationPeriod;
	periodOver = IGN_DLG_Template_OscillationPeriod;
	period = IGN_DLG_Template_OscillationPeriod;

	
};


// Active Text button
class ignActiveText : ignButtonBase
{
	type = CT_ACTIVETEXT;
	style = ST_LEFT;
	blinkingPeriod = 0; // Makes the text start transparent, go to full opacity and back to full transparent in the amount of time specified.
	color[] = IGN_DLG_Template_ColorText; //replaces colorText, standard text and underline color
	colorActive[] = IGN_DLG_Template_ColorActive;
};


// Checkbox control
class ignCheckBox : ignBase
{
	type = 77;
	style = 0;
	checked = 0;

	colorActive[] = {0,0,0,0};
	color[] = IGN_DLG_Template_ColorText;
	colorFocused[] = IGN_DLG_Template_ColorText;
	colorHover[] = IGN_DLG_Template_ColorText;
	colorPressed[] = IGN_DLG_Template_ColorText;
	colorDisabled[] = IGN_DLG_Template_ColorDisabled;
	colorBackground[] = {0,0,0,0};
	colorText[] = {0,0,0,0};
	colorBackgroundFocused[] = {0,0,0,0};
	colorBackgroundHover[] = {0,0,0,0};
	colorBackgroundPressed[] = {0,0,0,0};
	colorBackgroundDisabled[] = {0,0,0,0};


	textureChecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureUnchecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	textureFocusedChecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureFocusedUnchecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	textureHoverChecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureHoverUnchecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	texturePressedChecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	texturePressedUnchecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	textureDisabledChecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureDisabledUnchecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	
	soundEnter[] = IGN_DLG_Template_SoundEnter;
	soundPush[] = IGN_DLG_Template_SoundPush;
	soundClick[] = IGN_DLG_Template_SoundClick;
	soundEscape[] = IGN_DLG_Template_SoundEscape;
};


class ignTextCheckBoxes : ignBase
{
	type = CT_CHECKBOXES;
	style = 0;
	color[] = IGN_DLG_Template_Color;
	colorTextSelect[] = IGN_DLG_Template_ColorSelect;
	colorSelectedBg[] = IGN_DLG_Template_ColorSelectBackground;
	colorSelect[] = IGN_DLG_Template_ColorSelect;

	colorTextDisable[] = IGN_DLG_Template_ColorDisabled;
	colorDisable[] = IGN_DLG_Template_ColorDisabledSecondary;

	rows = 1;
	columns = 1;
	strings[] = 
	{
		"UNCHECKED"
	};
	checked_strings[] = 
	{
		"CHECKED"
	};
};



// progress bar
class ignProgressBar : ignBase
{
	type = CT_PROGRESS;
	style = 0;
	colorFrame[] = {0,0,0,1};
	colorBar[] = {1,1,1,1};
	texture = "#(argb,8,8,3)color(1,1,1,1)";
};



// context menu
// At this time controls of this type cannot be instantiated via description.ext definitions - it will simply error in .rpt that it 
// cannot be created this way
class ignContextMenu : ignBase
{
	type = CT_CONTEXT_MENU;
	style = 0;
	colorBorder[] = IGN_DLG_Template_ColorBorder;
	colorSeparator[] = IGN_DLG_Template_ColorSeparator;
	colorSelectBackground[] = IGN_DLG_Template_ColorSelectBackground;
	colorChecked[] = IGN_DLG_Template_ColorChecked;
	colorEnabled[] = IGN_DLG_Template_ColorEnabled;
	colorDisabled[] = IGN_DLG_Template_ColorDisabled;
};



// control group
class ignControlsGroup : ignBase
{
	type = CT_CONTROLS_GROUP;
	style = ST_MULTI;
	class VScrollbar : ignScrollBar
	{
		width = 0.021;
		autoScrollEnabled = 1;
	};
	class HScrollbar : ignScrollBar
	{
		height = 0.028;
	};
	class Controls
	{
	};
	
};





// ********************* DISPLAY DEFINITIONS *******************************************************

class ignDisplay
{
	onLoad = "['IGN_Event_onLoadDisplay', _this, ctrlIDD (_this select 0)] execVM 'scripted\IGN_DLG\internal\IGN_DLG_raiseEventDisplay.sqf'; true;";
	onUnload = "['IGN_Event_onUnloadDisplay', _this select 0, ctrlIDD (_this select 0)] execVM 'scripted\IGN_DLG\internal\IGN_DLG_raiseEventDisplay.sqf'; true;";
};