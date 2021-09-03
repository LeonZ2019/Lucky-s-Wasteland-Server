#define VEHICLE_UNLOCKED(VEH) (locked (VEH) < 2 || (VEH) getVariable ["ownerUID","0"] isEqualTo getPlayerUID player)

/*
Compat Mega List
== Hemtt Compat ==
O_SAM_System_04_F setObjectTextureGlobal [0,""] [0, -1, .05]
O_Radar_System_02_F setObjectTextureGlobal [0,""] [0, -.2, 1]
B_SAM_System_03_F setObjectTextureGlobal [0,""] [0, -.5, 1.6]
B_Radar_System_01_F setObjectTextureGlobal [0,""] [0, -1, .52]
B_SAM_System_01_F [0, -1.5, .95]
B_SAM_System_02_F [0, -2.2, 1.1]
B_AAA_System_01_F [0,-1,1.7]

== Tempest Compat ==
O_SAM_System_04_F setObjectTextureGlobal [0,""] [0,-2,.05]
O_Radar_System_02_F setObjectTextureGlobal [0,""] [0, -1.2, 1.05]
B_SAM_System_03_F setObjectTextureGlobal [0,""] [0, -1.9, 1.8]
B_Radar_System_01_F setObjectTextureGlobal [0,""] [0, -2, .73]
B_SAM_System_01_F [0, -3, 1.157]
B_SAM_System_02_F [0, -3, 1.31]
B_AAA_System_01_F [0,-2,1.91]

== Zamak Compat ==
O_SAM_System_04_F setObjectTextureGlobal [0,""] [0,-.7,.06]
O_Radar_System_02_F setObjectTextureGlobal [0,""] [0, -.2, .9]
B_SAM_System_03_F setObjectTextureGlobal [0,""] [0, -.8, 1.62]
B_Radar_System_01_F setObjectTextureGlobal [0,""] [0, -1, .52]
B_SAM_System_01_F [0, -1, .97]
B_SAM_System_02_F [0, -2, 1.11]
B_AAA_System_01_F [0,-.5,1.71]

== Truck ==
B_AAA_System_01_F [0,-1.1,2]

== Offroad ==
B_Mortar_01_F [0,-2.2,0.1]

Cargo locked
Tempes Transport 1 - 12
Truck 2 - 11
Offroad 1 - 4
*/

if (R3F_LOG_mutex_local_verrou) then
{
	player globalChat STR_R3F_LOG_mutex_action_en_cours;
}
else
{
	R3F_LOG_mutex_local_verrou = true;

	private ["_object", "_installable_vehicles", "_vehicle", "_vehicleMatched"];

	_object = R3F_LOG_joueur_deplace_objet;
	_installable_vehicles = ["B_Truck_01_flatbed_F", "C_Van_01_transport_F"];
	_vehicle = nearestObjects [_object, _installable_vehicles, 22];

	if (count _vehicle > 0) then
	{
		_vehicle = _vehicle select 0;
		_vehicleMatched = false;
		if ({typeOf _vehicle == _x} count _installable_vehicles > 0) then
		{
			_vehicleMatched = true;
		}
		if (_vehicleMatched && alive _vehicle && ((velocity _vehicle) call BIS_fnc_magnitude < 6) && (getPos _vehicle select 2 < 2) && VEHICLE_UNLOCKED(_vehicle) && !(_vehicle getVariable "R3F_LOG_disabled")) then // add support flatbed
		{
			private ["_installed_object", "_attachTargets", "_attachPos"];
			_installed_object = _vehicle getVariable ["R3F_LOG_installed_object", objNull];

			if (isNull _installed_object) then
			{
				// On mémorise sur le réseau le nouveau contenu du véhicule
				_vehicle setVariable ["R3F_LOG_installed_object", _object, true];
				_object setVariable ["R3F_LOG_transport_installed", _vehicle, true];

				player globalChat STR_R3F_LOG_action_installing;
				sleep 4;

				_attachTargets = switch (typeOf _vehicle) do
				{
					case "B_Truck_01_flatbed_F":
					{
						[[0, -1, .05], [0, -.2, 1], [0, -.5, 1.6], [0, -1, .52], [0, -1.5, .95], [0, -2.2, 1.1], [0,-1, 1.7]]
					};
					case "C_Van_01_transport_F";
					default {
						private _cargoLock = 1;
						while {_cargoLock <= 4} do {
							_vehicle lockCargo [_cargoLock, true];
							_cargoLock = _cargoLock + 1;
						};
						[0,-1.1,2]
					};
				};
				_attachPos = [0, 0, 0];
				if (count _attachTargets == 3) then
				{
					_attachPos = _attachTargets;
				} else {
					_attachPos = switch (typeOf _object) do
					{
						case "O_SAM_System_04_F": { _attachTargets select 0 };
						case "O_Radar_System_02_F": { _attachTargets select 1 };
						case "B_SAM_System_03_F": { _attachTargets select 2 };
						case "B_Radar_System_01_F": { _attachTargets select 3 };
						case "B_SAM_System_01_F": { _attachTargets select 4 };
						case "B_SAM_System_02_F": { _attachTargets select 5 };
						case "B_AAA_System_01_F": { _attachTargets select 6 };
					};
				};
				if ({ typeOf _object == _x } count ["O_SAM_System_04_F", "O_Radar_System_02_F", "B_SAM_System_03_F", "B_Radar_System_01_F"] > 0) then
				{
					_object setVariable ["R3F_Install_texture", (getObjectTextures _object) select 0, true];
					_object setObjectTextureGlobal [0, ""];
				};
				R3F_LOG_joueur_deplace_objet = objNull;
				_object attachTo [_vehicle, _attachPos];

				player globalChat STR_R3F_LOG_action_installed;
			}
			else
			{
				player globalChat STR_R3F_LOG_action_charger_deplace_pas_assez_de_place;
			};
		} else {
			player globalChat "No match on flatbed variant truck.";
		};
	};

	R3F_LOG_mutex_local_verrou = false;
};
