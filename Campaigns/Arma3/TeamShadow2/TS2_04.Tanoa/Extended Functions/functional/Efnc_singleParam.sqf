/*
	Igneous01
    fnc_SingleParam
    Validates single parameter against provided types, if no match found, defaults to provided value
    If parameter is passed as array (ie. [singleParam] call someFnc) then it will be extracted and checked as well

this means your script/function can be completely agnostic as to whether someone calls it with an array argument
or single argument.

Both of these will work:
someVal = [arg] call myFunc;
someVal = arg call myFunc;


arguments:
_parameter : the parameter to check (any datatype)
_defaultValue : value to default to, if the parameter is invalid (any datatype) (Optional : defaults to 0)
_types : list of types to compare against (array)                                        (Optional : defaults to accepting all types)
_error : log error if parameter is invalid (bool)                                          (Optional : default is false)

example:
_myArg = [_this, objNull] call fnc_SingleParam; // does nothing, as _myArg accepts all types
_myArg = [_this, objNull, [objNull, 0, [] ]] call fnc_SingleParam; // if _myArg is not of type [object, number, or array] default to objNull
_myArg = [_this, "Default", [""], true] call fnc_SingleParam; // if _myArg is not type string, defaults to "Default", error is logged
*/


private ["_value", "_ty"];
_parameter = [_this, 0, 0] call BIS_fnc_param;  // default to 0 if nothing provided
_defaultValue = [_this, 1, 0] call BIS_fnc_param;  // default value is defaulted to 0
_types = [_this, 2, [_parameter], [[]]] call BIS_fnc_param; // default to parameter value, must be array type
_error = [_this, 3, false] call BIS_fnc_param; // error by default is off

_ty = typeName _parameter;

// if array, extract
if (_ty == (typename [])) then
{
    _value = _parameter select 0;
    _ty = typeName _value;
}
else
{
    _value = _parameter;
};

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
    ["%1 : Argument %2 is of invalid type - default %3 used instead", _fnc_scriptName, _value, _defaultValue] call bis_fnc_error;
    _value = _defaultValue;
};

_value; // return value


            


