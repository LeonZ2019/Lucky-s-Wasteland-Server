// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2017 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: vehicleLoadouts.sqf
//	@file Author: AgentRev

/*
	HOW TO CREATE A PYLON LOADOUT:
	 1. Create new scenario in Eden, add vehicle, adjust pylon loadout, and set Object Init to: copyToClipboard str getPylonMagazines this
	 2. Play scenario, wait until loaded, then pause game and return to Eden.
	 3. Your pylon array is now in the clipboard, which you can paste in this file, e.g. _pylons = ["PylonMissile_Missile_AA_R73_x1","","","","","","","","","","","","",""];

	Note: You can use any pylon type you want in the script, even if not shown in the editor, it should normally work! e.g. "PylonRack_12Rnd_missiles" for "B_Plane_Fighter_01_F"
*/

switch (true) do
{
	// AH-9 Pawnee
	case (_class isKindOf "B_Heli_Light_01_dynamicLoadout_F"):
	{
		switch (_variant) do
		{
			case "pawneeGun": { _pylons = ["",""] };
			default { _pylons = ["PylonRack_12Rnd_missiles","PylonRack_12Rnd_missiles"] };
		};
	};

	// PO-30 Orca
	case (_class isKindOf "O_Heli_Light_02_dynamicLoadout_F"):
	{
		switch (_variant) do
		{
			case "orcaDAGR": { _pylons = ["PylonWeapon_2000Rnd_65x39_belt","PylonRack_12Rnd_PG_missiles"] };
			default { _pylons = ["PylonWeapon_2000Rnd_65x39_belt","PylonRack_12Rnd_missiles"] };
		};
	};

	// AH-99 Blackfoot
	case (_class isKindOf "Heli_Attack_01_dynamicLoadout_base_F"):
	{
		switch (_variant) do
		{
			case "toughAT": {
				_pylons = ["PylonRack_12Rnd_PG_missiles","","","","","PylonRack_12Rnd_PG_missiles"];
				_customCode = {
					_veh setVariable ["vehicle_tough", true, true];
					_veh removeMagazinesTurret ["PylonRack_4Rnd_LG_scalpel", [0]];
					_veh removeWeaponTurret ["missiles_SCALPEL", [0]];
					_veh addWeaponTurret ["missiles_SCALPEL", [0]];
					_veh addMagazineTurret ["PylonRack_4Rnd_LG_scalpel", [0], 4];
					_veh addMagazineTurret ["PylonRack_4Rnd_LG_scalpel", [0], 4];
					_veh addMagazineTurret ["PylonRack_4Rnd_LG_scalpel", [0], 4];
					_veh addMagazineTurret ["PylonRack_4Rnd_LG_scalpel", [0], 4];
				};
			};
			default { _pylons = ["PylonMissile_1Rnd_LG_scalpel","PylonMissile_1Rnd_LG_scalpel","PylonRack_12Rnd_missiles","PylonRack_12Rnd_missiles","PylonMissile_1Rnd_LG_scalpel","PylonMissile_1Rnd_LG_scalpel"] };
		};
	};

	// Mi-48 Kajman
	case (_class isKindOf "Heli_Attack_02_dynamicLoadout_base_F"):
	{
		switch (_variant) do
		{
			case "toughAT": {
				_pylons = ["PylonRack_4Rnd_LG_scalpel","PylonRack_4Rnd_LG_scalpel","PylonRack_4Rnd_LG_scalpel","PylonRack_4Rnd_LG_scalpel"];
				_customCode = {
					_veh setVariable ["vehicle_tough", true, true];
					_veh removeMagazinesTurret ["24Rnd_PG_missiles", [0]];
					_veh removeWeaponTurret ["missiles_DAGR", [0]];
					_veh addWeaponTurret ["missiles_DAGR", [0]];
					_veh addMagazineTurret ["24Rnd_PG_missiles", [0], 24];
					_veh addMagazineTurret ["24Rnd_PG_missiles", [0], 24];
				};
			};
			default { _pylons = ["PylonRack_19Rnd_Rocket_Skyfire","PylonRack_4Rnd_LG_scalpel","PylonRack_4Rnd_LG_scalpel","PylonRack_19Rnd_Rocket_Skyfire"] };
		};
	};

	// WY-55 Hellcat
	case (_class isKindOf "I_Heli_light_03_dynamicLoadout_F"):
	{
		_pylons = ["PylonRack_4Rnd_LG_scalpel","PylonRack_12Rnd_missiles"]
	};

	// Y-32 Xi'an
	case ({_class isKindOf _x} count ["VTOL_02_infantry_dynamicLoadout_base_F", "VTOL_02_vehicle_dynamicLoadout_base_F"] > 0):
	{
		_pylons = ["PylonRack_1Rnd_Missile_AGM_01_F","PylonRack_19Rnd_Rocket_Skyfire","PylonRack_19Rnd_Rocket_Skyfire","PylonRack_1Rnd_Missile_AGM_01_F"];
	};

	//
	case (_class isKindOf "C_Plane_Civil_01_racing_F"):
	{
		_mags =
		[
			["1000Rnd_20mm_shells", [-1]]
		];
		_weapons =
		[
			["Twin_Cannon_20mm", [-1]]
		];
	};

	// A-143 Buzzard
	case (_class isKindOf "Plane_Fighter_03_dynamicLoadout_base_F"):
	{
		_weapons =
		[
			["Laserdesignator_pilotCamera", [-1]],
			["CMFlareLauncher", [-1]]
		];
		_mags =
		[
			["Laserbatteries", [-1]],
			["240Rnd_CMFlare_Chaff_Magazine", [-1]]
		];

		_pylons = ["PylonRack_1Rnd_Missile_AA_04_F", "PylonRack_7Rnd_Rocket_04_AP_F", "PylonRack_3Rnd_LG_scalpel", "PylonWeapon_300Rnd_20mm_shells", "PylonRack_3Rnd_LG_scalpel", "PylonRack_7Rnd_Rocket_04_AP_F", "PylonRack_1Rnd_Missile_AA_04_F"];
		_customCode =
		{
			_veh removeMagazinesTurret ["PylonRack_2Rnd_BombCluster_01_F", [-1]];
			_veh removeWeaponTurret ["BombCluster_01_F", [-1]];
			_veh addWeaponTurret ["BombCluster_01_F", [-1]];
			_veh addMagazineTurret ["PylonRack_2Rnd_BombCluster_01_F", [-1], 2];

			_veh removeMagazinesTurret ["2Rnd_GBU12_LGB", [-1]];
			_veh removeWeaponTurret ["GBU12BombLauncher_Plane_Fighter_03_F", [-1]];
			_veh addWeaponTurret ["GBU12BombLauncher_Plane_Fighter_03_F", [-1]];
			_veh addMagazineTurret ["2Rnd_GBU12_LGB", [-1], 2];
	
			_veh removeMagazinesTurret ["1000Rnd_20mm_shells", [-1]];
			_veh addMagazineTurret ["1000Rnd_20mm_shells", [-1], 1000];
			_veh removeMagazinesTurret ["PylonWeapon_300Rnd_20mm_shells", [-1]];
			_veh removeMagazinesTurret ["300Rnd_20mm_shells", [-1]];
		};
	};

	// A-164 Wipeout
	case (_class isKindOf "B_Plane_CAS_01_dynamicLoadout_F"):
	{
		_mags =
		[
			["1000Rnd_Gatling_30mm_Plane_CAS_01_F", [-1]],
			["Laserbatteries", [-1]],
			["240Rnd_CMFlare_Chaff_Magazine", [-1]]
		];
		_pylons = ["PylonRack_1Rnd_Missile_AA_04_F","PylonRack_7Rnd_Rocket_04_AP_F","PylonRack_3Rnd_Missile_AGM_02_F","PylonMissile_1Rnd_Bomb_04_F","PylonMissile_1Rnd_BombCluster_03_F","PylonMissile_1Rnd_BombCluster_03_F", "PylonMissile_1Rnd_Bomb_04_F", "PylonRack_3Rnd_Missile_AGM_02_F", "PylonRack_7Rnd_Rocket_04_AP_F", "PylonRack_1Rnd_Missile_AA_04_F"];
	};

	// To-199 Neophron
	case (_class isKindOf "O_Plane_CAS_02_dynamicLoadout_F"):
	{
		_mags =
		[
			["500Rnd_Cannon_30mm_Plane_CAS_02_F", [-1]],
			["500Rnd_Cannon_30mm_Plane_CAS_02_F", [-1]],
			["Laserbatteries", [-1]],
			["240Rnd_CMFlare_Chaff_Magazine", [-1]]
		];
		_pylons = ["PylonRack_1Rnd_Missile_AA_03_F","PylonRack_3Rnd_LG_scalpel","PylonRack_20Rnd_Rocket_03_AP_F","PylonMissile_1Rnd_Bomb_03_F","PylonMissile_1Rnd_BombCluster_02_cap_F","PylonMissile_1Rnd_BombCluster_02_cap_F", "PylonMissile_1Rnd_Bomb_03_F", "PylonRack_20Rnd_Rocket_03_AP_F", "PylonRack_3Rnd_LG_scalpel", "PylonRack_1Rnd_Missile_AA_03_F"];
		_customCode =
		{
			_veh setAmmoOnPylon [3, 7];
			_veh setAmmoOnPylon [8, 7];
		};
	};

	// F/A-181 Black Wasp
	case (_class isKindOf "B_Plane_Fighter_01_F"):
	{
		_mags =
		[
			["magazine_Fighter01_Gun20mm_AA_x450", [-1]],
			["magazine_Fighter01_Gun20mm_AA_x450", [-1]],
			["Laserbatteries", [-1]],
			["240Rnd_CMFlare_Chaff_Magazine", [-1]]
		];
		switch (_variant) do
		{
			case "blackwaspAA": { _pylons = ["PylonRack_Missile_AMRAAM_D_x2","PylonRack_Missile_AMRAAM_D_x2","PylonRack_Missile_BIM9X_x2","PylonRack_Missile_BIM9X_x2","PylonMissile_Missile_BIM9X_x1","PylonMissile_Missile_BIM9X_x1","PylonMissile_Missile_AMRAAM_D_INT_x1","PylonMissile_Missile_AMRAAM_D_INT_x1","PylonMissile_Missile_AMRAAM_D_INT_x1","PylonMissile_Missile_AMRAAM_D_INT_x1","PylonMissile_Missile_AMRAAM_D_INT_x1","PylonMissile_Missile_AMRAAM_D_INT_x1"] };
			case "blackwaspCAS": {
				_pylons = ["PylonRack_Missile_AGM_02_x1","PylonRack_Missile_AGM_02_x1","PylonRack_Missile_AGM_02_x2","PylonRack_Missile_AGM_02_x2","PylonMissile_Missile_BIM9X_x1","PylonMissile_Missile_BIM9X_x1","PylonMissile_Missile_AMRAAM_D_INT_x1","PylonMissile_Missile_AMRAAM_D_INT_x1","PylonRack_Bomb_GBU12_x2","PylonRack_Bomb_GBU12_x2","PylonRack_2Rnd_BombCluster_01_F","PylonRack_2Rnd_BombCluster_01_F"];
			};
		};
	};

	// F/A-181 Black Wasp (Stealth)
	case (_class isKindOf "B_Plane_Fighter_01_Stealth_F"):
	{
		_mags =
		[
			["magazine_Fighter01_Gun20mm_AA_x450", [-1]],
			["magazine_Fighter01_Gun20mm_AA_x450", [-1]],
			["magazine_Fighter01_Gun20mm_AA_x450", [-1]],
			["magazine_Fighter01_Gun20mm_AA_x450", [-1]], // extra gun mags to make up for lack of pylons (non-explosive ammo)
			["Laserbatteries", [-1]],
			["300Rnd_CMFlare_Chaff_Magazine", [-1]]
		];
		_pylons = ["","","","","","","","","PylonWeapon_300Rnd_20mm_shells","PylonWeapon_300Rnd_20mm_shells","",""];
	};

	// To-201 Shikra
	case (_class isKindOf "O_Plane_Fighter_02_F"):
	{
		_mags =
		[
			["magazine_Fighter02_Gun30mm_AA_x180", [-1]],
			["magazine_Fighter02_Gun30mm_AA_x180", [-1]],
			["magazine_Fighter02_Gun30mm_AA_x180", [-1]],
			["magazine_Fighter02_Gun30mm_AA_x180", [-1]],
			["magazine_Fighter02_Gun30mm_AA_x180", [-1]],
			["Laserbatteries", [-1]],
			["300Rnd_CMFlare_Chaff_Magazine", [-1]]
		];
		switch (_variant) do
		{
			case "shikraAA": {
				_pylons = ["PylonMissile_Missile_AA_R77_x1","PylonMissile_Missile_AA_R77_x1","PylonMissile_Missile_AA_R77_x1","PylonMissile_Missile_AA_R77_x1","PylonMissile_Missile_AA_R77_x1","PylonMissile_Missile_AA_R77_x1","","","PylonMissile_Missile_AA_R77_x1","PylonMissile_Missile_AA_R77_x1","PylonMissile_Missile_AA_R77_INT_x1","PylonMissile_Missile_AA_R77_INT_x1",""];
				_customCode =
				{
					_veh removeMagazinesTurret ["PylonMissile_Missile_AA_R73_x1", [-1]];
					_veh removeWeaponTurret ["weapon_R73Launcher", [-1]];
					_veh addWeaponTurret ["weapon_R73Launcher", [-1]];
					_veh addMagazineTurret ["PylonMissile_Missile_AA_R73_x1", [-1], 1];
					_veh addMagazineTurret ["PylonMissile_Missile_AA_R73_x1", [-1], 1];
					_veh addMagazineTurret ["PylonMissile_Missile_AA_R73_x1", [-1], 1];
					_veh addMagazineTurret ["PylonMissile_Missile_AA_R73_x1", [-1], 1];
					_veh addMagazineTurret ["PylonMissile_Missile_AA_R73_x1", [-1], 1];
					_veh addMagazineTurret ["PylonMissile_Missile_AA_R73_x1", [-1], 1];
				};
			};
			case "shikraCAS": {
				_pylons = ["PylonMissile_Missile_AGM_KH25_x1","PylonMissile_Missile_AGM_KH25_x1","PylonMissile_Missile_AGM_KH25_x1","PylonMissile_Missile_AGM_KH25_x1","PylonMissile_Missile_AGM_KH25_x1","PylonMissile_Missile_AGM_KH25_x1","PylonMissile_Missile_AA_R73_x1","PylonMissile_Missile_AA_R73_x1","PylonMissile_Bomb_KAB250_x1","PylonMissile_Bomb_KAB250_x1","PylonMissile_Bomb_KAB250_x1","PylonMissile_Bomb_KAB250_x1",""];
				_customCode =
				{
					_veh removeMagazinesTurret ["PylonMissile_1Rnd_BombCluster_02_F", [-1]];
					_veh removeWeaponTurret ["BombCluster_02_F", [-1]];
					_veh addWeaponTurret ["BombCluster_02_F", [-1]];
					_veh addMagazineTurret ["PylonMissile_1Rnd_BombCluster_02_F", [-1], 1];
					_veh addMagazineTurret ["PylonMissile_1Rnd_BombCluster_02_F", [-1], 1];
					_veh addMagazineTurret ["PylonMissile_1Rnd_BombCluster_02_F", [-1], 1];
					_veh addMagazineTurret ["PylonMissile_1Rnd_BombCluster_02_F", [-1], 1];
					_veh removeMagazinesTurret ["magazine_Missile_AA_R77_x1", [-1]];
					_veh removeWeaponTurret ["weapon_R77Launcher", [-1]];
					_veh addWeaponTurret ["weapon_R77Launcher", [-1]];
					_veh addMagazineTurret ["magazine_Missile_AA_R77_x1", [-1], 1];
					_veh addMagazineTurret ["magazine_Missile_AA_R77_x1", [-1], 1];
				};
			};
		};
	};

	// To-201 Shikra (Stealth)
	case (_class isKindOf "O_Plane_Fighter_02_Stealth_F"):
	{
		_mags =
		[
			["magazine_Fighter02_Gun30mm_AA_x180", [-1]],
			["magazine_Fighter02_Gun30mm_AA_x180", [-1]],
			["magazine_Fighter02_Gun30mm_AA_x180", [-1]],
			["magazine_Fighter02_Gun30mm_AA_x180", [-1]],
			["Laserbatteries", [-1]],
			["240Rnd_CMFlare_Chaff_Magazine", [-1]]
		];
		_pylons = ["","","","","","","","","","","PylonWeapon_300Rnd_20mm_shells","PylonWeapon_300Rnd_20mm_shells",""];
	};

	// A-149 Gryphon
	case (_class isKindOf "Plane_Fighter_04_Base_F"):
	{
		_mags =
		[
			["magazine_Fighter04_Gun20mm_AA_x250", [-1]],
			["magazine_Fighter04_Gun20mm_AA_x250", [-1]],
			["magazine_Fighter04_Gun20mm_AA_x250", [-1]],
			["magazine_Fighter04_Gun20mm_AA_x250", [-1], 150],
			["Laserbatteries", [-1]],
			["300Rnd_CMFlare_Chaff_Magazine", [-1]]
		];
		switch (_variant) do
		{
			case "gryphonAA": {
				_pylons = ["PylonRack_Missile_AMRAAM_C_x1", "PylonRack_Missile_AMRAAM_C_x1", "PylonRack_Missile_AMRAAM_C_x2", "PylonRack_Missile_AMRAAM_C_x2", "PylonRack_Missile_AMRAAM_C_x2", "PylonRack_Missile_AMRAAM_C_x2"];
				_customCode =
				{
					_veh removeMagazinesTurret ["PylonRack_Missile_BIM9X_x2", [-1]];
					_veh removeWeaponTurret ["weapon_BIM9xLauncher", [-1]];
					_veh addWeaponTurret ["weapon_BIM9xLauncher", [-1]];
					_veh addMagazineTurret ["PylonRack_Missile_BIM9X_x2", [-1], 2];
					_veh addMagazineTurret ["PylonRack_Missile_BIM9X_x2", [-1], 2];
					_veh addMagazineTurret ["PylonRack_Missile_BIM9X_x2", [-1], 2];
				};
			};
			case "gryphonCAS": {
				_pylons = ["PylonRack_Missile_AMRAAM_C_x1", "PylonRack_Missile_AMRAAM_C_x1", "PylonRack_Missile_AGM_02_x1", "PylonRack_Missile_AGM_02_x1", "PylonMissile_Missile_AGM_02_x2", "PylonMissile_Missile_AGM_02_x2"];
				_customCode =
				{
					_veh removeMagazinesTurret ["PylonRack_Missile_BIM9X_x2", [-1]];
					_veh removeWeaponTurret ["weapon_BIM9xLauncher", [-1]];
					_veh addWeaponTurret ["weapon_BIM9xLauncher", [-1]];
					_veh addMagazineTurret ["PylonRack_Missile_BIM9X_x2", [-1], 2];
					_veh removeMagazinesTurret ["PylonRack_Bomb_GBU12_x2", [-1]];
					_veh removeWeaponTurret ["weapon_GBU12Launcher", [-1]];
					_veh addWeaponTurret ["weapon_GBU12Launcher", [-1]];
					_veh addMagazineTurret ["PylonRack_Bomb_GBU12_x2", [-1], 2];
					_veh addMagazineTurret ["PylonRack_Bomb_GBU12_x2", [-1], 2];
					_veh removeMagazinesTurret ["PylonRack_2Rnd_BombCluster_01_F", [-1]];
					_veh removeWeaponTurret ["BombCluster_01_F", [-1]];
					_veh addWeaponTurret ["BombCluster_01_F", [-1]];
					_veh addMagazineTurret ["PylonRack_2Rnd_BombCluster_01_F", [-1], 2];
					_veh addMagazineTurret ["PylonRack_2Rnd_BombCluster_01_F", [-1], 2];
				};
			};
		};
	};

	// Greyhawk/Ababil UAVs
	case (_class isKindOf "UAV_02_dynamicLoadout_base_F"):
	{
		switch (_variant) do
		{
			case "greyhawkBomber": { _pylons = ["PylonRack_Bomb_GBU12_x2","PylonRack_Bomb_GBU12_x2"] };
			case "greyhawkCluster": { _pylons = ["PylonRack_2Rnd_BombCluster_01_F","PylonRack_2Rnd_BombCluster_01_F"] };
			case "greyhawkDAGR":    { _pylons = ["PylonRack_12Rnd_PG_missiles","PylonWeapon_2000Rnd_65x39_belt"] };
			default
			{
				_pylons = ["PylonRack_3Rnd_LG_scalpel","PylonRack_3Rnd_LG_scalpel"];
				_customCode =
				{
					_veh setAmmoOnPylon [1, 2]; // right wing
					_veh setAmmoOnPylon [2, 2]; // left wing
				};
			};
		};
	};

	// KH-3A Fenghuang UAV
	/*case (_class isKindOf "O_T_UAV_04_CAS_F"):
	{
		_customCode =
		{
			_veh setMagazineTurretAmmo ["4Rnd_LG_Jian", 2, [0]];
		};
	};*/

	// UCAV Sentinel
	case (_class isKindOf "B_UAV_05_F"):
	{
		_mags =
		[
			["120Rnd_CMFlare_Chaff_Magazine", [-1]],
			["magazine_Fighter04_Gun20mm_AA_x250", [-1]],
			["Laserbatteries", [0]]
		];
		_weapons =
		[
			["CMFlareLauncher", [-1]],
			["weapon_Fighter_Gun20mm_AA", [-1]],
			["Laserdesignator_mounted", [0]]
		];
		switch (_variant) do
		{
			case "sentinelBomber": { _pylons = ["PylonRack_Bomb_GBU12_x2","PylonRack_Bomb_GBU12_x2"] };
			case "sentinelCluster": { _pylons = ["PylonRack_2Rnd_BombCluster_01_F","PylonRack_2Rnd_BombCluster_01_F"] };
			default { _pylons = ["PylonMissile_Missile_AGM_02_x2","PylonMissile_Missile_AGM_02_x2"] };
		};
	};

	// MQ-12 Falcon UAV (non-dynamicLoadout)
	case (_class isKindOf "B_T_UAV_03_F"):
	{
		_mags =
		[
			["120Rnd_CMFlare_Chaff_Magazine", [-1]],
			["1000Rnd_65x39_Belt_Green", [0]],
			["24Rnd_missiles", [0]],
			["2Rnd_LG_scalpel", [0]],
			["2Rnd_AAA_missiles", [0]],
			["Laserbatteries", [0]]
		];
		_weapons =
		[
			["CMFlareLauncher", [-1]],
			["LMG_M200", [0]],
			["missiles_DAR", [0]],
			["missiles_SCALPEL", [0]],
			["missiles_ASRAAM", [0]],
			["Laserdesignator_mounted", [0]]
		];
	};

	// ED-1D Demining UGV
	case (_class isKindOf "UGV_02_Demining_Base_F"):
	{
		_mags =
		[
			["200Rnd_556x45_Box_F", [0]],
			["15Rnd_12Gauge_Pellets", [0]],
			["15Rnd_12Gauge_Slug", [0]],
			["Laserbatteries", [0]],
			["SmokeLauncherMag", [0]]
		];
		_weapons =
		[
			["LMG_03_Vehicle_F", [0]],
			["DeminingDisruptor_01_F", [0]],
			["Laserdesignator_mounted", [0]],
			["SmokeLauncher", [0]]
		];
	};

	// SDV SDAR turret
	case (_class isKindOf "SDV_01_base_F"):
	{
		_mags =
		[
			["20Rnd_556x45_UW_mag", [0]],
			["20Rnd_556x45_UW_mag", [0]],
			["20Rnd_556x45_UW_mag", [0]],
			["20Rnd_556x45_UW_mag", [0]],
			["20Rnd_556x45_UW_mag", [0]],
			["20Rnd_556x45_UW_mag", [0]],
			["30Rnd_556x45_Stanag", [0]],
			["30Rnd_556x45_Stanag", [0]],
			["30Rnd_556x45_Stanag", [0]],
			["Laserbatteries", [0]]
		];
		_weapons =
		[
			["arifle_SDAR_F", [0]],
			["Laserdesignator_mounted", [0]]
		];
	};
	
	case(_class isKindOf "B_MBT_01_TUSK_F"):
	{
		switch(_variant) do
		{
			case "tough":
			{
				_customCode = {_veh setVariable ["vehicle_tough", true, true];};
			};
			default {};
		};
	};
};
