params ["_control", "_key", "_shift", "_ctrl", "_alt"];
private ["_search", "_size", "_deleted"];

if (_alt) exitWith {};
#include "dialog\genstoreDefines.sqf";
_search = ctrlText genstore_item_filter;

if (_key == 14) then
{
	if (count _search > 0) then
	{
		_search = _search select [0, (count _search) - 1];
	};
	[GeneralStoreSelected] call populateGeneralStore;
};
_size = lbSize genstore_item_list;
_deleted = 0;

for "_i" from 0 to _size do
{
	_found = (toLower (lbText [genstore_item_list, _i - _deleted])) find (toLower _search);
	if (_found == -1) then
	{
		lbDelete [genstore_item_list, _i - _deleted];
		_deleted = _deleted + 1;
	};
};
if (_size > _deleted) then
{
    lbSetCurSel [genstore_item_list, 0];
};