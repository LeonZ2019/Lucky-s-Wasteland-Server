disableSerialization;

if (R3F_LOG_mutex_local_verrou) then
{
	player globalChat STR_R3F_LOG_mutex_action_en_cours;
}
else
{
	private ["_vehicle", "_installed_object", "_chargement_maxi", "_contenu", "_tab_contenu_regroupe"];
	private ["_tab_objets", "_tab_quantite", "_i", "_j", "_dlg_contenu_vehicule"];
	// _transporteur -> _vehicle
	_vehicle = _this select 0;
	_installed_object = _vehicle getVariable ["R3F_LOG_installed_object", objNull];
	if (isNull _installed_object) then
	{
		player globalChat STR_R3F_LOG_action_uninstall_empty;
	} else
	{
		player globalChat STR_R3F_LOG_action_uninstalling;
		sleep 4;
		_texture = _installed_object getVariable "R3F_Install_texture";
		if (!isNil "_texture") then
		{
			_installed_object setObjectTextureGlobal [0, _texture];
		};
		_vehicle setVariable ["R3F_LOG_installed_object", objNull, true];
		_installed_object setVariable ["R3F_LOG_transport_installed", objNull, true];
		[_installed_object] execVM "addons\R3F_ARTY_AND_LOG\R3F_LOG\objet_deplacable\deplacer.sqf";
		if (typeOf _vehicle == "") then
		{
			waitUntil {sleep 1; !R3F_LOG_mutex_local_verrou};
			private _cargoLock = 1;
			while {_cargoLock <= 4} do {
				_vehicle lockCargo [_cargoLock, false];
				_cargoLock = _cargoLock + 1;
			};
		};
	};
};
