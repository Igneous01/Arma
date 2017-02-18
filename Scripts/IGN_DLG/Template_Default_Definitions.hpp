/*
	DIALOG CONTROL TEMPLATE DEFINITIONS

	Create new template definitions here

*/
#include "Color_Definitions.hpp"
#include "Font_Definitions.hpp"

//*******************************
// General Control properties
//*******************************

// determines if dragging a control with mouse causes entire dialog to move (works only if enablemoving is true for display)
#define IGN_DLG_Template_ControlMoving false
#define IGN_DLG_Template_Font FONT_TAHOMAB
#define IGN_DLG_Template_FontSize 0.025
#define IGN_DLG_Template_Shadow 1
#define IGN_DLG_Template_ToolTipColorText { Dlg_Color_RoyalBlue, 1 }
#define IGN_DLG_Template_ToolTipColorBox { Dlg_Color_Azure, 0.65 }
#define IGN_DLG_Template_ToolTipColorShade { Dlg_Color_Black, 0.65 }
#define IGN_DLG_Template_ColorText { Dlg_Color_RoyalBlue, 1 }
#define IGN_DLG_Template_ColorBackground { Dlg_Color_Azure, 0.65 }










//*******************************
// Shortcut Button Control properties
//*******************************
#define IGN_DLG_Template_ColorBackground2 { Dlg_Color_AliceBlue, 0.65 }
#define IGN_DLG_Template_ColorSecondary { Dlg_Color_RoyalBlue, 0.65 }
#define IGN_DLG_Template_ColorFocusedSecondary { Dlg_Color_RoyalBlue, 0.65 }
#define IGN_DLG_Template_Color2Secondary { Dlg_Color_RoyalBlue, 0.65 }
#define IGN_DLG_Template_ColorDisabledSecondary { Dlg_Color_Black, 0.65 }

#define IGN_DLG_Template_TextureNoShortcut "#(argb,8,8,3)color(0,0,0,0)"

#define IGN_DLG_Template_AnimTextureDefault "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa"
#define IGN_DLG_Template_AnimTextureNormal "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa"
#define IGN_DLG_Template_AnimTextureDisabled "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa"
#define IGN_DLG_Template_AnimTextureOver "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\over_ca.paa"
#define IGN_DLG_Template_AnimTextureFocused "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\focus_ca.paa"
#define IGN_DLG_Template_AnimTexturePressed "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\down_ca.paa"











//*******************************
// General Control Color properties
//*******************************

// Text selection color
#define IGN_DLG_Template_ColorSelect { Dlg_Color_RoyalBlue, 1 }

// Text selection color (oscillates between this and colorSelect) - used in combobox / listbox
#define IGN_DLG_Template_ColorSelect2 { Dlg_Color_RoyalBlue, 1 }

// Selected item fill color
#define IGN_DLG_Template_ColorSelectBackground {Dlg_Color_Azure,0.7}

// Selected item fill color (oscillates between this and colorSelectBackground) - used in combobox / listbox
#define IGN_DLG_Template_ColorSelectBackground2 {Dlg_Color_AliceBlue,0.7}

// Text shadow color (used only when shadow is 1)
#define IGN_DLG_Template_ColorShadow { Dlg_Color_Black, 0.5 }

// Disabled text color
#define IGN_DLG_Template_ColorDisabled { Dlg_Color_Black, 0.25 }
#define IGN_DLG_Template_ColorEnabled { Dlg_Color_Azure, 0.25 }
#define IGN_DLG_Template_ColorChecked { Dlg_Color_AliceBlue, 0.25 }
#define IGN_DLG_Template_ColorBorder { Dlg_Color_Black, 0.25 }
#define IGN_DLG_Template_ColorSeparator { Dlg_Color_Azure, 0.25 }

// Used in scrollbar, slider
#define IGN_DLG_Template_Color { Dlg_Color_RoyalBlue, 0.6 }
#define IGN_DLG_Template_Color2 { Dlg_Color_AliceBlue, 0.6 }

// used by scroll, slider, combo, list
#define IGN_DLG_Template_ColorActive { Dlg_Color_RoyalBlue, 1 }

/* Picture Color Properties */
// Picture color
#define IGN_DLG_Template_PictureColor {Dlg_Color_White,1}
// Selected picture color
#define IGN_DLG_Template_PictureColorSelect {Dlg_Color_White,1}
// Disabled picture color
#define IGN_DLG_Template_PictureColorDisabled {Dlg_Color_White,0.5}





