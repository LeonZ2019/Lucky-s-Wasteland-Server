/**
 * Vérifie régulièrement des conditions portant sur l'objet pointé par l'arme du joueur
 * Permet de diminuer la fréquence des vérifications des conditions normalement faites dans les addAction (~60Hz)
 * La justification de ce système est que les conditions sont très complexes (count, nearestObjects)
 *
 * Copyright (C) 2010 madbull ~R3F~
 *
 * This program is free software under the terms of the GNU General Public License version 3.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
private ["_objet_pointe", "_resetConditions", "_hasNoProhibitedCargo"];

_resetConditions =
{
	R3F_LOG_action_deplacer_objet_valide = false;
	R3F_LOG_action_detacher_valide = false;
	R3F_LOG_action_charger_deplace_valide = false;
	R3F_LOG_action_charger_selection_valide = false;
	R3F_LOG_action_contenu_vehicule_valide = false;
	R3F_LOG_action_install_valid = false;
	R3F_LOG_action_uninstall_valid = false;
	R3F_LOG_action_remorquer_deplace_valide = false;
	R3F_LOG_action_remorquer_selection_valide = false;
	R3F_LOG_action_selectionner_objet_remorque_valide = false;
	R3F_LOG_action_selectionner_objet_charge_valide = false;
	R3F_LOG_action_heliporter_valide = false;
	R3F_LOG_action_heliport_larguer_valide = false;
	R3F_LOG_action_objet_platform_rotate_up = false;
	R3F_LOG_action_objet_platform_rotate_down = false;
	R3F_LOG_action_objet_platform_add = false;
	R3F_LOG_action_objet_platform_remove = false;
	R3F_LOG_action_objet_platform_panel = [];
};

_hasNoProhibitedCargo =
{
	private _ammoCargo = getAmmoCargo _this;
	private _repairCargo = getRepairCargo _this;

	if (isNil "_ammoCargo" || {!finite _ammoCargo}) then { _ammoCargo = 0 };
	if (isNil "_repairCargo" || {!finite _repairCargo}) then { _repairCargo = 0 };

	(_ammoCargo <= 0 && _repairCargo <= 0)
};

#define VEHICLE_UNLOCKED(VEH) (locked (VEH) < 2 || (VEH) getVariable ["ownerUID","0"] isEqualTo getPlayerUID player)

while {true} do
{
	R3F_LOG_objet_addAction = objNull;

	_objet_pointe = getCursorObjectParams select 0;

	if (vehicle player == player && !isNull _objet_pointe && {player distance _objet_pointe < 14 && getObjectType _objet_pointe == 8}) then
	{
		R3F_LOG_objet_addAction = _objet_pointe;

		// Note : les expressions de conditions ne sont pas factorisées pour garder de la clarté (déjà que c'est pas vraiment ça) (et le gain serait minime)

		Object_canLock = !(_objet_pointe getVariable ['objectLocked', false]);

		// Si l'objet est un objet déplaçable
		if ({_objet_pointe isKindOf _x} count R3F_LOG_CFG_objets_deplacables > 0) then
		{
			// Condition action deplacer_objet
			R3F_LOG_action_deplacer_objet_valide =
				alive _objet_pointe &&
				{getText (configFile >> "CfgVehicles" >> typeOf _x >> "simulation") != "UAVPilot"} count crew _objet_pointe == 0 &&
				isNull R3F_LOG_joueur_deplace_objet &&
				{!alive (_objet_pointe getVariable "R3F_LOG_est_deplace_par")} &&
				{isNull (_objet_pointe getVariable "R3F_LOG_est_transporte_par")} &&
				VEHICLE_UNLOCKED(_objet_pointe) &&
				UAVControl getConnectedUAV player select 1 == "" &&
				{!(_objet_pointe getVariable "R3F_LOG_disabled")};
		};

		// Si l'objet est un objet remorquable
		if ({_objet_pointe isKindOf _x} count R3F_LOG_CFG_objets_remorquables > 0) then
		{
			// Condition action selectionner_objet_remorque // edit here
			R3F_LOG_action_selectionner_objet_remorque_valide =
				alive _objet_pointe &&
				isNull R3F_LOG_joueur_deplace_objet &&
				{isNull driver _objet_pointe || unitIsUAV _objet_pointe} && // allow UAV towing
				{isNull (_objet_pointe getVariable "R3F_LOG_est_transporte_par")} &&
				{!alive (_objet_pointe getVariable "R3F_LOG_est_deplace_par")} &&
				VEHICLE_UNLOCKED(_objet_pointe) &&
				{!(_objet_pointe getVariable "R3F_LOG_disabled")} &&
				UAVControl getConnectedUAV player select 1 == "" &&
				{_objet_pointe call _hasNoProhibitedCargo};

			// Condition action detacher
			R3F_LOG_action_detacher_valide =
				isNull R3F_LOG_joueur_deplace_objet &&
				UAVControl getConnectedUAV player select 1 == "" &&
				{!isNull (_objet_pointe getVariable "R3F_LOG_est_transporte_par") && {VEHICLE_UNLOCKED(_objet_pointe getVariable "R3F_LOG_est_transporte_par")}} &&
				{!(_objet_pointe getVariable "R3F_LOG_disabled")};

			// S'il est déplaçable
			if ({_objet_pointe isKindOf _x} count R3F_LOG_CFG_objets_deplacables > 0) then
			{
				// Condition action remorquer_deplace
				R3F_LOG_action_remorquer_deplace_valide =
					alive R3F_LOG_joueur_deplace_objet &&
					{R3F_LOG_joueur_deplace_objet == _objet_pointe} &&
					{{
						alive _x &&
						_x != _objet_pointe &&
						{isNull (_x getVariable "R3F_LOG_remorque")} &&
						{vectorMagnitude velocity _x < 6} &&
						{(getPos _x) select 2 < 2} &&
						VEHICLE_UNLOCKED(_x) &&
						{!(_x getVariable "R3F_LOG_disabled")}
					} count nearestObjects [_objet_pointe, R3F_LOG_CFG_remorqueurs, 18] > 0} &&
					VEHICLE_UNLOCKED(_objet_pointe) &&
					{!(_objet_pointe getVariable "R3F_LOG_disabled")};

				if ({_objet_pointe isKindOf (_x select 0)} count R3F_LOG_CFG_objets_transportables > 0) then
				{
					// Disable towing on loadable objects
					R3F_LOG_action_selectionner_objet_remorque_valide = false;
				};
			};
		};

		// Si l'objet est un objet transportable
		if ({_objet_pointe isKindOf _x} count R3F_LOG_classes_objets_transportables > 0) then
		{
			// Et qu'il est déplaçable
			if ({_objet_pointe isKindOf _x} count R3F_LOG_CFG_objets_deplacables > 0) then
			{
				// Condition action charger_deplace
				R3F_LOG_action_charger_deplace_valide =
					{getText (configFile >> "CfgVehicles" >> typeOf _x >> "simulation") != "UAVPilot"} count crew _objet_pointe == 0 &&
					R3F_LOG_joueur_deplace_objet == _objet_pointe &&
					{{
						alive _x &&
						_x != _objet_pointe &&
						{vectorMagnitude velocity _x < 6} &&
						{(getPos _x) select 2 < 2} &&
						VEHICLE_UNLOCKED(_x) &&
						{!(_x getVariable "R3F_LOG_disabled")}
					} count nearestObjects [_objet_pointe, R3F_LOG_classes_transporteurs, 18] > 0} &&
					VEHICLE_UNLOCKED(_objet_pointe) &&
					UAVControl getConnectedUAV player select 1 == "" &&
					{!(_objet_pointe getVariable ["Mission_AirdropOnly", false])} &&
					{!(_objet_pointe getVariable "R3F_LOG_disabled")};
			};

			// Condition action selectionner_objet_charge
			R3F_LOG_action_selectionner_objet_charge_valide =
				alive _objet_pointe &&
				{getText (configFile >> "CfgVehicles" >> typeOf _x >> "simulation") != "UAVPilot"} count crew _objet_pointe == 0 &&
				isNull R3F_LOG_objet_selectionne &&
				isNull R3F_LOG_joueur_deplace_objet &&
				{isNull (_objet_pointe getVariable "R3F_LOG_est_transporte_par")} &&
				{!alive (_objet_pointe getVariable "R3F_LOG_est_deplace_par")} &&
				VEHICLE_UNLOCKED(_objet_pointe) &&
				UAVControl getConnectedUAV player select 1 == "" &&
				{!(_objet_pointe getVariable ["Mission_AirdropOnly", false])} &&
				{!(_objet_pointe getVariable "R3F_LOG_disabled")};
		};

		// Si l'objet est un véhicule remorqueur
		if ({_objet_pointe isKindOf _x} count R3F_LOG_CFG_remorqueurs > 0) then
		{
			// Condition action remorquer_deplace
			R3F_LOG_action_remorquer_deplace_valide =
				isNull R3F_LOG_objet_selectionne &&
				alive _objet_pointe &&
				alive R3F_LOG_joueur_deplace_objet &&
				VEHICLE_UNLOCKED(R3F_LOG_joueur_deplace_objet) &&
				{!(R3F_LOG_joueur_deplace_objet getVariable "R3F_LOG_disabled")} &&
				{{R3F_LOG_joueur_deplace_objet isKindOf _x} count R3F_LOG_CFG_objets_remorquables > 0 &&
					(_objet_pointe getVariable ["R3F_LOG_remorqueurH",false] || {{R3F_LOG_joueur_deplace_objet isKindOf _x} count R3F_LOG_CFG_objets_remorquablesH == 0})} &&
				{isNull (_objet_pointe getVariable "R3F_LOG_remorque")} &&
				{vectorMagnitude velocity _objet_pointe < 6} &&
				{(getPos _objet_pointe) select 2 < 2} &&
				VEHICLE_UNLOCKED(_objet_pointe) &&
				{!(_objet_pointe getVariable "R3F_LOG_disabled")} &&
				{{_objet_pointe isKindOf (_x select 0)} count R3F_LOG_CFG_objets_transportables == 0} &&
				{R3F_LOG_joueur_deplace_objet call _hasNoProhibitedCargo && _objet_pointe call _hasNoProhibitedCargo};

			// Condition action remorquer_selection
			R3F_LOG_action_remorquer_selection_valide =
				alive _objet_pointe &&
				isNull R3F_LOG_joueur_deplace_objet &&
				!isNull R3F_LOG_objet_selectionne &&
				{R3F_LOG_objet_selectionne != _objet_pointe} &&
				VEHICLE_UNLOCKED(R3F_LOG_objet_selectionne) &&
				{!(R3F_LOG_objet_selectionne getVariable "R3F_LOG_disabled")} &&
				{{R3F_LOG_objet_selectionne isKindOf _x} count R3F_LOG_CFG_objets_remorquables > 0 &&
					(_objet_pointe getVariable ["R3F_LOG_remorqueurH",false] || {{R3F_LOG_objet_selectionne isKindOf _x} count R3F_LOG_CFG_objets_remorquablesH == 0})} &&
				{isNull (_objet_pointe getVariable "R3F_LOG_remorque")} &&
				{vectorMagnitude velocity _objet_pointe < 6} &&
				{(getPos _objet_pointe) select 2 < 2} &&
				VEHICLE_UNLOCKED(_objet_pointe) &&
				{!(_objet_pointe getVariable "R3F_LOG_disabled")} &&
				{_objet_pointe call _hasNoProhibitedCargo};
		};

		// Si l'objet est un véhicule transporteur
		if ({_objet_pointe isKindOf _x} count R3F_LOG_classes_transporteurs > 0) then
		{
			// Condition action charger_deplace
			R3F_LOG_action_charger_deplace_valide =
				alive _objet_pointe &&
				!isNull R3F_LOG_joueur_deplace_objet &&
				{R3F_LOG_joueur_deplace_objet != _objet_pointe} &&
				VEHICLE_UNLOCKED(R3F_LOG_joueur_deplace_objet) &&
				{!(R3F_LOG_joueur_deplace_objet getVariable "R3F_LOG_disabled")} &&
				{{R3F_LOG_joueur_deplace_objet isKindOf _x} count R3F_LOG_classes_objets_transportables > 0} &&
				{vectorMagnitude velocity _objet_pointe < 6} &&
				{(getPos _objet_pointe) select 2 < 2} &&
				VEHICLE_UNLOCKED(_objet_pointe) &&
				{!(R3F_LOG_joueur_deplace_objet getVariable ["Mission_AirdropOnly", false])} &&
				{!(_objet_pointe getVariable "R3F_LOG_disabled")};

			// Condition action charger_selection
			R3F_LOG_action_charger_selection_valide =
				alive _objet_pointe &&
				isNull R3F_LOG_joueur_deplace_objet &&
				!isNull R3F_LOG_objet_selectionne &&
				{R3F_LOG_objet_selectionne != _objet_pointe} &&
				VEHICLE_UNLOCKED(R3F_LOG_objet_selectionne) &&
				{!(R3F_LOG_objet_selectionne getVariable "R3F_LOG_disabled")} &&
				{{R3F_LOG_objet_selectionne isKindOf _x} count R3F_LOG_classes_objets_transportables > 0} &&
				{vectorMagnitude velocity _objet_pointe < 6} &&
				{(getPos _objet_pointe) select 2 < 2} &&
				VEHICLE_UNLOCKED(_objet_pointe) &&
				{!(_objet_pointe getVariable "R3F_LOG_disabled")};

			// Condition action contenu_vehicule
			R3F_LOG_action_contenu_vehicule_valide =
				alive _objet_pointe &&
				isNull R3F_LOG_joueur_deplace_objet &&
				{vectorMagnitude velocity _objet_pointe < 6} &&
				{(getPos _objet_pointe) select 2 < 2} &&
				VEHICLE_UNLOCKED(_objet_pointe) &&
				UAVControl getConnectedUAV player select 1 == "" &&
				{!(_objet_pointe getVariable "R3F_LOG_disabled")};

			// Install valid, mainly will check for target class and install type
			private _installable_targets = ["O_SAM_System_04_F", "O_Radar_System_02_F", "B_SAM_System_03_F", "B_Radar_System_01_F", "B_SAM_System_01_F", "B_SAM_System_02_F", "B_AAA_System_01_F"];
			R3F_LOG_action_install_valid =
				alive _objet_pointe &&
				!isNull R3F_LOG_joueur_deplace_objet &&
				{R3F_LOG_joueur_deplace_objet != _objet_pointe} &&
				VEHICLE_UNLOCKED(R3F_LOG_joueur_deplace_objet) &&
				{!(R3F_LOG_joueur_deplace_objet getVariable "R3F_LOG_disabled")} &&
				{vectorMagnitude velocity _objet_pointe < 6} &&
				{(getPos _objet_pointe) select 2 < 2} &&
				VEHICLE_UNLOCKED(_objet_pointe) &&
				{!(R3F_LOG_joueur_deplace_objet getVariable ["Mission_AirdropOnly", false])} &&
				{!(_objet_pointe getVariable "R3F_LOG_disabled")} &&
				isNull (_objet_pointe getVariable ["R3F_LOG_installed_object", objNull]) &&
				((typeOf R3F_LOG_joueur_deplace_objet in ["B_Mortar_01_F", "O_Mortar_01_F", "I_Mortar_01_F", "B_AAA_System_01_F", "B_static_AA_F", "O_static_AA_F", "I_static_AA_F", "B_static_AT_F", "O_static_AT_F", "I_static_AT_F"] && typeOf _objet_pointe == "C_Van_01_transport_F") || (typeOf R3F_LOG_joueur_deplace_objet in ["B_Mortar_01_F", "O_Mortar_01_F", "I_Mortar_01_F", "B_static_AA_F", "O_static_AA_F", "I_static_AA_F", "B_static_AT_F", "O_static_AT_F", "I_static_AT_F"] && typeOf _objet_pointe in "C_Offroad_01_F") || (typeOf R3F_LOG_joueur_deplace_objet in _installable_targets && typeOf _objet_pointe in ["B_Truck_01_transport_F", "O_Truck_03_transport_F", "I_Truck_02_transport_F"]) || (typeOf R3F_LOG_joueur_deplace_objet in _installable_targets && typeOf _objet_pointe in ["B_Truck_01_cargo_F", "B_Truck_01_flatbed_F"]));

			// Install valid, mainly will check for target class and install type
			R3F_LOG_action_uninstall_valid =
				alive (_objet_pointe getVariable "R3F_LOG_installed_object") &&
				(UAVControl getConnectedUAV player select 1) == "" &&
				{vectorMagnitude velocity _objet_pointe < 6} &&
				{(getPos _objet_pointe) select 2 < 2} &&
				VEHICLE_UNLOCKED(_objet_pointe) &&
				{!(_objet_pointe getVariable "R3F_LOG_disabled")} &&
				!isNull (_objet_pointe getVariable ["R3F_LOG_installed_object", objNull]);
		};
		if (_objet_pointe isKindOf "CargoPlatform_01_base_F") then
		{
			_cursorPos = ASLToAGL (lineIntersectsSurfaces [eyePos player, (ATLtoASL screenToWorld [0.5,0.5]), player, objNull, true,1] select 0 select 0);
			if (isNil "_cursorPos") exitWith {}; // distance more than 5km?
			_distance = worldSize;
			_panels = [["panel1","panel2"],["panel2","panel3"],["panel3","panel4"],["panel4","panel1"]];
			_panel = "";  
			{
			_betweenSelection = _x;
			_prev = _objet_pointe selectionPosition (_betweenSelection select 0);
			_next = _objet_pointe selectionPosition (_betweenSelection select 1);
			_panelOffset = _prev vectorAdd _next;
			{
				_panelOffset set [_forEachIndex, _x / 2];
			} forEach _panelOffset;
			_modelDist = (_objet_pointe modelToWorld _panelOffset) distance _cursorPos;
			if (_modelDist < _distance) then
			{
				_panel = _betweenSelection select 0;
				_distance = _modelDist;
			};
			} forEach _panels;
			_animPart = switch (_panel) do
			{
			case "panel1":
			{
				["panel_1_rotate", "panel_1_hide"]
			};
			case "panel2":
			{
				["panel_2_rotate", "panel_2_hide"]
			};
			case "panel3":
			{
				["panel_3_rotate", "panel_3_hide"]
			};
			case "panel4":
			{
				["panel_4_rotate", "panel_4_hide"]
			};
			default
			{
				[]
			};
			};
			R3F_LOG_action_objet_platform_panel = _animPart;
			R3F_LOG_action_objet_platform_rotate_up = (alive _objet_pointe && _cursorPos distance player < 5 && count _animPart == 2 && _objet_pointe animationPhase (_animPart select 0) > 0 && _objet_pointe animationPhase (_animPart select 1) == 0);
			R3F_LOG_action_objet_platform_rotate_down = (alive _objet_pointe && _cursorPos distance player < 5 && count _animPart == 2 && _objet_pointe animationPhase (_animPart select 0) < pi && _objet_pointe animationPhase (_animPart select 1) == 0);
			R3F_LOG_action_objet_platform_add = (alive _objet_pointe && _cursorPos distance player < 5 && count _animPart == 2 && _objet_pointe animationPhase (_animPart select 1) == 1);
			R3F_LOG_action_objet_platform_remove = (alive _objet_pointe && _cursorPos distance player < 5 && count _animPart == 2 && _objet_pointe animationPhase (_animPart select 1) == 0);
		};
	}
	else
	{
		call _resetConditions;
	};

	// Pour l'héliportation, l'objet n'est plus pointé, mais on est dedans
	// Si le joueur est dans un héliporteur
	if ({(vehicle player) isKindOf _x} count R3F_LOG_CFG_heliporteurs > 0) then
	{
		R3F_LOG_objet_addAction = vehicle player;

		// On est dans le véhicule, on affiche pas les options de transporteur et remorqueur
		call _resetConditions;

		// Condition action heliporter
		R3F_LOG_action_heliporter_valide =
			driver R3F_LOG_objet_addAction == player &&
			{{_x != R3F_LOG_objet_addAction && VEHICLE_UNLOCKED(_x) && !(_x getVariable "R3F_LOG_disabled")} count ((nearestObjects [R3F_LOG_objet_addAction, R3F_LOG_CFG_objets_heliportables, 15]) select {_obj = _x; _x call _hasNoProhibitedCargo && alive _x && (R3F_LOG_objet_addAction getVariable ["R3F_LOG_heliporteurH",false] || {{_obj isKindOf _x} count R3F_LOG_CFG_objets_heliportablesH == 0})}) > 0} &&
			{isNull (R3F_LOG_objet_addAction getVariable "R3F_LOG_heliporte")} &&
			{vectorMagnitude velocity R3F_LOG_objet_addAction < 6} &&
			{(getPos R3F_LOG_objet_addAction) select 2 > 1} &&
			VEHICLE_UNLOCKED(R3F_LOG_objet_addAction) &&
			{!(R3F_LOG_objet_addAction getVariable "R3F_LOG_disabled")} &&
			{R3F_LOG_objet_addAction call _hasNoProhibitedCargo};

		// Condition action heliport_larguer
		R3F_LOG_action_heliport_larguer_valide =
			driver R3F_LOG_objet_addAction == player &&
			{!isNull (R3F_LOG_objet_addAction getVariable "R3F_LOG_heliporte")} &&
			//{vectorMagnitude velocity R3F_LOG_objet_addAction < 15} &&
			//{(getPos R3F_LOG_objet_addAction) select 2 < 40} &&
			{!(R3F_LOG_objet_addAction getVariable "R3F_LOG_disabled")} &&
			{(getPosATL (R3F_LOG_objet_addAction getVariable "R3F_LOG_heliporte") select 2) >= 0};
	};

	sleep 0.3;
};
