private ["_type", "_target", "_holder", "_container", "_items", "_oldItems", "_removeItemCargo", "_uniformIndex", "_uniform", "_droppedContainer", "_oldItems", "_allItems", "_class", "_ammo"];
_type = _this select 3 select 0;
_target = cursorObject;

_holder = createVehicle ["GroundWeaponHolder", getPosATL player, [], 0, "CAN_COLLIDE"];
_container = uniform player;
_holder addItemCargoGlobal [_container, 1];
_items = uniformContainer player;
removeUniform player;
_oldItems = [];

_removeItemCargo =
{
	private ["_container", "_class", "_index", "_oldItems", "_item", "_oldContainer", "_newContainer", "_itemClass", "_itemCount", "_objID", "_inContainer", "_cfgWeapons"];
	_container = _this select 0;
	_class = _this select 1;
	_oldContainer = everyContainer _container;
	_index = _oldContainer findIf {_x select 0 == _class};
	_item = _oldContainer select _index;
	_oldItems = getItemCargo _container;
	_oldContainer deleteAt _index;
	clearItemCargoGlobal _container;
	_newContainer = everyContainer _container;
	_cfgWeapons = configfile >> "CfgWeapons";
	_CfgMagazines = ["CA_Magazine", configfile >> "CfgMagazines"];
	{
		_itemCount = _oldItems select 1 select _forEachIndex;
		if (_x != (_item select 0) && !(_x isKindOf ["Uniform_Base", _cfgWeapons] || _x isKindOf ["Vest_Camo_Base", _cfgWeapons])) then
		{
			if (_x isKindOf _CfgMagazines) then
			{
				_container addMagazineAmmoCargo [_x, _itemCount];
			} else
			{
				_container addItemCargoGlobal [_x, _itemCount];
			};
		};
	}
	forEach (_oldItems select 0);
	{
		_inContainer = _container addItemCargoGlobal [_x select 0, 1];
		if ((_x select 0) isKindOf ["Vest_Camo_Base", _cfgWeapons]) then
		{
			{
				if !(_x isKindOf _CfgMagazines) then
				{
					_inContainer addItemCargoGlobal [_x, 1];
				};
			} forEach (vestItems (_x select 1));
		} else
		{
			{
				if !(_x isKindOf _CfgMagazines) then
				{
					_inContainer addItemCargoGlobal [_x, 1];
				};
			} forEach (uniformItems (_x select 1));
		};
		{
			_inContainer addMagazineAmmoCargo [_x select 0, 1, _x select 1];
		} forEach (magazinesAmmo (_x select 1));
	} forEach _oldContainer;
	_item select 1
};

switch (_type) do
{
	case 0:
	{
		_uniformIndex = getItemCargo _target select 0 findIf { !([format['U_%1', switch (playerSide) do { case west: {'B_'}; case east: {'O_'}; case independent: {'I_'};}] ,_x] call fn_startsWith) && _x isKindOf ["Uniform_Base", configfile >> "CfgWeapons"]};
		_uniform = getItemCargo _target select 0 select _uniformIndex;
		_oldItems = [_target, _uniform] call _removeItemCargo;
		player forceAddUniform _uniform;
	};
	case 1:
	{
		_uniform = uniform _target;
		_oldItems = uniformContainer _target;
		removeUniform _target;
		player forceAddUniform _uniform;
	};
};
_allItems = magazinesAmmoCargo _oldItems;
{ _allItems pushBack _x } forEach (itemCargo _oldItems);
{ _allItems pushBack _x } forEach (magazinesAmmoCargo _items);
{ _allItems pushBack _x } forEach (itemCargo _items);
_droppedContainer = everyContainer _holder select 0 select 1;
{
	_class = _x;
	_ammo = 0;
	if (typeName _x == "ARRAY") then
	{
		_class = _x select 0;
		_ammo = _x select 1;
	};
	if (_class isKindOf ["CA_Magazine", configfile >> "CfgMagazines"]) then
	{
		if (player canAddItemToUniform _class) then
		{
			(uniformContainer player) addMagazineAmmoCargo [_class, 1, _ammo];
		} else
		{
			_droppedContainer addMagazineAmmoCargo [_class, 1, _ammo];
		};
	} else
	{
		if (player canAddItemToUniform _class) then
		{
			player addItemToUniform _class;
		} else
		{
			_droppedContainer addItemCargoGlobal [_class, 1];
		};
	};
} forEach _allItems;
