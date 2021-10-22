#define VEHICLE_UNLOCKED(VEH) (locked (VEH) < 2 || (VEH) getVariable ["ownerUID","0"] isEqualTo getPlayerUID player)

private ["_vehicle", "_object", "_class", "_installing", "_isEmpty", "_cargos", "_cargoIndex", "_cargo", "_installed_object", "_attachTargets", "_attachPos", "_turrets", "_attachIndex"];

if (R3F_LOG_mutex_local_verrou) then
{
	player globalChat STR_R3F_LOG_mutex_action_en_cours;
}
else
{
	R3F_LOG_mutex_local_verrou = true;

	_object = R3F_LOG_joueur_deplace_objet;
	_vehicle = nearestObjects [_object, ["B_Truck_01_transport_F", "O_Truck_03_transport_F", "I_Truck_02_transport_F", "C_Offroad_01_F", "C_Van_01_transport_F", "B_Truck_01_cargo_F", "B_Truck_01_flatbed_F"], 22];

	if (count _vehicle > 0) then
	{
		_vehicle = _vehicle select 0;
		_class = typeOf _vehicle;
		_installing = _vehicle getVariable ["R3F_LOG_transport_installing", false];

		if (alive _vehicle && ((velocity _vehicle) call BIS_fnc_magnitude < 6) && (getPos _vehicle select 2 < 2) && VEHICLE_UNLOCKED(_vehicle) && !(_vehicle getVariable "R3F_LOG_disabled") && !_installing) then
		{
			_isEmpty = true;
			_cargos = [
				["B_Truck_01_transport_F",[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16],[0.03,-2.3,0.1]],
				["O_Truck_03_transport_F",[1,2,3,4,5,6,7,8,9,10,11,12],[0.05,-2.6,0.2]],
				["I_Truck_02_transport_F",[2,3,4,5,6,7,8,9,10,11,12,13,14,15],[0.01,-1.3,-0.2]],
				["C_Offroad_01_F",[1,2,3,4],[-0.05,-1.8,0]],
				["C_Van_01_transport_F",[2,3,4,5,6,7,8,9,10,11],[0,-1.7,0]],
				["B_Truck_01_cargo_F",[],[0,-1.2,0.1]],
				["B_Truck_01_flatbed_F",[],[0.05,-1.75,-0.2]]
			];
			_cargoIndex = _cargos findIf {_x select 0 == _class};
			_cargo = [];
			if (_cargoIndex != -1) then { _cargo = _cargos select _cargoIndex select 1 };
			if (_class in ["B_Truck_01_cargo_F", "B_Truck_01_flatbed_F"]) then
			{
				if (count (getVehicleCargo _vehicle) > 0) then { _isEmpty = false; };
			} else
			{
				{
					private _index = _vehicle getCargoIndex _x;
					switch (_class) do
					{
						case "B_Truck_01_transport_F":
						{
							if (_index in _cargo) exitWith {
								_isEmpty = false;
							};
						};
						case "O_Truck_03_transport_F":
						{
							if (_index in _cargo) exitWith {
								_isEmpty = false;
							};
						};
						case "I_Truck_02_transport_F":
						{
							if (_index in _cargo) exitWith {
								_isEmpty = false;
							};
						};
						case "C_Offroad_01_F":
						{
							if (_index in _cargo) exitWith {
								_isEmpty = false;
							};
						};
						case "C_Van_01_transport_F":
						{
							if (_index in _cargo) exitWith {
								_isEmpty = false;
							};
						};
					};
				} forEach (crew _vehicle);
			};
			if (_isEmpty) then
			{
				_installed_object = _vehicle getVariable ["R3F_LOG_installed_object", objNull];
				if (isNull _installed_object) then
				{
					player globalChat STR_R3F_LOG_action_installing;
					_vehicle setVariable ["R3F_LOG_transport_installing", true, true];
					if (_class in ["B_Truck_01_cargo_F", "B_Truck_01_flatbed_F"]) then
					{
						_vehicle enableVehicleCargo false;
					} else
					{
						{ _vehicle lockCargo [_x, true]; } forEach _cargo;
					};
					sleep 4;

					_turrets = [
						["B_Radar_System_01_F", [0,0.8,0.7]],
						["O_Radar_System_02_F",[0,1.2,1.2]],
						["B_SAM_System_03_F", [0,0.8,1.5]],
						["O_SAM_System_04_F", [0,0.8,0]],
						["B_SAM_System_01_F", [0,-0.4,1.1]],
						["B_SAM_System_02_F",[0,0,1.28]],
						["B_AAA_System_01_F", [0,0.5,1.9]],
						["B_Mortar_01_F", [0,-0.4,0.1]]
					];
					_attachPos = (_cargos select _cargoIndex) select 2;
					_attachIndex = _turrets findIf {_x select 0 == (typeOf _object)};
					_attachPos = _attachPos vectorAdd (_turrets select _attachIndex select 1);
				if ({ typeOf _object == _x } count ["O_SAM_System_04_F", "O_Radar_System_02_F", "B_SAM_System_03_F", "B_Radar_System_01_F"] > 0) then
					{
						_object setVariable ["R3F_Install_texture", (getObjectTextures _object) select 0, true];
						_object setObjectTextureGlobal [0, ""];
					};
					R3F_LOG_joueur_deplace_objet = objNull;
					_object attachTo [_vehicle, _attachPos];
					_vehicle setVariable ["R3F_LOG_installed_object", _object, true];
					_object setVariable ["R3F_LOG_transport_installed", _vehicle, true];
					player globalChat STR_R3F_LOG_action_installed;
					_vehicle setVariable ["R3F_LOG_transport_installing", false, true];
				} else
				{
					player globalChat STR_R3F_LOG_action_install_exist;
				};
			} else
			{
				player globalChat STR_R3F_LOG_action_install_cargo;
			};
		} else
		{
			if (alive _vehicle) then
			{
				if (_installing) then
				{
					player globalChat STR_R3F_LOG_action_installing_in_progress;
				} else
				{
					player globalChat STR_R3F_LOG_action_install_locked;
				};
			} else
			{
				player globalChat STR_R3F_LOG_action_install_damaged;
			};
		};
	} else
	{
		player globalChat STR_R3F_LOG_action_install_empty;
	};

	R3F_LOG_mutex_local_verrou = false;
};
