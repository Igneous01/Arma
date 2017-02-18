// IGN Dialog and Control initialization
// Author: Igneous01

// uncomment next line to enable debugging
#define IGN_DLG_DEBUG

// Determines what game the library is being used for (Leave this definition alone if you are on A3!)
#define ___GAME_ARMA3___


#include "IGN_DLG_Internal.hpp";
#include "IGN_DLG_Events.hpp";
#include "IGN_DLG_functions.hpp";
#include "IGN_DLG_ListBox_Functions.hpp";


/*
	TODO:

	-Databindings for Listbox, ListNBox, ComboBox, etc...

	-Abstract these controls with functions (Set Num columns, set default spacing, add new column, add row, etc)

	-inherit sliders (create ignScrollBar and ignListScrollBar) + scroll bar events
	-TwoWayBinding


	------Custom Control templates------

	-MessageBox (with function call to instantiate)
	-Table (with functions addColumn, setColumn(), etc)
	-Form Field (with optional field paramaters as arguments + style template to use)



	-Make Routed Events local to dialog only - needs testing
	-Destructor definition of routed events and binding variables



*/