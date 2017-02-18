/*
	Igneous01
    fnc_isValidArgType
    Validates single parameter against provided types, if no match found, returns false

arguments:
_parameter : the parameter to check (any datatype)
_types : list of types to compare against (array)                                        (Optional : defaults to accepting all types)
_error : log error if parameter is invalid (bool)                                        (Optional : default is false)

example:
validArg = [_this, [objNull]] call fnc_isValidArgType; // returns true if _this is of type OBJECT
validArg = [_this, [objNull, ""], true] call fnc_isValidArgType; // if _this is not of type [object, string] return false and log error
*/

private ["_value", "_ty"];
_parameter = [_this, 0, 0] call BIS_fnc_param;  // default to 0 if nothing provided_defaultValue = [_this, 1, 0] call BIS_fnc_param;  // default value is defaulted to 0
_types = [_this, 1, [_parameter], [[]]] call BIS_fnc_param; // default to parameter value, must be array type
_error = [_this, 2, false] call BIS_fnc_param; // error by default is off
_ty = typeName _parameter;
_value = _parameter;

// compare types against provided, default if no match found
_typeMatch = false;
{
    if (_ty == (typeName _x)) exitWith
    {
        _typeMatch = true;
    }
} forEach _types;

if (!_typeMatch) then
{
    if (_error) then
    {
        ["%1 : Argument %2 is of invalid type - default %3 used instead", _fnc_scriptName, _value, _defaultValue] call bis_fnc_error;
    }
};

_typeMatch; // return value





