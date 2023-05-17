if (!hasInterface) exitWith {};

(findDisplay 46) displayAddEventHandler ["KeyDown", 
{
	if (currentweapon player == "hgun_esd_01_F") then
	{
		if ((_this select 1) in actionKeys "ReloadMagazine") then
		{
			if (!visiblemap && {alldisplays find finddisplay 46 == count alldisplays - 2}) then
			{
				_currentAntenna = (player weaponAccessories currentweapon player) # 0;
				_antennas = (["muzzle_antenna_01_f","muzzle_antenna_02_f"]) - [_currentAntenna]; // antenna sell for 0 price since this free switch
				_newAntenna = _antennas param [0,""];
				if (_newAntenna != "" && count _antennas == 1) then {
					[_currentAntenna,_newAntenna] spawn {
						params ["_currentAntenna","_newAntenna"];

						playsound (["Sa_Equip_Antenna_01","Sa_Equip_Antenna_02"] select (_newAntenna == "muzzle_antenna_02_f"));
						player playactionnow "GestureChangeAntenna";
						_time = time + 0.55; waituntil {time > _time};
						player removehandgunitem _currentAntenna;
						_time = time + 1.175; waituntil {time > _time};
						player addhandgunitem _newAntenna;
						_time = time + 1.00; waituntil {time > _time};
					};
				};
			};
		};
	};
}];
