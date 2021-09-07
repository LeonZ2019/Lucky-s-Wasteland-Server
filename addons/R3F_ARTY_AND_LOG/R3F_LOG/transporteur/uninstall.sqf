disableSerialization;

if (R3F_LOG_mutex_local_verrou) then
{
	player globalChat STR_R3F_LOG_mutex_action_en_cours;
}
else
{
	private ["_vehicle", "_installed_object", "_uninstalling", "_texture", "_cargos", "_cargo"];
	_vehicle = _this select 0;
	_installed_object = _vehicle getVariable ["R3F_LOG_installed_object", objNull];
	if (isNull _installed_object) then
	{
		player globalChat STR_R3F_LOG_action_uninstall_empty;
	} else
	{
		if (!(isNull (driver _vehicle))) then
		{
			player globalChat STR_R3F_LOG_action_uninstall_empty_driver;
		} else
		{
			_uninstalling = _vehicle getVariable ["R3F_LOG_transport_uninstalling", false];
			if (!_uninstalling) then
			{
				if (typeOf _installed_object in ["B_Mortar_01_F", "O_Mortar_01_F", "I_Mortar_01_F"] && !isNull (gunner _installed_object)) then
				{
					player globalChat STR_R3F_LOG_action_uninstall_empty_gunner;
				} else
				{
					player globalChat STR_R3F_LOG_action_uninstalling;
					_vehicle setVariable ["R3F_LOG_transport_uninstalling", true, true];
					sleep 4;
					_texture = _installed_object getVariable "R3F_Install_texture";
					if (!isNil "_texture") then
					{
						_installed_object setObjectTextureGlobal [0, _texture];
					};
					_vehicle setVariable ["R3F_LOG_installed_object", objNull, true];
					_installed_object setVariable ["R3F_LOG_transport_installed", objNull, true];
					[_installed_object] execVM "addons\R3F_ARTY_AND_LOG\R3F_LOG\objet_deplacable\deplacer.sqf";
					waitUntil {sleep 1; !R3F_LOG_mutex_local_verrou};
					if ((typeOf _vehicle) in ["B_Truck_01_cargo_F", "B_Truck_01_flatbed_F"]) then
					{
						_vehicle enableVehicleCargo true;
					} else
					{
						_cargos = [
							["B_Truck_01_transport_F",[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]],
							["O_Truck_03_transport_F",[1,2,3,4,5,6,7,8,9,10,11,12]],
							["I_Truck_02_transport_F",[2,3,4,5,6,7,8,9,10,11,12,13,14,15]],
							["C_Offroad_01_F",[1,2,3,4]],
							["C_Van_01_transport_F",[2,3,4,5,6,7,8,9,10,11]]
						];
						_cargo = _cargos select (_cargos findIf {_x select 0 == _class});
						{ _vehicle lockCargo [_x, false]; } forEach _cargo;
					};
					_vehicle setVariable ["R3F_LOG_transport_uninstalling", false, true];
				};
			} else
			{
				player globalChat STR_R3F_LOG_action_uninstalling_in_progress;
			};
		};
	};
};