//*******************************
// TEXT Control Color properties
//*******************************

#define IGN_DLG_Template_LineSpacing 1





//*******************************
// EDIT Control Color properties
//*******************************
#define IGN_DLG_Template_AutoComplete "scripting"
#define IGN_DLG_Template_ColorSelection { Dlg_Color_White, 0.75 }





//*******************************
// Combo and Listbox specific properties
//******************************* 

// Sound played when an item is selected/expanded/collapsed (Listbox only)
#define IGN_DLG_Template_SoundSelect {"\A3\ui_f\data\sound\RscCombo\soundSelect", 0.1, 1 }
#define IGN_DLG_Template_SoundExpand {"\A3\ui_f\data\sound\RscCombo\soundExpand", 0.1, 1}
#define IGN_DLG_Template_SoundCollapse {"\A3\ui_f\data\sound\RscCombo\soundCollapse", 0.1, 1}

// Oscillation time between colorSelect/colorSelectBackground2 and colorSelect2/colorSelectBackground when selected
// Used in combobox and listbox families, as well as shortcut button
// property period
#define IGN_DLG_Template_OscillationPeriod 1

// Height of empty space between items (Used in listbox family)
#define IGN_DLG_Template_ItemSpacing 0

// Used in listbox, combobox, and other list types to specify height of each row
#define IGN_DLG_Template_RowHeight 0.025

// the height of the elapsed box (Used in combobox)
#define IGN_DLG_Template_WholeHeight 0.45

// Arrow
#define IGN_DLG_Template_ArrowEmpty "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"

// Arrow when clicked on
#define IGN_DLG_Template_ArrowFull "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"

// Slider background (stretched vertically)
#define IGN_DLG_Template_Border "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa"

// Dragging element (stretched vertically)
#define IGN_DLG_Template_Thumb "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa"





//*******************************
// Button specific properties
//******************************* 

#define IGN_DLG_Template_ColorBackgroundDisabled { Dlg_Color_Black, 0.5 }
#define IGN_DLG_Template_ColorBackgroundActive { Dlg_Color_Azure, 0.5 }
#define IGN_DLG_Template_Shadow_OffsetX 0
#define IGN_DLG_Template_Shadow_OffsetY 0
#define IGN_DLG_Template_OffsetPressedX 0
#define IGN_DLG_Template_OffsetPressedY 0
#define IGN_DLG_Template_ColorFocused { Dlg_Color_AliceBlue, 0.5 }
#define IGN_DLG_Template_ColorBorder { Dlg_Color_Black, 1 }
#define IGN_DLG_Template_BorderSize 0
#define IGN_DLG_Template_SoundEnter { "\A3\ui_f\data\sound\RscButton\soundEnter", 0.09, 1}
#define IGN_DLG_Template_SoundPush { "\A3\ui_f\data\sound\RscButton\soundPush", 0.09, 1}
#define IGN_DLG_Template_SoundClick { "\A3\ui_f\data\sound\RscButton\soundClick", 0.09, 1}
#define IGN_DLG_Template_SoundEscape { "\A3\ui_f\data\sound\RscButton\soundEscape", 0.09, 1}







#define IGN_DLG_Template_
#define IGN_DLG_Template_
#define IGN_DLG_Template_
#define IGN_DLG_Template_
#define IGN_DLG_Template_
#define IGN_DLG_Template_
#define IGN_DLG_Template_
#define IGN_DLG_Template_
#define IGN_DLG_Template_
#define IGN_DLG_Template_
#define IGN_DLG_Template_
#define IGN_DLG_Template_
#define IGN_DLG_Template_
#define IGN_DLG_Template_
#define IGN_DLG_Template_
#define IGN_DLG_Template_
#define IGN_DLG_Template_
#define IGN_DLG_Template_
#define IGN_DLG_Template_
#define IGN_DLG_Template_
#define IGN_DLG_Template_
#define IGN_DLG_Template_
#define IGN_DLG_Template_
#define IGN_DLG_Template_
#define IGN_DLG_Template_
#define IGN_DLG_Template_
#define IGN_DLG_Template_
#define IGN_DLG_Template_
#define IGN_DLG_Template_
#define IGN_DLG_Template_
#define IGN_DLG_Template_
#define IGN_DLG_Template_
#define IGN_DLG_Template_

