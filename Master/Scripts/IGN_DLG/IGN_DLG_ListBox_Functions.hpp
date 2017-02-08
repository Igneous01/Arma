/*
	Combobox, Listbox, ListBoxN Functions
*/

#define LISTBOX_TYPE 0
#define COMBOBOX_TYPE 0
#define LISTNBOX_TYPE 0

// Args: 
// ctrlID: number - id of listbox/combobox
// array: array of strings data - use 1-D array for listbox, combobox, use 2-D array for listNbox (if wishing to add data as table)
// ctrlType: number - the type of ctrl. 0 is combobox, listbox       1 is listNbox

// Example:
// [7005, [["First Name", "Last Name", "SIN"]], 1] call IGN_DLG_SetSource;

// Returns: nothing
IGN_DLG_SetSource =
{
    private["_ctrlID", "_array", "_ctrlType"];
    
    _ctrlID = _this select 0;
    _array = _this select 1;
    _ctrlType = _this select 2;
    
    switch (_ctrlType) do
    {
        // listbox/combobox
        case 0:
        {
            {
                lbAdd[_ctrlID, _x]
            } forEach _array;
        };
        // listNbox
        case 1:
        {
            {
                lnbAddRow[_ctrlID, _x]
            } forEach _array;
            
        };
        
    };

};